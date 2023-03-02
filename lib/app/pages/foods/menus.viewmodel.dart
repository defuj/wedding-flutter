import 'dart:developer';
import 'package:wedding/repositories.dart';

class MenusViewModel extends ViewModel {
  late SweetDialog loading;
  late ApiProvider apiProvider;
  var box = GetStorage();
  FirebaseDatabase database = FirebaseDatabase.instance;

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

  int _reservationID = 0;
  int get reservationID => _reservationID;
  set reservationID(int value) {
    _reservationID = value;
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
      },
    ).whenComplete(() {
      getMember(reservationID: reservationID);
    });
  }

  void getMember({required int reservationID}) async {
    await apiProvider.getMember(reservationID: reservationID.toString()).then(
      (value) {
        var temp = List<MemberModel>.empty(growable: true);
        for (var element in value) {
          if (element.memberName != null) {
            temp.add(element);
          }
        }
        members = temp;
      },
      onError: (e) {
        log('Error: $e', name: 'getMember');
        members = List<MemberModel>.empty(growable: true);
      },
    );
  }

  void getCart() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("reservation");
    try {
      ref
          .child(modifyPhoneNumber(box.read('phoneNumber')))
          .child('menus')
          .onValue
          .listen((event) {
        var data = event.snapshot;
        if (data.exists) {
          cartCount = data.children.length;
        } else {
          cartCount = 0;
        }
      });
    } catch (e) {
      log('Error $e');
      cartCount = 0;
    }
  }

  void loadMenuDetail(MenuModel menu) async {
    await box.write('menu', menu.toJson());
    await box.write('members-$reservationID', members);
    await Get.toNamed('/menus/detail');

    getCart();

    // await Get.toNamed(
    //   '/menus/detail',
    //   arguments: {
    //     'reservationID': reservationID,
    //     'sessionID': sessionID,
    //     'menu': menu.toJson(),
    //     'members': members,
    //   },
    // );

    // showModalBottomSheet(
    //   constraints: const BoxConstraints(
    //     maxWidth: 475,
    //   ),
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(
    //       top: Radius.circular(16),
    //     ),
    //   ),
    //   isScrollControlled: true,
    //   backgroundColor: Colors.white,
    //   context: context,
    //   builder: ((context) {
    //     return Padding(
    //       padding: EdgeInsets.only(
    //         left: 16,
    //         right: 16,
    //         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
    //       ),
    //       child: const MenuDetail(),
    //     );
    //   }),
    // );
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

  void prepareData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("reservation");
    try {
      loading.show();
      if (box.hasData('phoneNumber')) {
        var data =
            await ref.child(modifyPhoneNumber(box.read('phoneNumber'))).once();
        if (data.snapshot.exists) {
          if (data.snapshot.child('userName').exists) {
            userName = data.snapshot.child('userName').value as String;
          }

          if (data.snapshot.child('reservationID').exists) {
            reservationID = data.snapshot.child('reservationID').value as int;
            if (reservationID != 0) {
              if (data.snapshot.child('sessionID').exists) {
                sessionID = data.snapshot.child('sessionID').value as int;
                if (sessionID != 0) {
                  loading.dismiss();
                  getCart();
                  getMenus();
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
    apiProvider = getApiProvider;
    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
    );
    if (box.hasData('phoneNumber')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (box.hasData('categorySelected')) {
          categorySelected =
              CategoryModel.fromJson(box.read('categorySelected'));
        }
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
