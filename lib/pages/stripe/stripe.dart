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
        child: ElevatedButton(
          onPressed: () {
            StripeService.instance.makePayment();
          },
          child: const Text('Pay Now'),
        ),
      ),
    );
  }
}
