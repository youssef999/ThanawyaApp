
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thanawy2022/pay_mob/network/dio.dart';
import 'package:thanawy2022/screens/splash/splash.dart';
import 'helper/binding.dart';
import 'screens/pdfs/pref_serves.dart';
import 'package:admob_flutter/admob_flutter.dart';

 void main() async {
   Admob.initialize();
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialServices();
  await DioHelperPayment.init();
  await GetStorage.init();
  runApp(MyApp());
 }

  class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return  GetMaterialApp(
          initialBinding: Binding(),
          debugShowCheckedModeBanner: false,
          home: SplashScreen()
    );
  }
}
