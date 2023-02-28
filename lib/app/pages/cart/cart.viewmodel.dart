import 'dart:developer';

import 'package:wedding/repositories.dart';

class CartViewModel extends ViewModel {
  final box = GetStorage();
  late SweetDialog loading;
  late ApiProvider apiProvider;

  int _reservasionID = 0;
  int get reservasionID => _reservasionID;
  set reservasionID(int value) {
    _reservasionID = value;
    notifyListeners();
    getMember(reservasionID: value);
  }

  List<CartModel> _cart = List<CartModel>.empty(growable: true);
  List<CartModel> get cart => _cart;
  set cart(List<CartModel> value) {
    _cart = value;
    notifyListeners();

    reservasionID = box.read<int>('reservasionID') ?? 0;
  }

  List<MemberModel> _members = List<MemberModel>.empty(growable: true);
  List<MemberModel> get members => _members;
  set members(List<MemberModel> value) {
    _members = value;
    notifyListeners();

    checkFoodsMember(cart, '1');
    checkFoodsMember(cart, '2');
    checkFoodsMember(cart, '3');
    checkFoodsMember(cart, '4');
  }

  List<CategoryModel> categories = [
    CategoryModel(
        categoryID: '1',
        categoryName: 'Appetizer',
        categoryIcon: 'assets/icons/svg/appetizer.svg'),
    CategoryModel(
        categoryID: '2',
        categoryName: 'Main Course',
        categoryIcon: 'assets/icons/svg/main.svg'),
    CategoryModel(
        categoryID: '3',
        categoryName: 'Dessert',
        categoryIcon: 'assets/icons/svg/dessert.svg'),
    CategoryModel(
        categoryID: '4',
        categoryName: 'Drink',
        categoryIcon: 'assets/icons/svg/drink.svg'),
  ];

  String _mainCourseNotSelected = '';
  String get mainCourseNotSelected => _mainCourseNotSelected;
  set mainCourseNotSelected(String value) {
    _mainCourseNotSelected = value;
    notifyListeners();
  }

  String _dessertNotSelected = '';
  String get dessertNotSelected => _dessertNotSelected;
  set dessertNotSelected(String value) {
    _dessertNotSelected = value;
    notifyListeners();
  }

  String _drinkNotSelected = '';
  String get drinkNotSelected => _drinkNotSelected;
  set drinkNotSelected(String value) {
    _drinkNotSelected = value;
    notifyListeners();
  }

  String _appetizerNotSelected = '';
  String get appetizerNotSelected => _appetizerNotSelected;
  set appetizerNotSelected(String value) {
    _appetizerNotSelected = value;
    notifyListeners();
  }

