import 'dart:developer';

import 'package:wedding/repositories.dart';

class LoginViewModel extends ViewModel {
  late ApiProvider apiProvider;
  late SweetDialog loading;
  final box = GetStorage();
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  List<String> nickname = [
    'Bpk',
    'Ibu',
    'Tuan/Mr',
    'Nona',
    'Ananda (0-6tahun)',
  ];

  String _nickNameSelected = '';
  String get nickNameSelected => _nickNameSelected;
  set nickNameSelected(String value) {
    _nickNameSelected = value;
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

  int _invitationID = 0;
  int get invitationID => _invitationID;
  set invitationID(int value) {
    _invitationID = value;
    notifyListeners();
  }

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void saveUser() {
    if (userName.isNotEmpty) {
      box.write('phoneNumber', modifyPhoneNumber(phoneNumber));
      box.write('userName', userName);
      loading.show();
      createNewReservation(
        userName: userName,
        phoneNumber: modifyPhoneNumber(phoneNumber),
        reservationID: reservationID,
        sessionID: sessionID,
        invitationID: invitationID,
      );
    } else {
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Nama tidak boleh kosong',
        content: 'Silahkan masukan nama lengkap kamu',
      ).show();
    }
  }

  void showNicknameDialog() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: const BoxConstraints(
        maxWidth: 475,
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
                      nickNameSelected = nickname[index];
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

  void checkPhoneNumber(LoginViewModel viewModel) async {
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
        return Container(
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
                'Silahkan masukan identitas',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: IColors.gray800,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans',
                    ),
              ),
              const SizedBox(height: 24),
              Text(
                'Nama Lengkap',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(height: 4),
              InputFormText(
                height: 50,
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 16,
                ),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                onChanged: (value) => userName = value,
                hintText: 'Masukkan nama lengkap kamu',
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
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: ButtonPrimary(
                  text: 'Simpan',
                  onPressed: saveUser,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void createNewReservation({
    required String userName,
    required String phoneNumber,
    required int reservationID,
    required int sessionID,
    required int invitationID,
  }) async {
    await ref.child('reservation').child(modifyPhoneNumber(phoneNumber)).set({
      'phoneNumber': modifyPhoneNumber(phoneNumber),
      'userName': userName,
      'reservationID': reservationID,
      'sessionID': sessionID,
      'invitationID': invitationID,
    }).then((_) {
      // Data updated successfully!
      // go to reservation page and create new member
      loading.dismiss();
      Get.toNamed('/reservation');
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

  void updateInvitationID({required int invitationID}) async {
    await ref
        .child('reservation')
        .child(modifyPhoneNumber(phoneNumber))
        .update({
      'invitationID': invitationID,
    }).then((_) {
      // Data updated successfully!
      // go to reservation page and create new member
      loading.dismiss();
      Get.toNamed('/reservation');
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

  void checkUser() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("reservation");
    await apiProvider.checkPhoneNumber(phoneNumber: phoneNumber).then(
      (value) async {
        userName = trimEndSpace(value['userName']);
        reservationID = value['reservationID'] as int;
        sessionID = value['sessionID'] as int;
        invitationID = value['invitationID'] as int;

        box.write('phoneNumber', modifyPhoneNumber(phoneNumber));
        box.write('userName', trimEndSpace(value['userName']));

        // check current reservation by phoneNumber
        var data = await ref.child(modifyPhoneNumber(phoneNumber)).once();
        if (data.snapshot.exists) {
          if (reservationID != 0) {
            // check if reservationID is equal with user
            if (data.snapshot.child('reservationID').value == reservationID) {
              // check if user already have sessionID and invitationID
              if (data.snapshot.child('sessionID').exists &&
                  data.snapshot.child('invitationID').exists) {
                // check sessionID and invitationID is equal with user
                if (data.snapshot.child('sessionID').value == sessionID) {
                  if (data.snapshot.child('invitationID').value !=
                      invitationID) {
                    await ref.child(modifyPhoneNumber(phoneNumber)).update({
                      'invitationID': invitationID,
                    });
                  }

                  // check if user already have member
                  if (data.snapshot.child('members').exists) {
                    // check member already have menus and finish reservation
                    if (data.snapshot.child('isFinished').exists) {
                      // user already finish reservation
                      loading.dismiss();
                      SweetDialog(
                        context: context,
                        title: 'Terimakasih',
                        content: 'Anda sudah melakukan reservasi',
                        dialogType: SweetDialogType.success,
                      ).show();
                    } else {
                      // user not yet choose food
                      loading.dismiss();
                      box.write('phoneNumber', modifyPhoneNumber(phoneNumber));
                      Get.offNamed('/menus');
                    }
                  } else {
                    // user don't have member
                    loading.dismiss();
                    Get.offNamed('/reservation');
                  }
                } else {
                  // user sessionID and invitationID is different
                  // create new sessionID and invitationID
                  // and reset all data (member, foods)
                  createNewReservation(
                    userName: userName,
                    phoneNumber: modifyPhoneNumber(phoneNumber),
                    reservationID: reservationID,
                    sessionID: sessionID,
                    invitationID: invitationID,
                  );
                }
              } else {
                // user don't have sessionID and invitationID
                // create new sessionID and invitationID
                // and reset all data (member, foods)
                createNewReservation(
                  userName: userName,
                  phoneNumber: modifyPhoneNumber(phoneNumber),
                  reservationID: reservationID,
                  sessionID: sessionID,
                  invitationID: invitationID,
                );
              }
            } else {
              // reservationID not equal with user
              // create new reservation
              createNewReservation(
                userName: userName,
                phoneNumber: modifyPhoneNumber(phoneNumber),
                reservationID: reservationID,
                sessionID: sessionID,
                invitationID: invitationID,
              );
            }
          } else {
            // create new reservation
            createNewReservation(
              userName: userName,
              phoneNumber: modifyPhoneNumber(phoneNumber),
              reservationID: reservationID,
              sessionID: sessionID,
              invitationID: invitationID,
            );
          }
        } else {
          // user don't have reservation
          // create new reservation
          createNewReservation(
            userName: userName,
            phoneNumber: modifyPhoneNumber(phoneNumber),
            reservationID: reservationID,
            sessionID: sessionID,
            invitationID: invitationID,
          );
        }
      },
      onError: (message) {
        log('result: $message');
        loading.dismiss();
        checkPhoneNumber(this);
      },
    );
  }

  void validatePhone() {
    if (phoneNumber.isNotEmpty) {
      if (validatePhoneNumber(phoneNumber)) {
        loading.show();
        Future.delayed(const Duration(seconds: 1), () {
          checkUser();
        });
      } else {
        SweetDialog(
          context: context,
          title: 'Tidak valid',
          content:
              'Nomor telepon tidak valid, silahkan masukkan nomor telepon yang benar',
          dialogType: SweetDialogType.error,
        ).show();
      }
    } else {
      SweetDialog(
        context: context,
        title: 'Nomor telepon kosong',
        content:
            'Nomor telepon tidak boleh kosong, silahkan masukkan nomor telepon yang benar',
        dialogType: SweetDialogType.error,
      ).show();
    }
  }

  @override
  void init() {
    apiProvider = getApiProvider;
    // log('result: ${apiProvider.hashCode}');
    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
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
