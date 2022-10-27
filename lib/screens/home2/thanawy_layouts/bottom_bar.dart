

   import 'package:flutter/material.dart';
import 'package:thanawy2022/resources/color_manager.dart';
import 'package:thanawy2022/widgets/custom_text.dart';
import 'package:thanawy2022/widgets/drawer.dart';
import '../premeium/premium.dart';
import 'choose_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {


  int myIndex = 0;
  List<Widget> widgetList = [

    ChooseScreen(),
    PremiumLayout(),

  ];
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
      drawer:MainDrawer(),
      body: Center(
        child: widgetList[myIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          selectedItemColor: ColorManager.white,
          unselectedItemColor: Colors.grey,
          backgroundColor: ColorManager.primary,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
            BottomNavigationBarItem(icon: Icon(Icons.workspace_premium), label: "اشتراك السوبر"),
          ]),
    );
  }
}
