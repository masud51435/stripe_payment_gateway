import 'package:flutter/material.dart';
import 'package:payment_gateway/pages/stripe/stripe_service/stripe_service.dart';

class StripePaymentPage extends StatefulWidget {
  const StripePaymentPage({super.key});

  @override
  State<StripePaymentPage> createState() => _StripePaymentPageState();
}

class _StripePaymentPageState extends State<StripePaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment Gateway'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:  SizedBox(
            height: 60,
            width: double.infinity,
            child: InkWell(
              onTap: () {
                StripeService.instance.makePayment();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF439cfb),
                      Color(0xFFf187fb),
                    ],
                    transform: GradientRotation(70),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
