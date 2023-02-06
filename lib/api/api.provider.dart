import 'dart:convert';

import 'package:wedding/repositories.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('${ApiConfig.username}:${ApiConfig.password}'))}';

    httpClient.followRedirects = true;
    httpClient.baseUrl = ApiConfig.baseUrl;
    httpClient.defaultContentType = 'application/x-www-form-urlencoded';
    httpClient.timeout = const Duration(seconds: 60);
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Accept'] = '*/*';

      request.headers['authorization'] = 'Basic $basicAuth';
      return request;
    });
    httpClient.maxAuthRetries = 3;
  }

  Future<String> checkWhatsApp({required String phone}) async {
    final form = FormData({
      'nomor_wa': phone,
    });

    final response = await post(ApiEndPoints.checkWhatsApp, form);
    try {
      if (response.status.hasError) {
        return Future.error('Terjadi kesalahan, silahkan coba lagi');
      } else {
        if (response.body['status'] == false) {
          return Future.error(response.body['message'] ??
              'Terjadi kesalahan saat mengunggah bukti pembayaran');
        } else {
          return Future.value(response.body['nama'] ?? '');
        }
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }
}
