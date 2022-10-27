//
//
//
//  import 'package:ecommerce/pay_mob/modules/payment/cubit/cubit.dart';
// import 'package:ecommerce/pay_mob/modules/payment/cubit/states.dart';
// import 'package:ecommerce/pay_mob/modules/payment/cubit/toogle.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
//
// class Registerscreen extends StatelessWidget {
//   String name,email,phone,code,d_app,from,point,to,trip,nsba_offer,num,status,total;
//
//
//   Registerscreen({
//       this.name,
//       this.email,
//       this.phone,
//       this.code,
//       this.d_app,
//       this.from,
//       this.point,
//       this.to,
//       this.trip,
//       this.nsba_offer,
//       this.num,
//       this.status,
//       this.total});
//
//   @override
//    Widget build(BuildContext context) {
//      return
//
//
//        BlocProvider(
//
//        create:(context)=>paymentCubit(),
//
//        child: BlocConsumer<paymentCubit,PaymentStates>(
//          listener: (context,state){
//
//             if(state is paymentRefCodeSuccessSate){
//               Get.to(ToogleScreen());
//             }
//          },
//          builder: (context,state){
//
//            return   Scaffold(
//              body: Column(
//                children: [
//                  SizedBox(height: 40,),
//
//                  RaisedButton(
//                      color:Colors.redAccent,
//                      child:Text("pay",style:TextStyle(color:Colors.white),),
//                      onPressed: (){
//
//                        paymentCubit.get(context).getFirstToken('10000');
//
//
//                      })
//
//                ],
//              ),
//            );
//          },
//
//
//        ),
//      );
//    }
//  }
