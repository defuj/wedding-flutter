import 'package:wedding/repositories.dart';

var getRoutes = [
  GetPage(
    name: '/rsvp',
    page: () => const Login(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/reservation',
    page: () => const Register(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/menus',
    page: () => const Menus(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/menus/detail',
    page: () => const MenuDetail(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/menus/detail',
    page: () => const MenuDetail(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/',
    page: () => const Invitation(),
    parameters: const {
      'name': 'Bpk.DedeFujiAbdul',
    },
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/cart',
    page: () => const Cart(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/checkin',
    page: () => const Checkin(),
    transition: Transition.cupertino,
  ),
];
