import 'package:wedding/repositories.dart';

bool validatePhoneNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^\+?([ -]?\d+)+|\(\d+\)([ -]\d+)$');
  return regex.hasMatch(phoneNumber);
}

ApiProvider getApiProvider = Get.isRegistered<ApiProvider>()
    ? Get.find<ApiProvider>()
    : Get.put(ApiProvider());
