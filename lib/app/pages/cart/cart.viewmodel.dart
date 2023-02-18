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
    checkFoodsMember();
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

  void checkFoodsMember() {
    appetizerNotSelected = '';
    mainCourseNotSelected = '';
    dessertNotSelected = '';
    drinkNotSelected = '';
    log('checkFoodsMember - member: ${members.length}');
    log('checkFoodsMember - cart: ${cart.length}');
    cart.map((itemCart) {
      if (itemCart.members!.length != members.length) {
        // member not selected this menu
        members.map((itemMember) {
          final check = members
              .where((element) => element.memberID == itemMember.memberID);
          if (check.isEmpty) {
            if (itemCart.menu!.menuID == '1') {
              if (appetizerNotSelected.isEmpty) {
                appetizerNotSelected = itemMember.memberName!;
              } else {
                appetizerNotSelected =
                    '$appetizerNotSelected, ${itemMember.memberName}';
              }
            } else if (itemCart.menu!.menuID == '2') {
              if (mainCourseNotSelected.isEmpty) {
                mainCourseNotSelected = itemMember.memberName!;
              } else {
                mainCourseNotSelected =
                    '$mainCourseNotSelected, ${itemMember.memberName}';
              }
            } else if (itemCart.menu!.menuID == '3') {
              if (dessertNotSelected.isEmpty) {
                dessertNotSelected = itemMember.memberName!;
              } else {
                dessertNotSelected =
                    '$dessertNotSelected, ${itemMember.memberName}';
              }
            } else if (itemCart.menu!.menuID == '4') {
              if (drinkNotSelected.isEmpty) {
                drinkNotSelected = itemMember.memberName!;
              } else {
                drinkNotSelected =
                    '$drinkNotSelected, ${itemMember.memberName}';
              }
            }
          }
        });
      }
    });
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

  void submitMenu() async {
    loading.show();
    Future.delayed(const Duration(seconds: 3), () {
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
    try {
      if (box.read('cart') != null) {
        cart = box.read('cart');
      } else {
        cart = List<CartModel>.empty(growable: true);
      }
      reservasionID = box.read('reservasionID') ?? 0;
      getMember(reservasionID: reservasionID);
    } catch (e) {
      cart = List<CartModel>.empty(growable: true);
      reservasionID = box.read('reservasionID') ?? 0;
      getMember(reservasionID: reservasionID);
    }

    // try {
    //   reservasionID = box.read('reservasionID') ?? 0;
    //   getMember(reservasionID: reservasionID);
    // } catch (e) {
    //   reservasionID = 0;
    //   getMember(reservasionID: reservasionID);
    // }
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
