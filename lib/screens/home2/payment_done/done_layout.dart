
 import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thanawy2022/resources/color_manager.dart';
import 'package:thanawy2022/screens/home2/thanawy_layouts/bottom_bar.dart';
import 'package:thanawy2022/widgets/custom_text.dart';

class PaymentDone extends StatefulWidget {
  const PaymentDone({Key? key}) : super(key: key);

  @override
  State<PaymentDone> createState() => _PaymentDoneState();
}

class _PaymentDoneState extends State<PaymentDone> {
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

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.primary,
        toolbarHeight: 60,
        title:
        Custom_Text(text:"ثانوية عامة",
            color:ColorManager.white,fontSize:20,alignment:Alignment.center),
      ),
      body:Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              height: 200,
              child:Image.asset('assets/images/done.png'),
            ),
            SizedBox(height: 30,),
            Custom_Text(text: 'تمت العملية بنجاح ',alignment: Alignment.center,fontSize:26),
            SizedBox(height: 40,),
            Container(
                width:220,
                height:54,
                child:
            RaisedButton(
                color: ColorManager.primary,
                child: Custom_Text(text: "الرجوع للرئيسية",color:Colors.white,alignment:Alignment.center),
                onPressed:() async {
                  final isLoaded = await interstitialAd.isLoaded;
                  if (isLoaded ?? false) {
                    interstitialAd.show();
                  } else {
                    print("not loaded");
                  }
                  Get.offAll(BottomBar());
                })),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: AdmobBanner(
                adUnitId: 'ca-app-pub-7757590907378676/2830145723',
                adSize: AdmobBannerSize.BANNER,
                listener: (AdmobAdEvent event,
                    Map<String, dynamic>? args) {
                },
                onBannerCreated:
                    (AdmobBannerController controller) {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
