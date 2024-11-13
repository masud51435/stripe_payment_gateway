import 'package:dio/dio.dart';
import 'package:payment_gateway/pages/stripe/constants.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment() async {
    try {
      String? result = await _createPaymentIntent(10, "usd");
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': _calculateAmount(amount),
        'currency': currency,
        // 'payment_method_types': ['card'],
        // 'confirm': true
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
      if (response.statusCode == 200) {
        print(response.data);
        return "response.data";
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }
}
