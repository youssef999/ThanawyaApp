

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:thanawy2022/pay_mob/constants/const.dart';
import 'package:thanawy2022/resources/color_manager.dart';
import 'package:thanawy2022/widgets/custom_text.dart';

class RefCode2 extends StatelessWidget {


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
            mainAxisAlignment:MainAxisAlignment.center,
            children: [

           //   Text("you should goto any market to pay "),
              SizedBox(height:11,),
              Text("الكود ",
              style:TextStyle(color:Colors.black,fontSize:21,fontWeight:FontWeight.w700),
              ),
              SizedBox(height:11,),
              Container(
                width:220,
                child: Card(
                  elevation: 12,
                  child: Text(" "+RefCode,style:TextStyle(color:Colors.redAccent,fontSize: 40),),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
