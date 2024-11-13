import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateway/pages/stripe/constants.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(10, "usd");
      if (paymentIntentClientSecret != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: "Sahariyar Mahmud",
          ),
        );
        await _processPayment();
      } else {
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': _calculateAmount(amount),
        'currency': currency,
        //"payment_method_types": ["card", "link"],
        //'confirm': true
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": 'Bearer $stripeSecretApiKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.data != null) {
        // print(response.data);
        return response.data["client_secret"];
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }
}
