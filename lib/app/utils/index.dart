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

double edgeByWidth({
  required BuildContext context,
  required double xs,
  required double sm,
  required double md,
  required double lg,
  required double xl,
}) {
  if (MediaQuery.of(context).size.width >= 1920) {
    return xl;
  } else if (MediaQuery.of(context).size.width >= 1280) {
    return lg;
  } else if (MediaQuery.of(context).size.width >= 960) {
    return md;
  } else if (MediaQuery.of(context).size.width >= 600) {
    return sm;
  } else {
    return xs;
  }
}

bool visibilityByWidth({
  required BuildContext context,
  required bool xs,
  required bool sm,
  required bool md,
  required bool lg,
  required bool xl,
}) {
  if (MediaQuery.of(context).size.width >= 1920) {
    return xl;
  } else if (MediaQuery.of(context).size.width >= 1280) {
    return lg;
  } else if (MediaQuery.of(context).size.width >= 960) {
    return md;
  } else if (MediaQuery.of(context).size.width >= 600) {
    return sm;
  } else {
    return xs;
  }
}

// prepare phone number is country code exist
String modifyPhoneNumber(String phone) {
  var newPhone = phone;
  if (newPhone.substring(0, 1) == '0') {
    newPhone = newPhone.replaceFirst('0', '62');
  } else if (newPhone.substring(0, 1) == '+') {
    newPhone = newPhone.replaceFirst('+', '');
  } else {
    newPhone = '62$phone';
  }

  return newPhone;
}
