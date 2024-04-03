import 'package:alfairouzlab/fireBaseApi.dart';
import 'package:alfairouzlab/utils/material_swatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'routes/app_pages.dart';
import 'utils/consts.dart';
import 'utils/dependency_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await Future.delayed(const Duration(seconds: 5));
  // FlutterNativeSplash.remove();

  DependencyInjection.init();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      title: "مختبر الفيروز",
      themeMode: ThemeMode.light,
      theme: ThemeData.from(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'JF-Flat'),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Const.primaryColor.toMaterialColor(),
          brightness: Brightness.light,
          cardColor: Colors.white,
          accentColor: Const.primaryLightColor,
          errorColor: Colors.red,
          backgroundColor: Colors.white,
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset(
//           'assets/logo.png', // Replace with the actual path to your custom logo image
//           // Additional customization properties for the image
//           width: 200,
//           height: 200,
//         ),
//       ),
//     );
//   }
// }