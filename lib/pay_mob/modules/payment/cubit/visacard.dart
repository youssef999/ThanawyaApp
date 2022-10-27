



import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thanawy2022/pay_mob/constants/const.dart';
import 'package:thanawy2022/resources/color_manager.dart';
import 'package:thanawy2022/screens/home2/payment_done/done_layout.dart';
import 'package:thanawy2022/widgets/custom_text.dart';
import 'package:webview_flutter/webview_flutter.dart';


 class VisaCard extends StatelessWidget {
   String   name,email,courseName,courseChapter,status,total,prem;
   bool premuim;

VisaCard({
     required this.name,
     required this.email,
      required this.courseName,
    required this.courseChapter,
     required this.status,
  required this.premuim,
     required this.total,
     required this.prem,
   });


  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller = Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.primary,
        toolbarHeight: 60,
        title:
        Custom_Text(text:"ثانوية عامة",
            color:ColorManager.white,fontSize:20,alignment:Alignment.center),
      ),
      body: WebView(
        initialUrl:
        'https://accept.paymob.com/api/acceptance/iframes/422698?payment_token=$FinalTokenCard',
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {

          if (request.url.startsWith('https://accept.paymobsolutions.com/api/acceptance/post_pay')) {
            print('yesssssssssssssss');
            new Future.delayed(new Duration(seconds: 5), () async {
              print("xxxx");
              await FirebaseFirestore.instance.collection('pay').add({
                'name':name,
                "email":email,
                "status":"done paid by visa card",
                "courseName":courseName,
                "courseChapter":courseChapter,
                "total":total,
                 "premuim":premuim,
                "prem":prem,
                  'key':"paid"
              });
              final box=GetStorage();
              // if(premuim==true){
              //   box.write('prem', true);
              // }
              box.write('key', 'paid');
              box.write('prem', prem);
              Get.offAll(PaymentDone());

              print("premmmm:::::$premuim");
            });
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
       gestureNavigationEnabled: true,
      ),
     // floatingActionButton: favoriteButton(),

    );

  }
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
