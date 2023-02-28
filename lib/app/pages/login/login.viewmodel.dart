import 'dart:developer';

import 'package:wedding/repositories.dart';

class LoginViewModel extends ViewModel {
  late ApiProvider apiProvider;
  late SweetDialog loading;
  final box = GetStorage();

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

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void saveUser() async {
    if (userName.isNotEmpty) {
      loading.show();
      Future.delayed(const Duration(seconds: 2), () {
        loading.dismiss();
        Get.offAllNamed('/reservation', arguments: {
          'userName': userName,
          'phoneNumber': phoneNumber,
        });
      });
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
                'Kamu belum terdaftar, silahkan masukan identitas',
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

  void checkUser() async {
    // check the first character of the phone number
    // if the first character is 0, replace with 62
    // because the phone number format is 62xxxxxxxxxx

    await apiProvider.checkPhoneNumber(phoneNumber: phoneNumber).then(
      (value) {
        // log('result: $value');
        loading.dismiss();
        userName = value['userName'];
        final reservasionID = value['reservasionID'] as int;
        final sessionID = value['sessionID'] as int;
        final invitationID = value['invitationID'] as int;

        box.write('userName', value['userName']);
        box.write('reservasionID', reservasionID);
        box.write('sessionID', sessionID);
        box.write('invitationID', invitationID);

        if (reservasionID != 0) {
          Get.offAllNamed('/menus', arguments: {
            'userName': userName,
            'reservasionID': reservasionID,
            'sessionID': sessionID,
            'invitationID': invitationID,
          });
        } else {
          box.write('phoneNumber', modifyPhoneNumber(phoneNumber));
          Get.offAllNamed('/reservation', arguments: {
            'userName': userName,
            'phoneNumber': modifyPhoneNumber(phoneNumber),
            'invitationID': invitationID,
          });
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
