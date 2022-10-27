import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../home2/thanawy_layouts/bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AdmobInterstitial interstitialAd;
  @override
  void initState() {
    super.initState();
    interstitialAd = AdmobInterstitial(
      //ca-app-pub-6262607150176210/2180112332
      adUnitId: 'ca-app-pub-7757590907378676/5264737373',
      // 'ca-app-pub-3940256099942544/1033173712',
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();

      },
    );
    interstitialAd.load();
    initTimer();
  }

  void initTimer() async {
    if (await checkinternet()) {
      Timer(Duration(seconds: 4), () async {

        final isLoaded = await interstitialAd.isLoaded;
        if (isLoaded ?? false) {
          interstitialAd.show();
        } else {
          print("not loaded");
        }

        Get.off( BottomBar());
      });
    } else {}
  }

  Future checkinternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/images/11793-books-stack.json"),
      nextScreen: FutureBuilder(
          future: checkinternet(),
          builder: (BuildContext c, snap) {
            if (snap.data == null) {
              return  BottomBar();
            } else if (snap.data == true) {
              return BottomBar();
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
                body: InkWell(
                  onTap: () {
                    setState(() {
                      initTimer();
                    });
                  },
                  child: Lottie.asset(
                      "assets/images/no-internet-connection2.json"),
                ),
              );
            }
          }),
      splashIconSize: 300,
      duration: 3000,
      splashTransition: SplashTransition.sizeTransition,
      animationDuration: const Duration(seconds: 1),
      backgroundColor: Colors.white,
    );
  }
}
