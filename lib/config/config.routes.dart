import 'package:wedding/repositories.dart';

var getRoutes = [
  GetPage(
    name: '/login',
    page: () => const Login(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/register',
    page: () => const Register(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/foods',
    page: () => const Foods(),
    transition: Transition.cupertino,
  ),
];
