import 'dart:convert';
import 'dart:developer';
import 'package:wedding/repositories.dart';

class MenuDetailViewModel extends ViewModel {
  late SweetDialog loading;
  late ApiProvider apiProvider;
  final box = GetStorage();
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('reservation');

  bool _isMenuInCart = false;
  bool get isMenuInCart => _isMenuInCart;
  set isMenuInCart(bool value) {
    _isMenuInCart = value;
    notifyListeners();
  }

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

  void addMemberToMenu(int index) async {
    var cart = List<CartModel>.empty(growable: true);
    if (memberSelected
        .where((element) => element.memberID == members[index].memberID)
        .isEmpty) {
      var data = await ref
          .child(modifyPhoneNumber(box.read('phoneNumber')))
          .child('menus')
          .once();
      if (data.snapshot.exists) {
        final result = data.snapshot.value as Map<dynamic, dynamic>;
        result.forEach((key, value) {
          final map = value as Map<dynamic, dynamic>;
          cart.add(CartModel(
            menu: MenuModel.fromJson(map['menu']),
            members: (map['members'] as List)
                .map((e) => MemberModel.fromJson(e))
                .toList(),
            note: map['note'],
          ));
        });

        // check if member is already selected by other menu with same menu categoryID
        // check in cart where menu categoryID is not same with menu categoryID

        if (cart
            .where((element) =>
                element.menu!.categoryID == menu.categoryID &&
                element.menu!.menuID != menu.menuID &&
                element.members!
                    .where((element) =>
                        element.memberID == members[index].memberID)
                    .isNotEmpty)
            .isNotEmpty) {
          Get.back();
          SweetDialog(
            context: context,
            dialogType: SweetDialogType.error,
            title: 'Tidak bisa dipilih',
            content:
                '${members[index].memberName} sudah memilih menu lain pada kategori ini',
          ).show();
        } else {
          var temp = memberSelected;
          temp.add(members[index]);
          memberSelected = temp;

          Get.back();
        }
      } else {
        var temp = memberSelected;
        temp.add(members[index]);
        memberSelected = temp;

        Get.back();
      }
    } else {
      var temp = memberSelected;
      temp.removeWhere(
          (element) => element.memberID == members[index].memberID);
      memberSelected = temp;
      Navigator.pop(context);
    }
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
                        addMemberToMenu(index);
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
    loading.show();

    final cart = CartModel(
      menu: menu,
      members: memberSelected,
      note: note,
    );

    try {
      var data = await ref
          .child(modifyPhoneNumber(box.read('phoneNumber')))
          .child('menus')
          .once();
      if (data.snapshot.exists) {
        // check if menu already exist in cart
        if (data.snapshot.hasChild('${menu.menuID}')) {
          log('Menu already exist');
          // add new cart
          final newRef = ref
              .child(modifyPhoneNumber(box.read('phoneNumber')))
              .child('menus');
          // final key = newRef.push().key;
          log(jsonEncode(cart));
          await newRef.child('${menu.menuID}').update({
            'menu': cart.menu!.toJson(),
            'members': cart.members!.map((e) => e.toJson()).toList(),
            'note': cart.note,
          }).then((value) {
            loading.dismiss();
            isMenuInCart = true;
            SweetDialog(
              context: context,
              dialogType: SweetDialogType.success,
              title: 'Berhasil',
              content: 'Daftar pesanan berhasil diubah',
            ).show();
          }).onError((error, stackTrace) {
            log('error: $error');
            loading.dismiss();
            SweetDialog(
              context: context,
              dialogType: SweetDialogType.error,
              title: 'Gagal',
              content: 'Menu gagal merubah daftar pesanan',
            ).show();
          });
        } else {
          log('Menu not exist');
          // add new cart
          final newRef = ref
              .child(modifyPhoneNumber(box.read('phoneNumber')))
              .child('menus');
          // final key = newRef.push().key;
          log(jsonEncode(cart));
          await newRef.child('${menu.menuID}').set({
            'menu': cart.menu!.toJson(),
            'members': cart.members!.map((e) => e.toJson()).toList(),
            'note': cart.note,
          }).then((value) {
            isMenuInCart = true;
            loading.dismiss();
            SweetDialog(
              context: context,
              dialogType: SweetDialogType.success,
              title: 'Berhasil',
              content: 'Menu berhasil ditambahkan ke daftar pesanan',
            ).show();
          }).onError((error, stackTrace) {
            log('error: $error');
            loading.dismiss();
            SweetDialog(
              context: context,
              dialogType: SweetDialogType.error,
              title: 'Gagal',
              content: 'Menu gagal ditambahkan ke daftar pesanan',
            ).show();
          });
        }
      } else {
        // add new cart
        final newRef = ref
            .child(modifyPhoneNumber(box.read('phoneNumber')))
            .child('menus');
        // final key = newRef.push().key;
        log(jsonEncode(cart));
        await newRef.child('${menu.menuID}').set({
          'menu': cart.menu!.toJson(),
          'members': cart.members!.map((e) => e.toJson()).toList(),
          'note': cart.note,
        }).then((value) {
          isMenuInCart = true;
          loading.dismiss();
          SweetDialog(
            context: context,
            dialogType: SweetDialogType.success,
            title: 'Berhasil',
            content: 'Menu berhasil ditambahkan ke daftar pesanan',
          ).show();
        }).onError((error, stackTrace) {
          log('error: $error');
          loading.dismiss();
          SweetDialog(
            context: context,
            dialogType: SweetDialogType.error,
            title: 'Gagal',
            content: 'Menu gagal ditambahkan ke daftar pesanan',
          ).show();
        });
      }

      //   // check if menu already exist in cart
      //   var result = cartExist
      //       .where((element) => element.menu!.menuID == cart.menu!.menuID)
      //       .toList();
      //   // if menu not exist in cart
      //   if (result.isEmpty) {
      //     // add new cart
      //     var modCart = cartExist;
      //     modCart.add(cart);
      //     cartExist = modCart;
      //     log('cart added');
      //     log(jsonEncode(cartExist));
      //     await box
      //         .write('cart-$reservationID', cartExist.toList())
      //         .then((value) {
      //       SweetDialog(
      //         context: context,
      //         dialogType: SweetDialogType.success,
      //         title: 'Berhasil',
      //         content: 'Menu berhasil ditambahkan ke daftar pesanan',
      //       ).show();
      //     });
      //   } else {
      //     // modify cart
      //     List<CartModel> cartNew = List<CartModel>.empty(growable: true);
      //     for (var element in cartExist) {
      //       if (element.menu!.menuID == cart.menu!.menuID) {
      //         cartNew.add(cart);
      //       } else {
      //         cartNew.add(element);
      //       }
      //     }
      //     cartExist = cartNew;
      //     log('cart edited');
      //     log(jsonEncode(cartExist));
      //     await box
      //         .write('cart-$reservationID', cartExist.toList())
      //         .then((value) {
      //       SweetDialog(
      //         context: context,
      //         dialogType: SweetDialogType.success,
      //         title: 'Berhasil',
      //         content: 'Menu berhasil diperbarui',
      //       ).show();
      //     });
      //   }
    } catch (e) {
      log('Error: $e');
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Gagal',
        content: 'Menu gagal ditambahkan ke daftar pesanan',
      ).show();
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
          content: 'Tidak dapat menambahkan menu ke daftar pesanan',
        ).show();
      });
    } catch (e) {
      loading.dismiss();
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Oops...',
        content: 'Tidak dapat menambahkan menu ke daftar pesanan',
      ).show();
    }
  }

  void checkStock() async {
    try {
      if (menu.menuStock! > 0) {
        var totalMember = memberSelected.length;
        if (totalMember == 0) {
          if (isMenuInCart) {
            await ref
                .child(modifyPhoneNumber(box.read('phoneNumber')))
                .child('menus')
                .child('${menu.menuID}')
                .remove()
                .then(
              (value) {
                isMenuInCart = false;
                SweetDialog(
                  context: context,
                  dialogType: SweetDialogType.success,
                  title: 'Berhasil',
                  content: 'Menu telah dihapus dari daftar pesanan',
                ).show();
              },
              onError: (error) {
                SweetDialog(
                  context: context,
                  dialogType: SweetDialogType.error,
                  title: 'Oops...',
                  content: 'Gagal menyimpan perubahan daftar pesanan',
                ).show();
              },
            );
          } else {
            SweetDialog(
              context: context,
              dialogType: SweetDialogType.error,
              title: 'Oops...',
              content: 'Tidak ada member yang terdaftar',
            ).show();
          }
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

  void reloadMemberSelected() async {
    var data = await ref
        .child(modifyPhoneNumber(box.read('phoneNumber')))
        .child('menus')
        .child(menu.menuID!)
        .child('members')
        .once();
    if (data.snapshot.exists) {
      var temp = List<MemberModel>.empty(growable: true);
      try {
        // read list member from firebase data.snapshot.value
        var result = data.snapshot.value as List<dynamic>;
        for (var element in result) {
          final map = element as Map<dynamic, dynamic>;
          temp.add(MemberModel(
            memberID: map['id'] as String,
            memberName: map['nama'] as String,
            reservationID: int.parse(map['id_reservasi'] as String),
            isConfirm: 0,
            nickname: map['panggilan'] as String,
          ));
        }
        memberSelected = temp;
      } catch (e) {
        log('Error: $e');
      }
    }

    var notes = await ref
        .child(modifyPhoneNumber(box.read('phoneNumber')))
        .child('menus')
        .child('${menu.menuID}')
        .once();
    if (notes.snapshot.hasChild('note')) {
      note = notes.snapshot.child('note').value as String;
    }
  }

  void reservationNotFound() {
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

  void memberNotFound() {
    SweetDialog(
      context: context,
      dialogType: SweetDialogType.error,
      title: 'Oops!',
      content: 'Tidak menemukan data anggota',
      barrierDismissible: false,
      confirmText: 'Kembali',
      onConfirm: () => Get.toNamed('/rsvp'),
    ).show();
  }

  void menuNotFound() {
    SweetDialog(
      context: context,
      dialogType: SweetDialogType.error,
      title: 'Oops!',
      content: 'Tidak menemukan data menu',
      barrierDismissible: false,
      confirmText: 'Kembali',
      onConfirm: () => Get.toNamed('/menus'),
    ).show();
  }

  void prepareData() async {
    try {
      if (box.hasData('phoneNumber')) {
        loading.show();
        var data =
            await ref.child(modifyPhoneNumber(box.read('phoneNumber'))).once();
        if (data.snapshot.exists) {
          if (data.snapshot.child('reservationID').exists) {
            reservationID = data.snapshot.child('reservationID').value as int;
            if (reservationID != 0) {
              if (data.snapshot.child('sessionID').exists) {
                sessionID = data.snapshot.child('sessionID').value as int;
                if (sessionID != 0) {
                  if (box.hasData('menu')) {
                    if (box.hasData('members-$reservationID')) {
                      menu = MenuModel.fromJson(box.read('menu'));
                      try {
                        var temp = List<MemberModel>.empty(growable: true);
                        var tempMember =
                            await box.read('members-$reservationID');
                        log(jsonEncode(tempMember));
                        for (var element in tempMember) {
                          log(jsonEncode(element));
                          temp.add(MemberModel.fromJson(element));
                        }
                        members = temp;
                      } catch (e) {
                        members = await box.read('members-$reservationID');
                      }

                      if (data.snapshot
                          .child('menus')
                          .hasChild('${menu.menuID}')) {
                        isMenuInCart = true;
                      }

                      loading.dismiss();
                      if (members.isEmpty) {
                        memberNotFound();
                      } else {
                        reloadMemberSelected();
                        prepareBanner();
                      }
                    } else {
                      loading.dismiss();
                      memberNotFound();
                    }
                  } else {
                    loading.dismiss();
                    menuNotFound();
                  }
                } else {
                  loading.dismiss();
                  reservationNotFound();
                }
              } else {
                loading.dismiss();
                reservationNotFound();
              }
            } else {
              loading.dismiss();
              reservationNotFound();
            }
          } else {
            loading.dismiss();
            reservationNotFound();
          }
        } else {
          loading.dismiss();
          reservationNotFound();
        }
      } else {
        reservationNotFound();
      }
    } catch (e) {
      log(e.toString());
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Oops...',
        content: 'Terjadi kesalahan',
        barrierDismissible: false,
        confirmText: 'Kembali',
        onConfirm: () => Get.back(result: true),
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
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
