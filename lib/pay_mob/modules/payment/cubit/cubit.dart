


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thanawy2022/pay_mob/constants/const.dart';
import 'package:thanawy2022/pay_mob/models/first_token.dart';
import 'package:thanawy2022/pay_mob/modules/payment/cubit/states.dart';
import 'package:thanawy2022/pay_mob/network/dio.dart';

class paymentCubit extends Cubit<PaymentStates>{
  paymentCubit() : super(paymentIntialSate());

  static paymentCubit get(context)=> BlocProvider.of(context);


   //FirstToken  firstToken=FirstToken();

   Future getFirstToken ({required String price,required String email,
       required String fname,required String lname,required String phonenum})async{

     DioHelperPayment.postData(url:'auth/tokens',data:{
       'api_key':paymobApiKey,
     }, query: {} ).then((value) {

        print("tt");
     //  firstToken=FirstToken.fromJson(value.data);
       paymobFirstToken=value.data['token'];
       //firstToken.token.toString();
       print("First token ="+paymobFirstToken.toString());
       getOrderId(price,email,fname,lname,phonenum);
       emit(paymentSuccessSate());

     }).catchError((error){
       print("api:::$paymobApiKey");
       print("ttxxx"+error.toString());
       emit(paymentErrorSate());
     });

   }



  Future getOrderId(String price,String email,String fname,String lname,String phonenum)async{

    DioHelperPayment.postData(url:'ecommerce/orders',data:{
      'auth_token':paymobFirstToken,
      'delivery_needed':'false',
      'amount_cents': price,
      "items": [
        {
          "name": "trip",
          "amount_cents": "$price",
         // "description": "from$city",
          "quantity": "1"
        },
        // {
        //   "name": "ERT6565",
        //   "amount_cents": "200000",
        //   "description": "Power Bank",
        //   "quantity": "1"
        // }
      ],
      "currency": "EGP",


    }, query: {} ).then((value) {

      print("tt");
      //  firstToken=FirstToken.fromJson(value.data);
      orderId=value.data['id'].toString();

      //firstToken.token.toString();
      print(" order id ="+orderId.toString());
      getFinalTokenCard(price,email,fname,lname,phonenum);
      getFinalTokenKiosk(price);
      emit(paymentOrderIdSuccessSate());


    }).catchError((error){
      print("ttxxx22222"+error.toString());
      emit(paymentOrderIdErrorSate());
    });

  }


  Future getFinalTokenCard(String price,String email, String fname,String lname,String phonenum )async{

     if(phonenum.startsWith('+20')){
       phonenum=phonenum;
     }else{
       phonenum='+2'+phonenum;
     }
    DioHelperPayment.postData(url:'acceptance/payment_keys',data:

    {
      "auth_token":paymobFirstToken,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": orderId,
      "billing_data": {
        "apartment": "803",
        "email":email,
        "floor": "42",
        "first_name": fname,
        "street": "Ethan Land",
        "building": "8028",
        "phone_number": phonenum,
        "shipping_method": "PKG",
        "postal_code": "01898",
        "city": "Jaskolskiburgh",
        "country": "EG",
        "last_name": lname,
        "state": "cairo"
      },
      "currency": "EGP",
      "integration_id": integrationIdCard,
      "lock_order_when_paid": "false"
    }, query: {}


    ).then((value) {

      print("ttCard");
      //  firstToken=FirstToken.fromJson(value.data);
      FinalTokenCard=value.data['token'].toString();

      //firstToken.token.toString();
      print("Final Token  ="+FinalTokenCard.toString());
      emit((paymentRequestTokenSate()));


    }).catchError((error){
      print("ttxxx3333333"+error.toString());
      emit(paymentRequestTokenErrorSate());
    });

  }


  Future getFinalTokenKiosk(String price)async{

    DioHelperPayment.postData(url:'acceptance/payment_keys',data:

    {
      "auth_token":paymobFirstToken,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": orderId,
      "billing_data": {
        "apartment": "803",
        "email": "claudette09@exa.com",
        "floor": "42",
        "first_name": "Clifford",
        "street": "Ethan Land",
        "building": "8028",
        "phone_number": "+86(8)9135210487",
        "shipping_method": "PKG",
        "postal_code": "01898",
        "city": "Jaskolskiburgh",
        "country": "CR",
        "last_name": "Nicolas",
        "state": "Utah"
      },
      "currency": "EGP",
      "integration_id": itegrationIdKiosk,
      "lock_order_when_paid": "false"
    }, query: {}


    ).then((value) {

      print("tt");
      //  firstToken=FirstToken.fromJson(value.data);
      FinalTokenKiosk=value.data['token'].toString();

      //firstToken.token.toString();
      print(" Final Token kiosk  ="+FinalTokenKiosk.toString());
      getRefCode();
      emit((paymentRequestTokenKioskSate()));


    }).catchError((error){
      print("ttxxx4444"+error.toString());
      emit(paymentRequestTokenKioskErrorSate());
    });

  }



  Future getRefCode()async{

    DioHelperPayment.postData(url:'acceptance/payments/pay',data:


    {
      "source": {
        "identifier": "AGGREGATOR",
        "subtype": "AGGREGATOR"
      },
      "payment_token": FinalTokenKiosk
    }, query: {}

    ).then((value) {

      print("tt");
      //  firstToken=FirstToken.fromJson(value.data);
      RefCode=value.data['id'].toString();

      //firstToken.token.toString();
      print(" Ref  code  ="+RefCode.toString());
      emit((paymentRefCodeSuccessSate()));


    }).catchError((error){
      print("ttxxx6666"+error.toString());
      emit(paymentRefCodeErrorSate());
    });

  }
}