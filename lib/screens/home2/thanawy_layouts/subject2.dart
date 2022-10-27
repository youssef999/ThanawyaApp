

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thanawy2022/helper/custom_text.dart';
import 'package:thanawy2022/resources/color_manager.dart';
import 'package:thanawy2022/screens/home2/thanawy_layouts/material.dart';



class Subject2 extends StatefulWidget {
 String cat,year;


 Subject2({required this.cat,required this.year});

  @override
  State<Subject2> createState() => _Subject2State();
}

class _Subject2State extends State<Subject2> {
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
          toolbarHeight: 47,
          title:
          Custom_Text(text:"ثانوية عامة",
              color:ColorManager.white,fontSize:20,alignment:Alignment.center),
        ),
        body: Container(
          color: Colors.white38,
          child: Column(children: [
            SizedBox(height: 30),
            Flexible(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('sub')
                      .where('cat', isNotEqualTo: widget.cat)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: Text('Loading'));
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 3,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot posts =
                              snapshot.data!.docs[index];

                              return  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 330,
                                    height: 390,
                                    child: InkWell(
                                      child: Card(
                                        color: Colors.white,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                  Radius.circular(10),
                                                  bottomRight:
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
                                          child:

                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 1,
                                              ),
                                              Container(
                                                height: 90,
                                                child: Image.network(posts['image']),
                                              ),
                                              SizedBox(height: 11,),
                                              Custom_Text(
                                                text: posts['name'],
                                                alignment:Alignment.center,
                                                fontSize: 16,
                                                color:ColorManager.black,
                                              ),



                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        final isLoaded = await interstitialAd.isLoaded;
                                        if (isLoaded ?? false) {
                                          interstitialAd.show();
                                        } else {
                                          print("not loaded");
                                        }
                                        Get.to(MaterialScreen(name: posts['name'],
                                      year: widget.year,
                                      //  chapter: posts['c'],
                                        ));

                                      },
                                    ),
                                  ));
                            });
                    }
                  }),
            ),
          ]),
        )
    );
  }
}
