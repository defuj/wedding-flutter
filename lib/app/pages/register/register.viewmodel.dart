import 'dart:developer';

import 'package:wedding/repositories.dart';

class RegisterViewModel extends ViewModel {
  late SweetDialog loading;
  late ApiProvider apiProvider;
  final box = GetStorage();
  FirebaseDatabase database = FirebaseDatabase.instance;

  bool _dataIsReady = false;
  bool get dataIsReady => _dataIsReady;
  set dataIsReady(bool value) {
    _dataIsReady = value;
    notifyListeners();
  }

  bool _isReservasion = false;
  bool get isReservasion => _isReservasion;
  set isReservasion(bool value) {
    _isReservasion = value;
    notifyListeners();
  }

  List<SessionModel> _sessions = List<SessionModel>.empty(growable: true);
  List<SessionModel> get sessions => _sessions;
  set sessions(List<SessionModel> value) {
    _sessions = value;
    notifyListeners();
  }

  int _invitationID = 0;
  int get invitationID => _invitationID;
  set invitationID(int value) {
    _invitationID = value;
    notifyListeners();
  }

  int _sessionID = 0;
  int get sessionID => _sessionID;
  set sessionID(int value) {
    _sessionID = value;
    notifyListeners();
  }

  int _reservationID = 0;
  int get reservationID => _reservationID;
  set reservationID(int value) {
    _reservationID = value;
    notifyListeners();
  }

  String _userNickname = '';
  String get userNickname => _userNickname;
  set userNickname(String value) {
    _userNickname = value;
    notifyListeners();
  }

  String _userName = '';
  String get userName => _userName;
  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  int _selectedSession = 0;
  int get selectedSession => _selectedSession;
  set selectedSession(int value) {
    _selectedSession = value;
    notifyListeners();
  }

  String _selectedSessionName = '';
  String get selectedSessionName => _selectedSessionName;
  set selectedSessionName(String value) {
    _selectedSessionName = value;
    notifyListeners();
  }

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  List<MemberModel> _members = List<MemberModel>.empty(growable: true);
  List<MemberModel> get members => _members;
  set members(List<MemberModel> value) {
    _members = value;
    notifyListeners();
  }

  List<String> nickname = [
    'Bpk',
    'Ibu',
    'Tuan/Mr',
    'Nona',
    'Ananda (0-6tahun)',
  ];

  var newMamberName = '';

