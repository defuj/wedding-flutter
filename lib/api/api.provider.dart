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
      request.headers['Authorization'] =
          'Basic ${base64.encode(utf8.encode('${ApiConfig.username}:${ApiConfig.password}'))}';
      return request;
    });

    // httpClient.addResponseModifier<dynamic>((request, response) {
    //   if (response.statusCode == 401) {
    //     log('result: Unauthorized');
    //   }
    //   return response;
    // });

    httpClient.addAuthenticator<dynamic>((request) async {
      log('result: Authenticating');
      //   request.headers['Authorization'] = 'Basic ZndlYjp3MUQ0JEBzNTUwRXFHaHo=';
      request.headers['Authorization'] =
          'Basic ${base64.encode(utf8.encode('${ApiConfig.username}:${ApiConfig.password}'))}';
      return request;
    });

    httpClient.maxAuthRetries = 3;
  }

  Future<String> checkPhoneNumber({required String phone}) async {
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
      if (response.status.hasError) {
        return Future.error(response.statusText ??
            'Terjadi kesalahan saat memeriksa nomor telepon');
      } else {
        return Future.value(response.body['nama'] ?? '');
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }

//   Future<dynamic> checkWhatsApp({required String phone}) async {
//     if (phone.substring(0, 1) == '0') {
//       phone = phone.replaceFirst('0', '62');
//     } else if (phone.substring(0, 1) == '+') {
//       phone = phone.replaceFirst('+', '');
//     } else {
//       phone = '62$phone';
//     }

//     try {
//       // Basic ZndlYjp3MUQ0JEBzNTUwRXFHaHo=
//       final token =
//           'Basic ${base64.encode(utf8.encode('${ApiConfig.username}:${ApiConfig.password}'))}';
//       const targetUrl = '${ApiConfig.baseUrl}${ApiEndPoints.checkWhatsApp}';
//       final response = await http.post(
//         Uri.parse(targetUrl),
//         body: {'nomor_wa': phone},
//         headers: {
//           'Authorization': token,
//         },
//       );
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['status'] == false) {
//           return Future.error(data['message'] ??
//               'Terjadi kesalahan saat memeriksa nomor telepon');
//         } else {
//           return Future.value(data['nama'] ?? '');
//         }
//       } else {
//         return Future.error('Terjadi kesalahan, silahkan coba lagi');
//       }
//       //   var dio = Dio();
//       //   const url = '${ApiConfig.baseUrl}${ApiEndPoints.checkWhatsApp}';
//       //   log('result: $url');
//       //   final response = await dio.post(
//       //     url,
//       //     data: form,
//       //     options: Options(
//       //       headers: {
//       //         // 'Accept': '*/*',
//       //         'content-type': Headers.formUrlEncodedContentType,
//       //         'Authorization': token,
//       //       },
//       //     ),
//       //   );

//       //   if (response.statusCode == 200) {
//       //     if (response.data['status'] == false) {
//       //       return Future.error(response.data['message'] ??
//       //           'Terjadi kesalahan saat memeriksa nomor telepon');
//       //     } else {
//       //       return Future.value(response.data['nama'] ?? '');
//       //     }
//       //   } else {
//       //     return Future.error('Terjadi kesalahan, silahkan coba lagi');
//       //   }

//     } catch (e) {
//       return Future.error('Error: $e');
//     }

//     // try {
//     //   final response = await dio().request(ApiEndPoints.checkWhatsApp,
//     //       data: form, options: Options(method: 'POST'));
//     //   if (response.statusCode == 200) {
//     //     if (response.data['status'] == false) {
//     //       return Future.error(response.data['message'] ??
//     //           'Terjadi kesalahan saat memeriksa nomor telepon');
//     //     } else {
//     //       return Future.value(response.data['nama'] ?? '');
//     //     }
//     //   } else {
//     //     return Future.error('Terjadi kesalahan, silahkan coba lagi');
//     //   }
//     // } catch (e) {
//     //   return Future.error('Error: $e');
//     // }
//   }
}
