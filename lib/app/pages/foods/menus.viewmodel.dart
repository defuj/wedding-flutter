import 'package:wedding/repositories.dart';

class MenusViewModel extends ViewModel {
  late SweetDialog loading;
  late ApiProvider apiProvider;
  final box = GetStorage();

  String userName = '';
  int reservasionID = 0;
  int sessionID = 0;

  List<CategoryModel> categories = [
    CategoryModel(categoryID: '1', categoryName: 'Appetizer'),
    CategoryModel(categoryID: '2', categoryName: 'Main Course'),
    CategoryModel(categoryID: '3', categoryName: 'Dessert'),
    CategoryModel(categoryID: '4', categoryName: 'Drink'),
  ];

  List<MenuModel> _menus = List<MenuModel>.empty(growable: true);
  List<MenuModel> get menus => _menus;
  set menus(List<MenuModel> value) {
    _menus = value;
    notifyListeners();
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
        userName = args['userName'];
        reservasionID = args['reservasionID'];
        sessionID = args['sessionID'];
        Future.delayed(Duration.zero, () {
          //
        });
      } catch (e) {
        SweetDialog(
          context: context,
          dialogType: SweetDialogType.error,
          title: 'Oops!',
          content: 'Tidak menemukan data reservasi',
          barrierDismissible: false,
          confirmText: 'Kembali',
          onConfirm: () => Get.offAllNamed('/login'),
        ).show();
      }
    } else {
      Get.offAllNamed('/login');
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
