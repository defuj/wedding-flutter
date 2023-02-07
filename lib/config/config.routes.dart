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
    name: '/menus',
    page: () => const Menus(),
    transition: Transition.cupertino,
  ),
];
