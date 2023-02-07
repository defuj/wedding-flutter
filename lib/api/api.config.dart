class ApiConfig {
  static const String baseUrl = 'https://wo.sadigit.co.id/api/v1';
  static const String username = 'fweb';
  static const String password = 'w1D4\$@s550EqGhz';
}

// Dio dio({String contentType = 'application/x-www-form-urlencoded'}) {
//   final token =
//       'Basic ${base64.encode(utf8.encode('${ApiConfig.username}:${ApiConfig.password}'))}';
//   // or new Dio with a BaseOptions instance.
//   var options = BaseOptions(
//     baseUrl: ApiConfig.baseUrl,
//     connectTimeout: 5000,
//     receiveTimeout: 3000,
//     contentType: contentType,
//     followRedirects: true,
//     headers: {
//       'Accept': '*/*',
//       'Authorization': token,
//     },
//   );
//   return Dio(options);
// }
