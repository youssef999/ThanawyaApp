

 import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thanawy2022/resources/color_manager.dart';
import 'package:thanawy2022/screens/home2/pay/payment_layout.dart';
import 'package:thanawy2022/screens/pdfs/pdf_api.dart';
import 'package:thanawy2022/widgets/custom_text.dart';
import 'package:thanawy2022/widgets/pdfs_widget.dart';

class PremiumLayout extends StatefulWidget {
  const PremiumLayout({Key? key}) : super(key: key);

  @override
  State<PremiumLayout> createState() => _PremiumLayoutState();
}

class _PremiumLayoutState extends State<PremiumLayout> {

  bool ? v=false;
  Color color=Colors.grey;

  @override
  Widget build(BuildContext context) {
    var box=GetStorage();
 String prem=box.read('prem')??'x';

 print("prem::::$prem");
    if(prem!='prem'){
      return
        SingleChildScrollView(
          child: Column(
            children: [

              Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    height:100,
                    child: Image.asset('assets/images/prem.png'),),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Custom_Text(text: 'يمكنك تفعيل الاشتراك السوبر في التطبيق الان',fontSize:20,alignment:Alignment.center,),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Custom_Text(text: 'تحصل علي جميع الفيديوهات المدفوعة بشكل مجاني علي هذا الجهاز',fontSize:13,alignment:Alignment.center,color:Colors.blueGrey,),
                  ), SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Custom_Text(text: '  الاشتراك السوبر : 45  جنية  ',fontSize:20,alignment:Alignment.center,color:ColorManager.primary,),
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Material(
                        child: Checkbox(
                          focusColor: Colors.lightBlue,
                          activeColor: Colors.grey,
                          tristate: true,
                          value: v,
                          onChanged: (value) {
                            setState(() {

                              v =value;
                              print(v);
                              if(v==true){
                                color=Colors.redAccent;
                              }else{
                                color=Colors.grey;
                              }

                            });
                          },
                          checkColor:ColorManager.primary,


                        ),
                      ),
                      InkWell
                        (child: Custom_Text
                        (text: 'سياسة التطبيق',fontSize: 12,alignment:Alignment.center,color:Colors.grey),
                        onTap:() async {

                          final url = 'https://firebasestorage.googleapis.com/v0/b/thanawyaapp.appspot.com/o/arabic%2Fملخص%20بلاغة.pdf?alt=media&token=24609081-aee8-4a71-9af9-acb30ba18783';
                          final file = await PDFApi.loadNetwork(url);
                          openPDF(file);


                        },

                      )
                      ,SizedBox(width: 5,),
                      const Text(
                        'اوافق علي سياسة التطبيق الخاصة بالدفع',
                        overflow: TextOverflow.ellipsis,
                      ),

                    ],
                  ),
                  Container(
                    width: 220,
                    child: RaisedButton(
                        color:color,
                        child: Custom_Text
                          (text: "انتقل للدفع",fontSize: 17,alignment:Alignment.center,color:Colors.white),
                        onPressed: (){
                          if(v==true){

                            Get.to( PaymentLayout(
                              courseName: 'الاشتراك السوبر',
                              name: '',
                              price:4500,
                              prem:'prem',
                              premuim: true,
                            ));
                          }
                        }),
                  ),
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

            ],
          ),
        );

    }
    else{

      return Column(
        children: [
          SizedBox(height: 20,),
          Container(
            height:100,
            child: Image.asset('assets/images/prem.png'),),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Custom_Text(text: 'انت بالفعل مشترك في اشتراك السوبر',fontSize:20,alignment:Alignment.center,),
          ),
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
      );
    }


  }
}
