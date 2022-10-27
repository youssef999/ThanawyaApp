

 import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thanawy2022/pay_mob/constants/const.dart';
import 'package:thanawy2022/pay_mob/modules/payment/cubit/refcode.dart';
import 'package:thanawy2022/pay_mob/modules/payment/cubit/visacard.dart';
import 'package:thanawy2022/resources/color_manager.dart';
import 'package:thanawy2022/widgets/custom_text.dart';


class ToogleScreen extends StatelessWidget {


  String  name,email,courseName,courseChapter,status,total,prem;
   bool premuim;

  ToogleScreen({
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
     return Scaffold(
       appBar: AppBar(
         elevation: 0,
         backgroundColor: ColorManager.primary,
         toolbarHeight: 60,
         title:
         Custom_Text(text:"ثانوية عامة",
             color:ColorManager.white,fontSize:20,alignment:Alignment.center),
       ),
       body:Container(
         child: Column(
           crossAxisAlignment:CrossAxisAlignment.center,
           children: [
             SizedBox(height: 60,),
             InkWell(
               child: Container(
                 child: Column(
                   children: [
                     Container(
                       width: double.infinity,
                       height:200,
                       child:   Image.asset('assets/images/v1t.png')
                     ),
                     SizedBox(height:5,),
                     Text("ادفع عن طريق الكارت",
                       style:TextStyle(color:Colors.black,fontSize:21,fontWeight:FontWeight.w700),)
                   ],
                 ),
               ),
               onTap:(){
                print("fff:==="+ FinalTokenCard);
                 Get.to(VisaCard(
                       name: name,
                       email: email,
                       status: status,
                        premuim:premuim,
                        prem:prem,
                        total: total, courseName:courseName, courseChapter: courseChapter,
                 ));
               },
             ),
SizedBox(
  height: 10,
),
             // InkWell(
             //   child: Container(
             //     child: Column(
             //       children: [
             //         Container(
             //             width: double.infinity,
             //             height:120,
             //             child:   Image.asset('assets/images/v2.png')
             //         ),
             //         SizedBox(height:5,),
             //         Text('كوبون',
             //           style:TextStyle(color:Colors.black,fontSize:21,fontWeight:FontWeight.w700),)
             //       ],
             //     ),
             //   ),
             //   onTap:() async {
             //     // await Firestore.instance.collection('orders').add({
             //     //   'name': name ?? "",
             //     //   'email': email ?? "",
             //     //   'phone': phone ?? "",
             //     //   'code': code?? "",
             //     //   'd_app': d_app ?? "",
             //     //   'from': from,
             //     //    'type':'voucher',
             //     //   'point': "it will be updated soon",
             //     //   'to': to,
             //     //   'trip': trip,
             //     //   // 'price':widget.price.toString(),
             //     //   'nsba_offer': nsba_offer,
             //     //   'num': num.toString(),
             //     //   "status": "pending",
             //     //   "total": total,
             //     //   "date": "Waiting..",
             //     //   "time": "Waiting..",
             //     //   "bus":"Waiting.."
             //     // });
             //     Get.to(RefCode2());
             //   },
             // ),



             SizedBox(
               height: 10,
             ),
             // InkWell(
             //   child: Container(
             //     child: Column(
             //       children: [
             //         Container(
             //             width: double.infinity,
             //             height:120,
             //             child:   Image.asset('assets/vod3.png')
             //         ),
             //         SizedBox(height:5,),
             //         Text("67".tr,
             //           style:TextStyle(color:Colors.black,fontSize:21,fontWeight:FontWeight.w700),)
             //       ],
             //     ),
             //   ),
             //   onTap:() async {
             //
             //
             //     print("total"+total.toString());
             //
             //     // Get.to(VodafoneCash(
             //     //    name: name,
             //     //    email: email,
             //     //    phone: phone,
             //     //    code: code,
             //     //    d_app: d_app,
             //     //    from: from,
             //     //    point: point,
             //     //    to: to,
             //     //    trip: trip,
             //     //    nsba_offer: nsba_offer,
             //     //    num: num,
             //     //    status: status,
             //     //    total: total
             //     // ));
             //
             //
             //   },
             // )
           ],
         ),

       ),
     );
   }
 }
