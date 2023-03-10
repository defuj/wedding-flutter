import 'dart:convert';
import 'dart:developer';

import 'package:wedding/repositories.dart';

bool validatePhoneNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^\+?([ -]?\d+)+|\(\d+\)([ -]\d+)$');
  return regex.hasMatch(phoneNumber);
}

ApiProvider getApiProvider = Get.isRegistered<ApiProvider>()
    ? Get.find<ApiProvider>()
    : Get.put(ApiProvider());

// capitalize every first letter of a word
String capitalize(String s) {
  if (s.length > 1) {
    return s[0].toUpperCase() + s.substring(1);
  } else {
    return s.toUpperCase();
  }
}

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
String modifyPhoneNumber(String number) {
  if (number.startsWith("0")) {
    // Replace 0 with 62
    return "62${number.substring(1)}";
  } else if (number.startsWith("+")) {
    // Return unaltered
    return modifyPhoneNumber(number.substring(1));
  } else if (number.startsWith("62")) {
    // Return unaltered
    return number;
  } else {
    return number;
  }
}

String trimEndSpace(String s) {
  int i = s.length;

  while (i > 0 && s[i - 1] == ' ') {
    i--;
  }
  return s.substring(0, i);
}

List<CartModel> getCartListFromBox(List<dynamic> cart) {
  List<CartModel> temp = List<CartModel>.empty(growable: true);
  for (var element in cart) {
    log('element cart');
    log(jsonEncode(element));
    log('element menu');
    log(jsonEncode(element['menu']));
    log('element note');
    log(jsonEncode(element['note']));

    var member = List<MemberModel>.empty(growable: true);
    for (var elementMember in element['members']) {
      log('element member');
      log(jsonEncode(elementMember));
      member.add(MemberModel.fromJson(elementMember));
    }

    var menu = MenuModel(
      menuID: element['menu']['id'],
      categoryID: element['menu']['id_kategori'],
      menuName: element['menu']['nama_menu'],
      menuDesc: element['menu']['deskripsi'],
      menuCoverPicture: element['menu']['img_cover'],
      menuPicture1: element['menu']['img_second'],
      menuPicture2: element['menu']['img_third'],
      menuStock: int.parse(element['menu']['stok'] ?? '100'),
    );

    temp.add(CartModel(
      menu: menu,
      note: jsonEncode(element['note']),
      members: member,
    ));
  }
  return temp;
}
