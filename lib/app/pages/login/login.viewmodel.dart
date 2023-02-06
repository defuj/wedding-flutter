import 'package:wedding/repositories.dart';

class LoginViewModel extends ViewModel {
  late ApiProvider apiProvider;
  late SweetDialog loading;

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
        Get.toNamed('/register', arguments: {
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

  void checkPhoneNumber() async {
    showModalBottomSheet(
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
                'Kamu belum terdaftar, silahkan masukan nama',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: IColors.gray800,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'open-sans',
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
              InputText(
                height: 44,
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 16,
                ),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                onChanged: (value) => userName = value,
                hintText: 'Masukkan nama lengkap kamu',
                prefixIcon: Container(
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
                height: 48,
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

  void validatePhone() {
    if (phoneNumber.isNotEmpty) {
      if (validatePhoneNumber(phoneNumber)) {
        loading.show();
        Future.delayed(const Duration(seconds: 3), () {
          loading.dismiss();
          checkPhoneNumber();
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
