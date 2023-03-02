import 'dart:developer';

import 'package:wedding/repositories.dart';

class CartViewModel extends ViewModel {
  final box = GetStorage();
  late SweetDialog loading;
  late ApiProvider apiProvider;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('reservation');

  int _reservationID = 0;
  int get reservationID => _reservationID;
  set reservationID(int value) {
    _reservationID = value;
    notifyListeners();
  }

  List<CartModel> _cart = List<CartModel>.empty(growable: true);
  List<CartModel> get cart => _cart;
  set cart(List<CartModel> value) {
    _cart = value;
    notifyListeners();
  }

  List<MemberModel> _members = List<MemberModel>.empty(growable: true);
  List<MemberModel> get members => _members;
  set members(List<MemberModel> value) {
    _members = value;
    notifyListeners();
  }

  List<CategoryModel> categories = [
    CategoryModel(
        categoryID: '2',
        categoryName: 'Main Course',
        categoryIcon: 'assets/icons/svg/main.svg'),
    CategoryModel(
        categoryID: '1',
        categoryName: 'Appetizer',
        categoryIcon: 'assets/icons/svg/appetizer.svg'),
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

  void memberNotSelectedMenus({
    required List<MemberModel> memberNotSelected,
    required String categoryID,
    required int index,
  }) {
    // reset not selected menu member at index 0 or on first loop
    try {
      if (index == 0) {
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
      }

      var element = memberNotSelected[index];
      if (categoryID == '1') {
        if (appetizerNotSelected.isEmpty) {
          appetizerNotSelected = element.memberName!;
        } else {
          appetizerNotSelected = '$appetizerNotSelected, ${element.memberName}';
        }
      }

      if (categoryID == '2') {
        if (mainCourseNotSelected.isEmpty) {
          mainCourseNotSelected = element.memberName!;
        } else {
          mainCourseNotSelected =
              '$mainCourseNotSelected, ${element.memberName}';
        }
      }

      if (categoryID == '3') {
        if (dessertNotSelected.isEmpty) {
          dessertNotSelected = element.memberName!;
        } else {
          dessertNotSelected = '$dessertNotSelected, ${element.memberName}';
        }
      }

      if (categoryID == '4') {
        if (drinkNotSelected.isEmpty) {
          drinkNotSelected = element.memberName!;
        } else {
          drinkNotSelected = '$drinkNotSelected, ${element.memberName}';
        }
      }

      if (index < members.length - 1) {
        memberNotSelectedMenus(
          memberNotSelected: memberNotSelected,
          categoryID: categoryID,
          index: index + 1,
        );
      }
    } catch (e) {
      log('error: $e');
    }
  }

  void checkFoodsMember({required List<CartModel> cart}) {
    for (var category in categories) {
      // check member not selected this menu category
      // filter cart by categoryID
      var cartWithCategory = cart
          .where((element) => element.menu!.categoryID == category.categoryID);
      log('categoryName: ${category.categoryName}');
      log('categoryID: ${category.categoryID}');
      log('categoryCartLength: ${cartWithCategory.length}');

      if (cartWithCategory.isEmpty) {
        memberNotSelectedMenus(
          memberNotSelected: members,
          categoryID: category.categoryID!,
          index: 0,
        );
      } else {
        if (cartWithCategory.length != members.length) {
          // check every member selected this menu category or not
          List<MemberModel> temp = List<MemberModel>.empty(growable: true);
          for (var member in members) {
            // check this member already selected this menu category
            var notInCart = false;
            for (var menu in cartWithCategory) {
              if (menu.members!
                  .where((el) => el.memberID == member.memberID)
                  .isEmpty) {
                notInCart = true;
              }
            }
            if (notInCart) {
              temp.add(member);
            }
          }

          if (temp.isNotEmpty) {
            memberNotSelectedMenus(
              memberNotSelected: temp,
              categoryID: category.categoryID!,
              index: 0,
            );
          }
        }
      }
    }
  }

  void getMember({required int reservationID}) async {
    await apiProvider.getMember(reservationID: reservationID.toString()).then(
      (value) {
        members = value;
        checkFoodsMember(cart: cart);
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
      apiProvider.submitMenu(reservationID: reservationID, cart: cart).then(
        (value) async {
          loading.dismiss();
          log('Success: $value', name: 'submitMenu');
          await ref.child(modifyPhoneNumber(box.read('phoneNumber'))).update({
            'isFinished': true,
          });
          SweetDialog(
            context: context,
            dialogType: SweetDialogType.success,
            title: 'Berhasil',
            content: 'Pesanan berhasil dikirim',
            barrierDismissible: false,
            onConfirm: () {
              box.remove('cart-$reservationID');
              box.write('$reservationID-alreadyChooseFood', reservationID);
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

  void editMenu(MenuModel menu) {
    log('editMenu: ${menu.toJson()}');
    box.write('menu', menu.toJson());

    Get.toNamed('/menus/detail');
  }

  void reservastionNotFound() {
    SweetDialog(
      context: context,
      dialogType: SweetDialogType.error,
      title: 'Oops!',
      content: 'Tidak menemukan data reservasi',
      barrierDismissible: false,
      confirmText: 'Kembali',
      onConfirm: () => Get.toNamed('/rsvp'),
    ).show();
  }

  void userNotFound() {
    SweetDialog(
      context: context,
      title: 'Oops!',
      content: 'Tidak dapat menemukan data tamu',
      dialogType: SweetDialogType.error,
      barrierDismissible: false,
      confirmText: 'Kembali',
      onConfirm: () => Get.toNamed('/rsvp'),
    ).show();
  }

  void prepareData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("reservation");
    try {
      loading.show();
      if (box.hasData('phoneNumber')) {
        var data =
            await ref.child(modifyPhoneNumber(box.read('phoneNumber'))).once();
        if (data.snapshot.exists) {
          if (data.snapshot.child('reservationID').exists) {
            reservationID = data.snapshot.child('reservationID').value as int;
            if (reservationID != 0) {
              if (data.snapshot.hasChild('menus')) {
                final result =
                    data.snapshot.child('menus').value as Map<dynamic, dynamic>;
                var temp = List<CartModel>.empty(growable: true);
                result.forEach((key, value) {
                  final map = value as Map<dynamic, dynamic>;
                  temp.add(CartModel(
                    menu: MenuModel.fromJson(map['menu']),
                    members: (map['members'] as List)
                        .map((e) => MemberModel.fromJson(e))
                        .toList(),
                    note: map['note'],
                  ));
                });
                cart = temp;
                getMember(reservationID: reservationID);
              }

              loading.dismiss();
            } else {
              loading.dismiss();
              reservastionNotFound();
            }
          } else {
            loading.dismiss();
            reservastionNotFound();
          }
        } else {
          loading.dismiss();
          reservastionNotFound();
        }
      } else {
        loading.dismiss();
        userNotFound();
      }
    } catch (e) {
      loading.dismiss();
      reservastionNotFound();
    }
  }

  @override
  void init() {
    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
    );
    apiProvider = getApiProvider;

    if (box.hasData('phoneNumber')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        prepareData();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        reservastionNotFound();
      });
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
