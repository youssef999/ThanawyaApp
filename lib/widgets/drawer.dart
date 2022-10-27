


import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:thanawy2022/resources/color_manager.dart';


class MainDrawer extends StatefulWidget {
  const MainDrawer({Key ? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {



  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[

                      Container(
                        height: 20,
                        color: ColorManager.primary,
                      ),


                      SizedBox(height:20,),

                      ListTile(
                          leading:
                          Icon(Icons.rate_review,color:ColorManager.primary,size:40),
                          title: Text('مشاركة التطبيق',
                            style: const TextStyle(
                              color: Colors.black, fontSize: 17,),),
                          onTap: () {
                           share();
                          }
                      ),

                      SizedBox(height:20,),

                      // ListTile(
                      //     leading:
                      //     Icon(Icons.message,color:ColorManager.primary,size:40),
                      //     title: Text(' تواصل مع المدرسة ',
                      //       style: const TextStyle(
                      //         color: Colors.black, fontSize: 17,),),
                      //     onTap: () {
                      //    //   Get.to(Contact());
                      //     }
                      // ),



                    ]))));
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'THANAWYA',
        text: 'قم بتحميل تطبيق الثانوية العامة الان',
        linkUrl:
        'https://play.google.com/store/apps/details?id=com.appy.thanawy2022',
        chooserTitle: 'ثانوية');
  }

}






