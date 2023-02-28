import 'dart:developer';

import 'package:wedding/repositories.dart';

class MenusViewModel extends ViewModel {
  late SweetDialog loading;
  late ApiProvider apiProvider;
  final box = GetStorage();

  int _cartCount = 0;
  int get cartCount => _cartCount;
  set cartCount(int value) {
    _cartCount = value;
    notifyListeners();
  }

  List<MemberModel> _members = List<MemberModel>.empty(growable: true);
  List<MemberModel> get members => _members;
  set members(List<MemberModel> value) {
    _members = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _userName = '';
  String get userName => _userName;
  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  int _reservasionID = 0;
  int get reservasionID => _reservasionID;
  set reservasionID(int value) {
    _reservasionID = value;
    notifyListeners();
  }

  int _sessionID = 0;
  int get sessionID => _sessionID;
  set sessionID(int value) {
    _sessionID = value;
    notifyListeners();
  }

  CategoryModel _categorySelected = CategoryModel(
    categoryID: '2',
    categoryName: 'Main Course',
    categoryIcon: 'assets/icons/svg/main.svg',
  );
  CategoryModel get categorySelected => _categorySelected;
  set categorySelected(CategoryModel value) {
    _categorySelected = value;
    notifyListeners();

    box.write('categorySelected', value.toJson());
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

  List<MenuModel> _menus = List<MenuModel>.empty(growable: true);
  List<MenuModel> get menus => _menus;
  set menus(List<MenuModel> value) {
    _menus = value;
    notifyListeners();
  }

  void getMenus() async {
    isLoading = true;
    await apiProvider.getMenus(categoryID: categorySelected.categoryID!).then(
      (value) {
        isLoading = false;
        menus = value;
      },
      onError: (e) {
        log('Error: $e', name: 'getMenus');
        isLoading = false;
        menus = List<MenuModel>.empty(growable: true);
        // SweetDialog(
        //   context: context,
        //   title: 'Oops!',
        //   content: e.toString(),
        //   dialogType: SweetDialogType.error,
        // ).show();
      },
    ).whenComplete(() {
      getMember(reservasionID: reservasionID);
    });
  }

  void getMember({required int reservasionID}) async {
    await apiProvider.getMember(reservasionID: reservasionID.toString()).then(
      (value) {
        members = value;
      },
      onError: (e) {
        log('Error: $e', name: 'getMember');
        members = List<MemberModel>.empty(growable: true);
      },
    ).whenComplete(() {
      getCart();
    });
  }

  void getCart() async {
    try {
      if (box.hasData('cart')) {
        List<CartModel> cart = box.read('cart') ?? [];
        cartCount = cart.length;
      } else {
        cartCount = 0;
      }
    } catch (e) {
      log('Error $e');
      cartCount = 0;
    }

    box.listenKey('cart', (value) {
      try {
        List<CartModel> cart = value;
        cartCount = cart.length;
      } catch (e) {
        log('Error $e');
        cartCount = 0;
      }
    });
  }

  void loadMenuDetail(MenuModel menu) {
    box.write('menu', menu.toJson());
    box.write('members', members);

    Get.toNamed(
      '/menus/detail',
      arguments: {
        'reservasionID': reservasionID,
        'sessionID': sessionID,
        'menu': menu.toJson(),
        'members': members,
      },
    );
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

  void prepareData() {
    try {
      if (box.hasData('userName') &&
          box.hasData('reservasionID') &&
          box.hasData('sessionID')) {
        userName = box.read('userName');
        reservasionID = box.read('reservasionID');
        sessionID = box.read('sessionID');

        getMenus();
      } else {
        reservastionNotFound();
      }
    } catch (e) {
      reservastionNotFound();
    }

    // final args = Get.arguments;
    // if (args != null) {
    //   try {
    //     log('success get args');
    //     log('args not empty');

    //     userName = args['userName'].toString();
    //     reservasionID = int.parse(args['reservasionID'].toString());
    //     sessionID = int.parse(args['sessionID'].toString());

    //     box.write('userName', userName);
    //     box.write('reservasionID', reservasionID);
    //     box.write('sessionID', sessionID);

    //     Future.delayed(Duration.zero, () {
    //       getMenus();
    //     });
    //   } catch (e) {
    //     log('error get args');
    //     log('Error: $e');
    //     SweetDialog(
    //       context: context,
    //       dialogType: SweetDialogType.error,
    //       title: 'Oops!',
    //       content: 'Tidak menemukan data reservasi',
    //       barrierDismissible: false,
    //       confirmText: 'Kembali',
    //       onConfirm: () => Get.toNamed('/rsvp'),
    //     ).show();
    //   }
    // } else {
    //   log('args empty');
    //   if (box.read('userName') != null &&
    //       box.read('reservasionID') != null &&
    //       box.read('sessionID') != null) {
    //     userName = box.read('userName');
    //     reservasionID = box.read('reservasionID');
    //     sessionID = box.read('sessionID');

    //     Future.delayed(Duration.zero, () {
    //       getMenus();
    //       getMember(reservasionID: box.read('reservasionID'));
    //     });
    //   } else {
    //     try {
    //       Get.toNamed('/rsvp');
    //     } catch (e) {
    //       log('Error: $e');
    //     }
    //   }
    // }
  }

  @override
  void init() {
    apiProvider = getApiProvider;
    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (box.hasData('categorySelected')) {
        categorySelected = CategoryModel.fromJson(box.read('categorySelected'));
      }
      prepareData();
    });
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
