

   abstract class PaymentStates{




   }


   class paymentIntialSate extends PaymentStates{



   }


   class paymentSuccessSate extends PaymentStates{

   }


   class paymentErrorSate extends PaymentStates{


   String ? error;

   paymentErrorSate({this.error});


   }


   class paymentOrderIdSuccessSate extends PaymentStates{

   }


   class paymentOrderIdErrorSate extends PaymentStates{


      String ? error;

      paymentOrderIdErrorSate({this.error});


   }


   class paymentRequestTokenSate extends PaymentStates{

   }


   class paymentRequestTokenErrorSate extends PaymentStates{


      String ? error;

      paymentRequestTokenErrorSate({this.error});


   }


   class paymentRequestTokenKioskSate extends PaymentStates{

   }


   class paymentRequestTokenKioskErrorSate extends PaymentStates{


      String ?  error;

      paymentRequestTokenKioskErrorSate({this.error});


   }


   class paymentRefCodeSuccessSate extends PaymentStates{

   }


   class paymentRefCodeErrorSate extends PaymentStates{


      String ? error;

      paymentRefCodeErrorSate({this.error});


   }