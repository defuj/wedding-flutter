import 'dart:developer';

import 'package:wedding/repositories.dart';

class MenuDetailViewModel extends ViewModel {
  late SweetDialog loading;
  late ApiProvider apiProvider;
  final box = GetStorage();

  String _note = '';
  String get note => _note;
  set note(String value) {
    _note = value;
    notifyListeners();
  }

  MenuModel _menu = MenuModel();
  MenuModel get menu => _menu;
  set menu(MenuModel value) {
    _menu = value;
    notifyListeners();
  }

  List<MemberModel> _memberSelected = List<MemberModel>.empty(growable: true);
  List<MemberModel> get memberSelected => _memberSelected;
  set memberSelected(List<MemberModel> value) {
    _memberSelected = value;
    notifyListeners();
  }

  List<MemberModel> _members = List<MemberModel>.empty(growable: true);
  List<MemberModel> get members => _members;
  set members(List<MemberModel> value) {
    _members = value;
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

  List<String> _banners = List<String>.empty(growable: true);
  List<String> get banners => _banners;
  set banners(List<String> value) {
    _banners = value;
    notifyListeners();
  }

  void prepareBanner() {
    List<String> banners = List<String>.empty(growable: true);
    if (menu.menuCoverPicture != null && menu.menuCoverPicture!.isNotEmpty) {
      banners.add(menu.menuCoverPicture!);
    }

    if (menu.menuPicture1 != null && menu.menuPicture1!.isNotEmpty) {
      banners.add(menu.menuPicture1!);
    }

    if (menu.menuPicture2 != null && menu.menuPicture2!.isNotEmpty) {
      banners.add(menu.menuPicture2!);
    }

    this.banners = banners;
  }

  void showMemberList() {
    if (members.isNotEmpty) {
      showModalBottomSheet(
        constraints: const BoxConstraints(
          maxWidth: 475,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        builder: ((context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 24,
                      top: 16,
                    ),
                    height: 4,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: IColors.neutral20,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Pilih Member',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: IColors.gray800,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans',
                      ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        if (memberSelected
                            .where((element) =>
                                element.memberID == members[index].memberID)
                            .isEmpty) {
                          memberSelected.add(members[index]);
                          notifyListeners();
                        } else {
                          memberSelected.removeWhere((element) =>
                              element.memberID == members[index].memberID);
                          notifyListeners();
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: memberSelected
                                  .where((element) =>
                                      element.memberID ==
                                      members[index].memberID)
                                  .isNotEmpty
                              ? IColors.pink50_
                              : IColors.black01,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          members[index].memberName!,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: IColors.black80,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'OpenSans',
                                  ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        }),
      );
    } else {
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Oops...',
        content: 'Tidak ada member yang terdaftar',
      ).show();
    }
  }

  void deleteMember(MemberModel member) {
    var newMember = memberSelected;
    memberSelected
        .removeWhere((element) => element.memberID == member.memberID);
    memberSelected = newMember;
    log('Member Deleted: ${member.toJson()}');
  }

  void addToCart() async {
    // List<CartModel> cartAvailable = box.read('cart') ?? [];
    log('cart available: ${box.read('cart')}');
    final cart = CartModel(
      menu: menu,
      members: memberSelected,
      note: note,
    );

    try {
      List<CartModel> cartExist = List<CartModel>.empty(growable: true);
      if (box.read('cart') != null) {
        cartExist = box.read('cart');
      }

      var result = cartExist
          .where((element) => element.menu!.menuID == cart.menu!.menuID);
      if (result.isEmpty) {
        // add new cart
        var modCart = cartExist;
        modCart.add(cart);
        cartExist = modCart;
        await box.write('cart', cartExist);

        SweetDialog(
          context: context,
          dialogType: SweetDialogType.success,
          title: 'Berhasil',
          content: 'Menu berhasil ditambahkan ke keranjang',
        ).show();
      } else {
        // modify cart
        List<CartModel> cartNew = List<CartModel>.empty(growable: true);
        cartExist.map((e) {
          if (e.menu!.menuID == cart.menu!.menuID) {
            cartNew.add(cart);
          } else {
            cartNew.add(e);
          }
        });
        cartExist = cartNew;
        await box.write('cart', cartExist);

        SweetDialog(
          context: context,
          dialogType: SweetDialogType.success,
          title: 'Berhasil',
          content: 'Menu berhasil diperbarui',
        ).show();
      }
    } catch (e) {
      log('Error: $e');
      //   loading.dismiss();
      //   SweetDialog(
      //     context: context,
      //     dialogType: SweetDialogType.error,
      //     title: 'Gagal',
      //     content: 'Menu gagal ditambahkan ke keranjang, Error: $e',
      //   ).show();
      await box.remove('cart');
      addToCart();
    }
  }

  void checkProduct() async {
    loading.show();
    try {
      await apiProvider.getMenus(categoryID: menu.categoryID!).then((value) {
        var menuList = value;
        var menuAvailable =
            menuList.where((element) => element.menuID == menu.menuID).toList();
        if (menuAvailable.isNotEmpty) {
          if (menuAvailable[0].menuStock! > 0) {
            var totalMember = memberSelected.length + 1;
            if (totalMember > menuAvailable[0].menuStock!) {
              loading.dismiss();
              SweetDialog(
                context: context,
                dialogType: SweetDialogType.error,
                title: 'Oops...',
                content: 'Jumlah member melebihi stok menu',
              ).show();
            } else {
              addToCart();
            }
          } else {
            loading.dismiss();
            SweetDialog(
              context: context,
              dialogType: SweetDialogType.error,
              title: 'Oops...',
              content: 'Menu ini sudah habis',
            ).show();
          }
        } else {
          loading.dismiss();
          SweetDialog(
            context: context,
            dialogType: SweetDialogType.error,
            title: 'Oops...',
            content: 'Menu ini sudah tidak tersedia',
          ).show();
        }
      }).catchError((error) {
        loading.dismiss();
        SweetDialog(
          context: context,
          dialogType: SweetDialogType.error,
          title: 'Oops...',
          content: 'Tidak dapat menambahkan menu ke keranjang',
        ).show();
      });
    } catch (e) {
      loading.dismiss();
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Oops...',
        content: 'Tidak dapat menambahkan menu ke keranjang',
      ).show();
    }
  }

