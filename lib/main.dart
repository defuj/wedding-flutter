import 'dart:io';
import 'package:wedding/repositories.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  var lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: textTheme,
  );

  //   var darkTheme = ThemeData(
  //     useMaterial3: true,
  //     colorScheme: darkColorScheme,
  //     textTheme: textTheme,
  //   );
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: 'Enter invited guest data ',
      theme: lightTheme,
      //   darkTheme: darkTheme,
      initialRoute: '/login',
      getPages: getRoutes,
      initialBinding: MainBinding(),
    ),
  );
}
