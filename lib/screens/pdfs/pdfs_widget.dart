import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thanawy2022/helper/custom_text.dart';
import 'package:thanawy2022/pay_mob/modules/payment/cubit/cubit.dart';
import 'package:thanawy2022/pay_mob/modules/payment/cubit/states.dart';
import 'package:thanawy2022/pay_mob/modules/payment/cubit/toogle.dart';
import 'package:thanawy2022/resources/color_manager.dart';
import 'package:thanawy2022/screens/home2/pay/payment_layout.dart';
import 'package:thanawy2022/screens/home2/premeium/premium.dart';
import 'package:thanawy2022/screens/pdfs/pdf_api.dart';
import 'package:thanawy2022/screens/pdfs/pdf_viewer_page.dart';

class PdfWidget extends StatefulWidget {
  String name,year;

  PdfWidget({required this.name,required this.year});

  @override
  State<PdfWidget> createState() => _PdfWidgetState();
}



class _PdfWidgetState extends State<PdfWidget> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.name)
         //   .where('year', isEqualTo: widget.year)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: Text('Loading'));
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return Expanded(
                  child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 11 / 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot posts = snapshot.data!.docs[index];
                        return BlocProvider(
                            create: (context) => paymentCubit(),
                            child: BlocConsumer<paymentCubit, PaymentStates>(
                                listener: (context, state) {
                              // add when paymob is live
                              if (state is paymentRefCodeSuccessSate) {
                                // Get.to(ToogleScreen());
                              }
                            }, builder: (context, state) {
                              return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                        height: 220,
                        child: InkWell(
                        onTap: () async {

                          final box=GetStorage();
                          String saveKey=box.read('key')??"x";
                          String prem=box.read('prem')??'x';

                          print("key::$saveKey");

                        if(posts['key']=='paid'){
                          if(prem=='pdf'||prem=='prem'){
                            print("paid done");
                            final url = posts['pdf'];
                            final file = await PDFApi.loadNetwork(url);
                            openPDF(file);
                          }
                          else{
                            Get.to(Scaffold(
                                appBar: AppBar(
                                  elevation: 0,
                                  backgroundColor: ColorManager.primary,
                                  toolbarHeight: 3,
                                ),
                                body: PremiumLayout()));
                          }
                        }
                        else{
                        final url = posts['pdf'];
                        final file = await PDFApi.loadNetwork(url);
                        openPDF(file);
                        }


                        },
                        child: Wrap(
                        children: <Widget>[
                        Padding(
                        padding: const EdgeInsets.only(
                        left: 15, right: 15),
                        child: Container(
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                        Radius.circular(10)),
                        boxShadow: [
                        BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0,
                        3), // changes position of shadow
                        ),
                        ]),
                        child: Row(
                        children: [
                        Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Container(
                        height: 70,
                        width: 50,
                        decoration: BoxDecoration(
                        image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: AssetImage(
                        "assets/images/pdf1.png"))),
                        ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Padding(
                        padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        ),
                        child: Text(
                        posts["name"],
                        style: TextStyle(
                        fontSize: 18,
                        color: Colors.black),
                        ),
                        )
                        ],
                        ),
                        ),
                        )
                        ],
                        )),
                        ));
                        }));
                      }));
          }
        });
    // );
  }
}
//       );
// }

void openPDF(File file) => Get.to(PDFViewerPage(file: file));
// }
