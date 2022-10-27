import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:thanawy2022/pay_mob/modules/payment/cubit/cubit.dart';
import 'package:thanawy2022/pay_mob/modules/payment/cubit/states.dart';
import 'package:thanawy2022/pay_mob/modules/payment/cubit/toogle.dart';
import 'package:thanawy2022/resources/color_manager.dart';
import 'package:thanawy2022/screens/pdfs/pdf_api.dart';
import 'package:thanawy2022/widgets/custom_formfield.dart';
import 'package:thanawy2022/widgets/custom_text.dart';
import 'package:thanawy2022/widgets/pdfs_widget.dart';


class PaymentLayout extends StatelessWidget {
  String courseName, name,prem;
  double price;
  bool premuim;

  PaymentLayout(
      {required this.courseName,
      required this.name,
      required this.prem,
      required this.price,
      required this.premuim});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    bool? v = false;
    Color color = Colors.grey;
   // double total=double.parse('price')/100;

  double total=price/100;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.primary,
        toolbarHeight: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                height: 30,
              ),
              if (premuim == true)
                Container(
                  width: 400,
                  color:ColorManager.primary2,
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: 12,),
                        Custom_Text(text:  "$courseName",fontSize: 26,alignment:Alignment.center, ),

                        SizedBox(
                          height: 20,
                        ),
                        if(name!="")
                        Text(
                          "$name",
                          style: TextStyle(color: Colors.black, fontSize: 26),
                        ),
                        Custom_Text(text:  "السعر =  $total",fontSize: 26,alignment:Alignment.center, ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),

              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: nameController,
                text: "الاسم",
                obx: false,
                obs: false,
                hint: "ادخل اسمك ثلاثي",
                color: Colors.black,
                onSave: () {},
                validator: () {
                  // if(nameController.text.length<5){
                  //   return 'ادخل اسمك الثلاثي بشكل صحيح';
                  // }
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: lastnameController,
                text: "الاسم",
                obx: false,
                obs: false,
                hint: "ادخل اسمك الاخير",
                color: Colors.black,
                onSave: () {},
                validator: () {
                  // if(nameController.text.length<5){
                  //   return 'ادخل اسمك الثلاثي بشكل صحيح';
                  // }
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: emailController,
                text: "البريد الالكتروني",
                obx: false,
                obs: false,
                hint: "ادخل البريد الالكتروني الخاص بك",
                color: Colors.black,
                onSave: () {},
                validator: () {
                  // if(emailController.text.length<7){
                  //   return 'ادخل بريدك بشكل صحيح';
                  // }
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: phoneController,
                text: "رقم موبايلك",
                obx: false,
                obs: false,
                hint: "ادخل رقم موبايلك ",
                color: Colors.black,
                onSave: () {},
                validator: () {
                  // if(emailController.text.length<7){
                  //   return 'ادخل بريدك بشكل صحيح';
                  // }
                },
              ),
              SizedBox(
                height: 20,
              ),
              StatefulBuilder(builder: (context, setState) {
                return Row(
                  children: [
                    Material(
                      child: Checkbox(
                        focusColor: Colors.lightBlue,
                        activeColor: Colors.grey,
                        tristate: true,
                        value: v,
                        onChanged: (value) {
                          setState(() {
                            v = value;
                            print(v);
                            if (v == true) {
                              color = Colors.redAccent;
                            } else {
                              color = Colors.grey;
                            }
                          });
                        },
                        checkColor: ColorManager.primary,
                      ),
                    ),
                    InkWell(
                      child: Custom_Text(
                          text: 'سياسة التطبيق',
                          fontSize: 12,
                          alignment: Alignment.center,
                          color: Colors.grey),
                      onTap: () async {
                        final url =
                            'https://firebasestorage.googleapis.com/v0/b/thanawyaapp.appspot.com/o/arabic%2Fملخص%20بلاغة.pdf?alt=media&token=24609081-aee8-4a71-9af9-acb30ba18783';
                        final file = await PDFApi.loadNetwork(url);
                        openPDF(file);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'اوافق علي سياسة  الدفع بالتطبيق',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                );
              }),
              SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (context) => paymentCubit(),
                child: BlocConsumer<paymentCubit, PaymentStates>(
                  listener: (context, state) {
                    // add when paymob is live
                    if (state is paymentRefCodeSuccessSate) {
                      Get.to(ToogleScreen(
                        name: nameController.text,
                        courseName: courseName,
                        total: price.toString(),
                        courseChapter: name,
                        email: emailController.text,
                        status: 'pending',
                        premuim: premuim,
                        prem:prem
                      ));
                    }
                  },
                  builder: (context, state) {
                    return RaisedButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 56,
                            width: double.infinity,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: ColorManager.primary,
                              //ColorManager.primary,
                              onPressed: () {
                                if (v == true) {

                                  if (emailController.text.contains('@') ==
                                          true &&
                                      nameController.text.length > 2 &&
                                      lastnameController.text.length > 2 &&
                                      phoneController.text.length > 8) {
                                    print("emailCon:" + emailController.text);
                                    print("nameCon:" + nameController.text);
                                    paymentCubit
                                        .get(context)
                                        .getFirstToken(
                                            price: price.toString(),
                                            email: emailController.text,
                                            fname: nameController.text,
                                            lname: lastnameController.text,
                                            phonenum: phoneController.text)
                                        .then((value) =>
                                            print("valueeeeex:::$value"));
                                    Get.to(ToogleScreen(
                                      courseName: courseName,
                                      courseChapter: name,
                                      premuim: premuim,
                                      status: 'pending',
                                      total: price.toString(),
                                      email: emailController.text,
                                      name: nameController.text,
                                      prem: prem,
                                    ));
                                  } else {
                                    Get.snackbar(
                                        'خطا', 'يجب ادخال البيانات بشكل صحيح');
                                  }
                                }
                                else{
                                  Get.snackbar('خطا', 'يجب ان توافق علي سياسة الدفع');
                                }
                              },
                              child: Text(
                                "استمر للدفع".tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontFamily: "Reboto",
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ),
                        textColor: Colors.white,
                        color: ColorManager.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {});
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
