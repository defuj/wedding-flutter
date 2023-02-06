import 'package:wedding/repositories.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
  }
}
