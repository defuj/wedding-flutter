import 'package:wedding/repositories.dart';

bool validatePhoneNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^\+?([ -]?\d+)+|\(\d+\)([ -]\d+)$');
  return regex.hasMatch(phoneNumber);
}

ApiProvider getApiProvider = Get.isRegistered<ApiProvider>()
    ? Get.find<ApiProvider>()
    : Get.put(ApiProvider());

// capitalize every first letter of a word
String capitalize(String s) => s.split(' ').map((str) {
      return str[0].toUpperCase() + str.substring(1);
    }).join(' ');
