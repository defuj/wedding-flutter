import 'dart:convert';
import 'dart:developer';
import 'package:wedding/repositories.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.followRedirects = true;
    httpClient.baseUrl = ApiConfig.baseUrl;
    httpClient.defaultContentType = 'application/x-www-form-urlencoded';
    httpClient.timeout = const Duration(seconds: 60);
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Accept'] = '*/*';
      // request.headers['Authorization'] = 'Basic ZndlYjp3MUQ0JEBzNTUwRXFHaHo=';
      final token =
          'Basic ${base64.encode(utf8.encode('${ApiConfig.username}:${ApiConfig.password}'))}';
      request.headers['Authorization'] = token;
      request.headers['Access-Control-Allow-Origin'] = '*';
      request.headers['Access-Control-Allow-Methods'] =
          'GET, POST, PUT, DELETE, OPTIONS';
      request.headers['Access-Control-Allow-Headers'] =
          'Content-Type, Authorization';
      return request;
    });

    // httpClient.addResponseModifier<dynamic>((request, response) {
    //   if (response.statusCode == 401) {
    //     log('result: Unauthorized');
    //   }
    //   return response;
    // });

    // httpClient.addAuthenticator<dynamic>((request) async {
    //   log('result: Authenticating');
    //   //   request.headers['Authorization'] = 'Basic ZndlYjp3MUQ0JEBzNTUwRXFHaHo=';
    //   request.headers['Authorization'] =
    //       'Basic ${base64.encode(utf8.encode('${ApiConfig.username}:${ApiConfig.password}'))}';
    //   return request;
    // });

    httpClient.maxAuthRetries = 3;
  }

  Future<Map<String, dynamic>> checkPhoneNumber({required String phone}) async {
    if (phone.substring(0, 1) == '0') {
      phone = phone.replaceFirst('0', '62');
    } else if (phone.substring(0, 1) == '+') {
      phone = phone.replaceFirst('+', '');
    } else {
      phone = '62$phone';
    }

    try {
      final data = FormData({'nomor_wa': phone});
      final response = await post(
        ApiEndPoints.checkWhatsApp,
        data,
      );
      log('result: ${response.body}');
      if (response.status.hasError) {
        return Future.error(response.statusText ??
            'Terjadi kesalahan saat memeriksa nomor telepon');
      } else {
        if (response.body['status'] == false) {
          return Future.error(response.body['message']);
        } else {
          var result = {
            'userName': response.body['nama'] ?? '',
            'reservasionID': response.body['id_reservasi'] ?? 0,
            'sessionID': response.body['id_sesi'] ?? 0,
          };
          return Future.value(result);
        }
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  Future<List<SessionModel>> getSessions() async {
    try {
      final response = await get(ApiEndPoints.getSessions);
      log('result: ${response.body}');
      if (response.status.hasError) {
        return Future.error(response.statusText ??
            'Terjadi kesalahan saat mengambil data sesi');
      } else {
        if (response.body['status'] == false) {
          return Future.error(
              response.body['message'] ?? 'Tidak ada data sesi');
        } else {
          final sessions = response.body['data'] as List;
          return sessions.map((e) => SessionModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  Future<int> createReservasion(
      {required String name, required String phone}) async {
    final data = FormData({
      'nama': name,
      'nomor_wa': phone,
      'force': 0,
    });

    try {
      final response = await post(ApiEndPoints.submitReservasion, data);
      log('result: ${response.body}');
      if (response.status.hasError) {
        return Future.error(response.statusText ??
            'Terjadi kesalahan saat mengambil data sesi');
      } else {
        if (response.body['status'] == false) {
          return Future.error(
              response.body['message'] ?? 'Gagal membuat reservasi');
        } else {
          return Future.value(response.body['id_reservasi'] ?? 0);
        }
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  Future<String> addMember({
    required int reservasionID,
    required String sessionID,
    required List<MemberModel> members,
  }) async {
    List<Map<String, String>> anggotas = [
      for (var i = 0; i < members.length; i++)
        {
          'nama': members[i].memberName!,
          'panggilan': members[i].nickname!,
        }
    ];
    httpClient.defaultContentType = 'application/json';
    final data = FormData({
      'id_reservasi': reservasionID,
      'id_sesi': sessionID,
      'anggota': anggotas,
    });

    try {
      final response = await post(ApiEndPoints.addMember, data);
      log('result: $response');
      if (response.status.hasError) {
        return Future.error(
            response.statusText ?? 'Terjadi kesalahan saat menambahkan member');
      } else {
        if (response.body['status'] == false) {
          return Future.error(
              response.body['message'] ?? 'Gagal menambahkan member');
        } else {
          return Future.value(response.body['message'] ?? '');
        }
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  Future<List<MenuModel>> getMenus({required String categoryID}) async {
    try {
      final response =
          await get(ApiEndPoints().getMenus(idCategory: categoryID));
      if (response.status.hasError) {
        return Future.error(response.statusText ??
            'Terjadi kesalahan saat mengambil data menu');
      } else {
        if (response.body['status'] == false) {
          return Future.error(
              response.body['message'] ?? 'Tidak ada menu tersedia');
        } else {
          final baseUrl = response.body['base_img_url'].toString();
          final menus = response.body['data'] as List;
          List<MenuModel> menus2 =
              menus.map((e) => MenuModel.fromJson(e)).toList();
          List<MenuModel> menus3 = List<MenuModel>.empty(growable: true);
          for (var element in menus2) {
            menus3.add(MenuModel(
              menuID: element.menuID,
              categoryID: element.categoryID,
              menuName: element.menuName,
              menuDesc: element.menuDesc,
              menuCoverPicture: element.menuCoverPicture!.isNotEmpty
                  ? '$baseUrl${element.menuCoverPicture!}'
                  : '',
              menuPicture1: element.menuPicture1!.isNotEmpty
                  ? '$baseUrl${element.menuPicture1!}'
                  : '',
              menuPicture2: element.menuPicture2!.isNotEmpty
                  ? '$baseUrl${element.menuPicture2!}'
                  : '',
              menuStock: element.menuStock,
            ));
          }
          // add baseUrl to menuCoverPicture, menuPicture1, menuPicture2
          // return menus.map((e) => MenuModel.fromJson(e)).toList();
          return menus3;
        }
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

  Future<List<MemberModel>> getMember({required String reservasionID}) async {
    try {
      final response =
          await get(ApiEndPoints().getMember(reservasionID: reservasionID));
      if (response.status.hasError) {
        return Future.error(response.statusText ??
            'Terjadi kesalahan saat mengambil data menu');
      } else {
        if (response.body['status'] == false) {
          return Future.error(response.body['message'] ?? 'Tidak ada member');
        } else {
          final members = response.body['data'] as List;
          return members.map((e) => MemberModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }
}