  void checkStock() {
    try {
      if (menu.menuStock! > 0) {
        var totalMember = memberSelected.length;
        if (totalMember == 0) {
          SweetDialog(
            context: context,
            dialogType: SweetDialogType.error,
            title: 'Oops...',
            content: 'Tidak ada member yang terdaftar',
          ).show();
        } else {
          var totalMember = memberSelected.length + 1;
          if (totalMember > menu.menuStock!) {
            SweetDialog(
              context: context,
              dialogType: SweetDialogType.error,
              title: 'Oops...',
              content: 'Jumlah member melebihi stok menu',
            ).show();
          } else {
            //   checkProduct();
            addToCart();
          }
        }
      } else {
        SweetDialog(
          context: context,
          dialogType: SweetDialogType.error,
          title: 'Oops...',
          content: 'Menu ini sudah habis',
        ).show();
      }
    } catch (e) {
      log(e.toString());
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Oops...',
        content: 'Menu ini sudah habis',
      ).show();
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

    final args = Get.arguments;
    if (args != null) {
      try {
        reservasionID = args['reservasionID'];
        sessionID = args['sessionID'];
        menu = MenuModel.fromJson(args['menu']);
        members = args['members'];

        box.write('reservasionID', reservasionID);
        box.write('sessionID', sessionID);
        box.write('menu', menu.toJson());
        box.write('members', members.toList());

        log('Menu: ${menu.toJson()}');
        log('Members: ${members.length}');
        log('ReservasionID: $reservasionID');
        log('SessionID: $sessionID');

        Future.delayed(Duration.zero, () {
          log(menu.toJson().toString());
          prepareBanner();
        });
      } catch (e) {
        log('Error wae: $e');
        SweetDialog(
          context: context,
          dialogType: SweetDialogType.error,
          title: 'Oops!',
          content: 'Tidak menemukan data reservasi',
          barrierDismissible: false,
          confirmText: 'Kembali',
          onConfirm: () => Get.toNamed('/rsvp'),
        );
      }
    } else {
      if (box.read('reservasionID') != null && box.read('sessionID') != null) {
        reservasionID = box.read('reservasionID');
        sessionID = box.read('sessionID');
        menu = MenuModel.fromJson(box.read('menu'));
        var member = box.read('members') as List;
        members = member.map((e) => MemberModel.fromJson(e)).toList();

        log('Menu: ${menu.toJson()}');
        log('Members: ${members.length}');
        log('ReservasionID: $reservasionID');
        log('SessionID: $sessionID');

        Future.delayed(Duration.zero, () {
          prepareBanner();
        });
      } else {
        try {
          Get.toNamed('/rsvp');
        } catch (e) {
          log('Error: $e');
        }
      }
    }
    Get.toNamed(
      '/menus/detail',
      arguments: {
        'reservasionID': reservasionID,
        'sessionID': sessionID,
        'menu': menu,
        'members': members,
      },
    );
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
