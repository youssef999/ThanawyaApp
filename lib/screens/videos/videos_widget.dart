import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thanawy2022/screens/videos/video_screen.dart';


class VideoWidget extends StatefulWidget {
  String name,year;

  VideoWidget({required this.name, required this.year});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.name)
            .where('video', isNotEqualTo:'')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: Text('Loading'));
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot posts = snapshot.data!.docs[index];
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                child: InkWell(
                                    onTap: () async {

                                      final isLoaded = await interstitialAd.isLoaded;
                                      if (isLoaded ?? false) {
                                        interstitialAd.show();
                                      } else {
                                        print("not loaded");
                                      }
                                      Get.to(VideoScreen(
                                        url: posts['video'],
                                        title: posts['name'],
                                      ));

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
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: AssetImage(
                                                              "assets/images/play.jpg"))),
                                                ),
                                                // SizedBox(
                                                //   width: 10,
                                                // ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 20, right: 20),
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
                              ),

                            ],
                          ));
                    }),
              );
          }
        });
  }
}