  void checkFoodsMember(List<CartModel> cart, String categoryID) {
    if (categoryID == '1') {
      appetizerNotSelected = '';
    }

    if (categoryID == '2') {
      mainCourseNotSelected = '';
    }

    if (categoryID == '3') {
      dessertNotSelected = '';
    }

    if (categoryID == '4') {
      drinkNotSelected = '';
    }

    // add member name if member not selected this menu category
    if (cart.isEmpty) {
      for (var itemMember in members) {
        if (categoryID == '1') {
          if (appetizerNotSelected.isEmpty) {
            appetizerNotSelected = itemMember.memberName!;
          } else {
            appetizerNotSelected =
                '$appetizerNotSelected, ${itemMember.memberName}';
          }
        } else if (categoryID == '2') {
          if (mainCourseNotSelected.isEmpty) {
            mainCourseNotSelected = itemMember.memberName!;
          } else {
            mainCourseNotSelected =
                '$mainCourseNotSelected, ${itemMember.memberName}';
          }
        } else if (categoryID == '3') {
          if (dessertNotSelected.isEmpty) {
            dessertNotSelected = itemMember.memberName!;
          } else {
            dessertNotSelected =
                '$dessertNotSelected, ${itemMember.memberName}';
          }
        } else {
          if (drinkNotSelected.isEmpty) {
            drinkNotSelected = itemMember.memberName!;
          } else {
            drinkNotSelected = '$drinkNotSelected, ${itemMember.memberName}';
          }
        }
      }
    } else {
      for (var element in cart) {
        if (element.menu!.categoryID == categoryID) {
          for (var itemMember in members) {
            final check = element.members!
                .where((element) => element.memberID == itemMember.memberID);
            if (check.isEmpty) {
              if (categoryID == '1') {
                if (appetizerNotSelected.isEmpty) {
                  appetizerNotSelected = itemMember.memberName!;
                } else {
                  appetizerNotSelected =
                      '$appetizerNotSelected, ${itemMember.memberName}';
                }
              } else if (categoryID == '2') {
                if (mainCourseNotSelected.isEmpty) {
                  mainCourseNotSelected = itemMember.memberName!;
                } else {
                  mainCourseNotSelected =
                      '$mainCourseNotSelected, ${itemMember.memberName}';
                }
              } else if (categoryID == '3') {
                if (dessertNotSelected.isEmpty) {
                  dessertNotSelected = itemMember.memberName!;
                } else {
                  dessertNotSelected =
                      '$dessertNotSelected, ${itemMember.memberName}';
                }
              } else {
                if (drinkNotSelected.isEmpty) {
                  drinkNotSelected = itemMember.memberName!;
                } else {
                  drinkNotSelected =
                      '$drinkNotSelected, ${itemMember.memberName}';
                }
              }
            }
          }
        }
      }
    }

    // // check if member selected this menu category
    // final checkCategory =
    //     cart.where((element) => element.menu!.categoryID == categoryID);
    // if (checkCategory.isEmpty) {
    //   // member not selected this menu
    //   for (var itemMember in members) {
    //     if (categoryID == '1') {
    //       if (appetizerNotSelected.isEmpty) {
    //         appetizerNotSelected = itemMember.memberName!;
    //       } else {
    //         appetizerNotSelected =
    //             '$appetizerNotSelected, ${itemMember.memberName}';
    //       }
    //     } else if (categoryID == '2') {
    //       if (mainCourseNotSelected.isEmpty) {
    //         mainCourseNotSelected = itemMember.memberName!;
    //       } else {
    //         mainCourseNotSelected =
    //             '$mainCourseNotSelected, ${itemMember.memberName}';
    //       }
    //     } else if (categoryID == '3') {
    //       if (dessertNotSelected.isEmpty) {
    //         dessertNotSelected = itemMember.memberName!;
    //       } else {
    //         dessertNotSelected =
    //             '$dessertNotSelected, ${itemMember.memberName}';
    //       }
    //     } else {
    //       if (drinkNotSelected.isEmpty) {
    //         drinkNotSelected = itemMember.memberName!;
    //       } else {
    //         drinkNotSelected = '$drinkNotSelected, ${itemMember.memberName}';
    //       }
    //     }
    //   }
    // }

    // for (var itemCart in cart) {
    //   if (itemCart.members!.length != members.length) {
    //     // member not selected this menu
    //     for (var itemMember in members) {
    //       final check = itemCart.members!
    //           .where((element) => element.memberID == itemMember.memberID);
    //       if (check.isEmpty) {
    //         if (itemCart.menu!.categoryID == '1') {
    //           if (appetizerNotSelected.isEmpty) {
    //             appetizerNotSelected = itemMember.memberName!;
    //           } else {
    //             appetizerNotSelected =
    //                 '$appetizerNotSelected, ${itemMember.memberName}';
    //           }
    //         } else if (itemCart.menu!.categoryID == '2') {
    //           if (mainCourseNotSelected.isEmpty) {
    //             mainCourseNotSelected = itemMember.memberName!;
    //           } else {
    //             mainCourseNotSelected =
    //                 '$mainCourseNotSelected, ${itemMember.memberName}';
    //           }
    //         } else if (itemCart.menu!.categoryID == '3') {
    //           if (dessertNotSelected.isEmpty) {
    //             dessertNotSelected = itemMember.memberName!;
    //           } else {
    //             dessertNotSelected =
    //                 '$dessertNotSelected, ${itemMember.memberName}';
    //           }
    //         } else {
    //           if (drinkNotSelected.isEmpty) {
    //             drinkNotSelected = itemMember.memberName!;
    //           } else {
    //             drinkNotSelected =
    //                 '$drinkNotSelected, ${itemMember.memberName}';
    //           }
    //         }
    //       }
    //     }
    //   }
    // }
  }

  void getMember({required int reservasionID}) async {
    await apiProvider.getMember(reservasionID: reservasionID.toString()).then(
      (value) {
        members = value;
        log('Success: ${value.length}', name: 'getMember');
      },
      onError: (e) {
        log('Error: $e', name: 'getMember');
        members = List<MemberModel>.empty(growable: true);
      },
    );
  }

  void confirmSubmit() {
    SweetDialog(
        context: context,
        dialogType: SweetDialogType.warning,
        title: 'Konfirmasi',
        content: 'Apakah anda yakin ingin mengirim pesanan?',
        confirmText: 'Ya',
        cancelText: 'Tidak',
        onConfirm: () {
          submitMenu();
        }).show();
  }

  void submitMenu() async {
    loading.show();
    Future.delayed(const Duration(seconds: 2), () {
      apiProvider.submitMenu(reservasionID: reservasionID, cart: cart).then(
        (value) {
          loading.dismiss();
          log('Success: $value', name: 'submitMenu');
          SweetDialog(
            context: context,
            dialogType: SweetDialogType.success,
            title: 'Berhasil',
            content: 'Pesanan berhasil dikirim',
            barrierDismissible: false,
            onConfirm: () {
              box.remove('cart');
              cart = List<CartModel>.empty(growable: true);
              appetizerNotSelected = '';
              mainCourseNotSelected = '';
              dessertNotSelected = '';
              drinkNotSelected = '';
              Get.offAllNamed('/');
            },
          ).show();
        },
        onError: (e) {
          loading.dismiss();
          log('Error: $e', name: 'submitMenu');
          SweetDialog(
            context: context,
            dialogType: SweetDialogType.error,
            title: 'Gagal',
            content: e,
          ).show();
        },
      );
    });
  }

  @override
  void init() {
    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
    );
    apiProvider = getApiProvider;
    if (box.hasData('cart')) {
      cart = box.read<List<CartModel>>('cart') ?? [];
    }
  }

  @override
  void onDependenciesChange() {}

  @override
  void onBuild() {}

  @override
  void onMount() {}

  @override
  void onUnmount() {}

  @override
  void onResume() {}

  @override
  void onPause() {}

  @override
  void onInactive() {}

  @override
  void onDetach() {}
}
