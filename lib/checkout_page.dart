import 'package:flutter/material.dart';
import 'package:flutter_phonepe_payment/phonepe_pg.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: "Enter amount", border: OutlineInputBorder()),
            ),
            ElevatedButton(
                onPressed: () {
                  PhonepePg(context: context, amount: int.parse(textEditingController.text)).init();
                },
                child: const Text("Check out"))
          ],
        ),
      ),
    );
  }
}