  void writeMemberName(int indexMember, String initialValue) {
    newMamberName = initialValue;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 475),
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
                'Silahkan ketik nama lengkap',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: IColors.gray800,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans',
                    ),
              ),
              const SizedBox(height: 16),
              InputFormText(
                initialValue: initialValue,
                height: 50,
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 0,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChanged: (value) => newMamberName = value,
                hintText: 'Masukkan nama lengkap',
                prefixIcon: Container(
                  height: 50,
                  color: IColors.pink50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: ButtonPrimary(
                  text: 'Simpan',
                  onPressed: () {
                    updateMemberName(newMamberName, indexMember);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void changeMyNickName() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 475),
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
                'Silahkan pilih nama panggilan',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: IColors.gray800,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans',
                    ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                key: UniqueKey(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: nickname.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      userNickname = nickname[index];
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: IColors.gray50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        nickname[index],
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
  }

  void showNicknameDialog(int indexMember) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 475),
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
                'Silahkan pilih nama panggilan',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: IColors.gray800,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans',
                    ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                key: UniqueKey(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: nickname.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      members[indexMember].nickname =
                          nickname[index].replaceAll('(0-6tahun)', '');
                      members = members;
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: IColors.gray50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        nickname[index],
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
  }

  void showSessionList() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 475),
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
                'Silahkan pilih sesi',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: IColors.gray800,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans',
                    ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                key: UniqueKey(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      selectedSession = int.parse(sessions[index].sessionID!);
                      selectedSessionName =
                          'Sesi ${sessions[index].sessionName} (${sessions[index].sessionStart} sd ${sessions[index].sessionEnd})';
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selectedSession ==
                                int.parse(sessions[index].sessionID!)
                            ? IColors.gray50
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Sesi ${sessions[index].sessionName} (${sessions[index].sessionStart} sd ${sessions[index].sessionEnd}) ${sessions[index].sessionQuota} kuota tersisa',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
  }

  void updateMemberName(String value, int index) {
    members[index].memberName = value;
    members = members;
  }

  void addNewMember() {
    if (userName.isNotEmpty && userNickname.isNotEmpty) {
      // check if member name is empty
      if (members.isEmpty) {
        List<MemberModel> list = [
          MemberModel(memberID: '${members.length + 1}')
        ];
        members = list;
      } else {
        if (members[members.length - 1].memberName == null ||
            members[members.length - 1].nickname == null) {
          SweetDialog(
            context: context,
            title: 'Nama dan panggilan harus diisi',
            content: 'Silahkan isi nama dan panggilan terlebih dahulu',
            dialogType: SweetDialogType.error,
          ).show();
        } else {
          List<MemberModel> list = members;
          list.add(MemberModel(memberID: '${members.length + 1}'));
          members = list;
        }
      }
      FocusManager.instance.primaryFocus?.unfocus();
    } else {
      SweetDialog(
        context: context,
        title: 'Nama dan panggilan kamu harus diisi',
        content: 'Silahkan isi nama dan panggilan terlebih dahulu',
        dialogType: SweetDialogType.error,
      ).show();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void removeMember(int index) {
    var list = members;
    list.removeAt(index);

    members = list;
  }

  void successCreateReservasion() {
    SweetDialog(
      context: context,
      title: 'Berhasil membuat reservasi',
      content:
          'Reservasi berhasil dibuat, silahkan lanjutkan untuk memesan makanan',
      dialogType: SweetDialogType.success,
      barrierDismissible: false,
      confirmText: 'Lanjutkan',
      onConfirm: () {
        box.write('sessionName', selectedSessionName);
        box.write('userName', trimEndSpace(userName));
        box.write('reservationID', reservationID);
        box.write('sessionID', selectedSession);

        Get.offAllNamed('/menus');
      },
    ).show();
  }

  void addMember(List<MemberModel> members, int reservationID) async {
    members.add(MemberModel(
      memberName: trimEndSpace(userName),
      nickname: trimEndSpace(userNickname),
    ));

    await apiProvider
        .addMember(
            reservationID: reservationID,
            sessionID: selectedSession,
            members: members)
        .then(
      (value) {
        sessionID = selectedSession;
        updateReservation(
          userName: userName,
          phoneNumber: phoneNumber,
          reservationID: reservationID,
          sessionID: sessionID,
          invitationID: invitationID,
          members: members,
        );
      },
      onError: (e) {
        loading.dismiss();
        SweetDialog(
          context: context,
          title: 'Gagal menambahkan anggota',
          content: e.toString(),
          dialogType: SweetDialogType.error,
        ).show();
      },
    );
  }

  void updateReservation({
    required String userName,
    required String phoneNumber,
    required int reservationID,
    required int sessionID,
    required int invitationID,
    required List<MemberModel> members,
  }) async {
    var dataMember = [];
    for (var element in members) {
      dataMember.add(element.toJson());
    }
    DatabaseReference ref = FirebaseDatabase.instance.ref("reservation");
    await ref.child(modifyPhoneNumber(phoneNumber)).set({
      'phoneNumber': modifyPhoneNumber(phoneNumber),
      'userName': userName,
      'reservationID': reservationID,
      'sessionID': sessionID,
      'invitationID': invitationID,
      'members': dataMember.toList(),
    }).then((_) {
      // Data updated successfully!
      // go to reservation page and create new member
      loading.dismiss();
      successCreateReservasion();
    }).catchError((error) {
      // Error saving data
      loading.dismiss();
      SweetDialog(
        context: context,
        title: 'Gagal',
        content: 'Gagal menyimpan data',
        dialogType: SweetDialogType.error,
      ).show();
    });
  }

  void createReservasion() async {
    loading.show();
    if (isReservasion) {
      addMember(members, reservationID);
    } else {
      await apiProvider
          .createReservasion(
        name: trimEndSpace(userName),
        phoneNumber: trimEndSpace(phoneNumber),
        id: invitationID,
        nickname: trimEndSpace(userNickname),
      )
          .then(
        (value) {
          isReservasion = true;
          reservationID = value;
          addMember(members, value);
        },
        onError: (e) {
          loading.dismiss();
          SweetDialog(
            context: context,
            title: 'Gagal membuat reservasi',
            content: e.toString(),
            dialogType: SweetDialogType.error,
          ).show();
        },
      );
    }
  }

  void chooseFoods() {
    if (selectedSession == 0) {
      SweetDialog(
        context: context,
        title: 'Belum memilih sesi',
        content: 'Silahkan pilih sesi terlebih dahulu',
        dialogType: SweetDialogType.error,
      ).show();
      return;
    }

    if (userName.isEmpty || userNickname.isEmpty) {
      SweetDialog(
        context: context,
        title: 'Nama dan panggilan harus diisi',
        content: 'Silahkan isi nama dan panggilan terlebih dahulu',
        dialogType: SweetDialogType.error,
      ).show();
      return;
    }

    createReservasion();
  }

  void getDataSession() async {
    // loading.show();
    await apiProvider.getSessions().then((value) {
      sessions = value;
      //   loading.dismiss();
    }, onError: (e) {
      //   loading.dismiss();
      SweetDialog(
        context: context,
        title: 'Terjadi kesalahan',
        content: 'Tidak dapat mengambil data sesi',
        dialogType: SweetDialogType.error,
        barrierDismissible: false,
        onConfirm: () => Get.back(),
      ).show();
    });
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

  String modifyUserName(String originalString) {
    if (originalString.contains(' dan') || originalString.contains(' &')) {
      int idx = originalString.contains(' dan')
          ? originalString.indexOf(' dan')
          : originalString.indexOf(' &');

      return originalString.substring(0, idx);
    }

    return originalString;
  }

  void prepareData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("reservation");
    try {
      if (box.hasData('phoneNumber')) {
        phoneNumber = box.read('phoneNumber');
        log('phoneNumber received: $phoneNumber');

        dataIsReady = true;
        getDataSession();

        loading.show();
        var data =
            await ref.child(modifyPhoneNumber(box.read('phoneNumber'))).once();

        if (data.snapshot.exists) {
          loading.dismiss();
          // check reservationID
          if (data.snapshot.child('reservationID').exists) {
            log('reservationID is exists');
            log('reservationID received: ${data.snapshot.child('reservationID').value}');
            log('sessionID received: ${data.snapshot.child('sessionID').value}');
            log('invitationID received: ${data.snapshot.child('invitationID').value}');

            reservationID = data.snapshot.child('reservationID').value as int;
            sessionID = data.snapshot.child('sessionID').value as int;
            invitationID = data.snapshot.child('invitationID').value as int;

            if (reservationID != 0 && sessionID != 0) {
              isReservasion = true;
              log('isReservasion: $isReservasion');

              // check if user has member
              if (data.snapshot.child('members').exists) {
                // check if user already have menus
                if (data.snapshot.child('isFinished').exists) {
                  // user already have menus
                  SweetDialog(
                    context: context,
                    title: 'Sudah melakukan reservasi',
                    content:
                        'Terimakasih, Anda sudah melakukan reservasi sebelumnya',
                    dialogType: SweetDialogType.success,
                    barrierDismissible: false,
                    confirmText: 'Oke',
                    onConfirm: () {
                      Get.offAllNamed('/rsvp');
                    },
                  ).show();
                } else {
                  // user not have menus
                  SweetDialog(
                    context: context,
                    title: 'Sudah melakukan reservasi',
                    content:
                        'Anda sudah melakukan reservasi sebelumnya, silahkan lanjutkan untuk memesan makanan',
                    dialogType: SweetDialogType.success,
                    barrierDismissible: false,
                    confirmText: 'Lanjutkan',
                    onConfirm: () {
                      Get.offAllNamed('/menus');
                    },
                  ).show();
                }
              } else {
                // add member
                // continue to add member
              }
            } else {
              log('isReservasion: $isReservasion');
              // user not reservasion
              // just continue to create reservasion
            }
          } else {
            // user not reservasion
            // just continue to create reservasion
          }
        } else {
          loading.dismiss();
          userNotFound();
        }
      } else {
        userNotFound();
      }
    } catch (e) {
      log('error: $e');
      userNotFound();
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

    try {
      userName = trimEndSpace(modifyUserName(box.read('userName')));
      log('userName: $userName');
    } catch (e) {
      log('error: $e');
    }

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
