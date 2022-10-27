
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thanawy2022/resources/color_manager.dart';
import 'package:thanawy2022/resources/strings_manager.dart';
import 'package:thanawy2022/screens/pdfs/pdfs_widget.dart';
import 'package:thanawy2022/screens/videos/videos_widget.dart';
import 'package:thanawy2022/view_model/material_view_model.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MaterialScreen extends GetWidget<MaterialViewModel> {

  String name,year;

  MaterialScreen({required this.name,required this.year});

  @override
  Widget build(BuildContext context) {

    MaterialViewModel controller = MaterialViewModel();

    return Scaffold(
        body: GetX<MaterialViewModel>(
          init: MaterialViewModel(),
          builder: (value) =>
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.primary,
                        ColorManager.kFontLight
                      ],
                      begin: FractionalOffset(0.0, 0.4),
                      end: Alignment.topRight,
                    )),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Column(children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 24,
                              color: ColorManager.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 25,
                        ),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Center(
                                  child: ToggleSwitch(
                                    initialLabelIndex: controller.activeToggledIndex.value,
                                    totalSwitches: 2,
                                    inactiveBgColor: ColorManager.black,
                                    minWidth: 145.0,
                                    minHeight: 60.0,
                                    activeFgColor: ColorManager.white,
                                    inactiveFgColor: Colors.white54,
                                    activeBgColor: [Colors.white10],
                                    fontSize: 18.0,
                                    labels: [
                                      AppStrings.pdf,
                                      AppStrings.videos,
                                    ],
                                    onToggle: (index) {
                                      print("index=" + index.toString());
                                      controller.changeToogleIndex(index!);
                                      print(controller.activeToggledIndex.toString());
                                    },
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: AdmobBanner(
                            adUnitId: 'ca-app-pub-6262607150176210/8943464259',
                            adSize: AdmobBannerSize.BANNER,
                            listener: (AdmobAdEvent event,
                                Map<String, dynamic>? args) {
                            },
                            onBannerCreated:
                                (AdmobBannerController controller) {
                            },
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.only(topRight: Radius.circular(70))),
                          child: Column(children: [
                            SizedBox(
                              height: 10,
                            ),
                            if (controller.activeToggledIndex == 0)
                              PdfWidget(
                                name: name,
                                year: year,
                                //chapter: chapter,
                              ),
                            if (controller.activeToggledIndex == 1)
                              VideoWidget(
                                name: name,
                               year: year,
                               // chapter: chapter,
                              ),
                          ]),
                        )),

                  ],
                ),
              ),
        ));
  }
}
