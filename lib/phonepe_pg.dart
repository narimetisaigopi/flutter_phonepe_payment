import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phonepe_payment/checkout_page.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonepePg {
  int amount;
  BuildContext context;

  PhonepePg({required this.context, required this.amount});
  String marchentId = "PGTESTPAYUAT";
  String salt = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  int saltIndex = 1;
  String callbackURL = "https://www.google.com";
  String apiEndPoint = "/pg/v1/pay";

  init() {
    PhonePePaymentSdk.init("SANDBOX", null, marchentId, true).then((val) {
      print('PhonePe SDK Initialized - $val');
      startTransaction();
    }).catchError((error) {
      return <dynamic>{};
    });
  }

  startTransaction() {
    Map body = {
      "merchantId": marchentId,
      "merchantTransactionId": "MT7850590068188104",
      "merchantUserId": "MUID123", // login
      "amount": amount * 100, // paisa
      "callbackUrl": callbackURL,
      "mobileNumber": "9876543210", // login
      "paymentInstrument": {"type": "PAY_PAGE"}
    };
    // base64
    String bodyEncoded = base64Encode(utf8.encode(jsonEncode(body)));
    // checksum =
    // base64Body + apiEndPoint + salt
    var byteCodes = utf8.encode(bodyEncoded + apiEndPoint + salt);
    // sha256
    String checksum = "${sha256.convert(byteCodes)}###+$saltIndex";
    PhonePePaymentSdk.startTransaction(bodyEncoded, callbackURL, checksum, "")
        .then((success) {
      log("Payment success ${success}");
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (a) => CheckoutPage()), (e) => false);
    }).catchError((error) {
      log("Payment failed ${error}");
    });
  }
}
