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
      final token =
          'Basic ${base64.encode(utf8.encode('${ApiConfig.username}:${ApiConfig.password}'))}';
      request.headers['Authorization'] = token;
      request.headers['Accept'] = '*/*';
      request.headers['Access-Control-Allow-Origin'] = '*';
      request.headers['Access-Control-Allow-Methods'] = '*';
      return request;
    });

    httpClient.maxAuthRetries = 3;
  }

  Future<String> submitMenu({
    required int reservasionID,
    required List<CartModel> cart,
  }) async {
    try {
      Map<String, Map<String, dynamic>> category = {};
      cart.map((e) {
        category['${e.menu!.categoryID}'] = {
          'id_menu': e.menu!.menuID,
          'catatan': e.note,
          'id_anggota': e.members!.map((e) => '${e.memberID}').toList(),
        };
      });

      final data = {
        'id_reservasi': reservasionID,
        'data': [category],
      };
      final response = await request(
        ApiEndPoints.submitMenus,
        'POST',
        body: data,
        contentType: 'application/json',
      );
      if (response.status.hasError) {
        return Future.error(
            response.statusText ?? 'Terjadi kesalahan saat mengirim pesanan');
      } else {
        if (response.body['status'] == false) {
          return Future.error(
              response.body['message'] ?? 'Gagal mengirim pesanan');
        } else {
          return Future.value(
              response.body['message'] ?? 'Pesanan berhasil dikirim');
        }
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<CommentModel>> fetchComment() async {
    try {
      final response = await get(ApiEndPoints.getComments);
      if (response.status.hasError) {
        return Future.error(
            response.statusText ?? 'Terjadi kesalahan saat memuat komentar');
      } else {
        if (response.body['status'] == false) {
          return Future.error(response.body['message'] ?? 'Tidak ada komentar');
        } else {
          final comments = response.body['data'] as List;
          return comments.map((e) => CommentModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> sendComment({
    required String name,
    required String comment,
  }) async {
    final data = {
      'full_name': name,
      'comment': comment,
    };
    try {
      final response = await request(
        ApiEndPoints.submitComment,
        'POST',
        contentType: 'application/json',
        body: data,
      );
      log('result: ${response.body}');
      log('result: ${response.statusCode}');
      if (response.status.hasError) {
        return Future.error(
            response.statusText ?? 'Terjadi kesalahan saat mengirim komentar');
      } else {
        if (response.body['status'] == false) {
          return Future.error(response.body['message']);
        } else {
          return Future.value(response.body['message']);
        }
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Map<String, dynamic>> checkPhoneNumber(
      {required String phoneNumber}) async {
    var phone = modifyPhoneNumber(phoneNumber);

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
            'invitationID': response.body['id_undangan'],
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

  Future<int> createReservasion({
    required String name,
    required String phoneNumber,
    required int id,
    required String nickname,
  }) async {
    var phone = modifyPhoneNumber(phoneNumber);
    final data = FormData({
      'nama': name,
      'nomor_wa': phone,
      'force': 0,
      'panggilan': nickname,
      'id_undangan': id,
    });
    log('reservasi with : $phone');

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
    required int sessionID,
    required List<MemberModel> members,
  }) async {
    List<Map<String, String>> anggotas =
        List<Map<String, String>>.empty(growable: true);
    for (var i = 0; i < members.length; i++) {
      anggotas.add({
        'nama': members[i].memberName!,
        'panggilan': members[i].nickname!,
      });
    }

    // httpClient.defaultContentType = 'application/json';
    final data = {
      'id_reservasi': reservasionID,
      'id_sesi': sessionID,
      'anggota': anggotas,
    };

    try {
      final response = await request(
        ApiEndPoints.addMember,
        'POST',
        body: data,
        contentType: 'application/json',
      );
      log('result: $response');
      if (response.status.hasError) {
        return Future.error(response.statusText ??
            'Terjadi kesalahan saat menambahkan anggota');
      } else {
        if (response.body['status'] == false) {
          return Future.error(
              response.body['message'] ?? 'Gagal menambahkan anggota');
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
      log('result: ${response.body}');
      if (response.status.hasError) {
        return Future.error(response.statusText ??
            'Terjadi kesalahan saat mengambil data anggota');
      } else {
        if (response.body['status'] == false) {
          return Future.error(response.body['message'] ?? 'Tidak ada anggota');
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
