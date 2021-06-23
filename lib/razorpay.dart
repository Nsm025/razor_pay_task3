import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:authentification/Start.dart';

import 'package:authentification/HomePage.dart';

void main() => runApp(MyApp());

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key key, this.title = ''}) : super(key: key);
  String title;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Razor_pay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Razor_pay'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name, pass;

  String storedName, storedPass;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  bool isloggedin = false;
  // checkAuthentification() async {
  //   _auth.authStateChanges().listen((user) {
  //     if (user == null) {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Start()));
  //     }
  //   });
  // }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  Razorpay _razorpay;
  bool suc = false;

  @required
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // this.checkAuthentification();
    this.getUser();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse payS) {
    Fluttertoast.showToast(
        msg: "Your payment has done successfully" + payS.paymentId);
    setState(() {
      suc = true;
    });
  }

  void _handlePaymentError(PaymentFailureResponse res) {
    Fluttertoast.showToast(
        msg: "You paymemnt has failed and the reason is : " + res.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "redirecting to external waaltt" + response.walletName);
  }

  void callRazorpay() async {
    var options = {
      'key': 'rzp_test_gKfhlMzPl22LGN',
      'amount': 18000,
      'name': '${user.displayName}',
      'description': ' for order Payment',
      'prefill': {'contact': '9010590694', 'email': '${user.email}'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (msg) {
      print(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 35.0),
            Container(
              height: 400,
              child: Center(
                child: Image.network(
                    "https://media.glassdoor.com/sqll/1146550/razorpay-squarelogo-1513366840606.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  callRazorpay();
                },
                child: Text("Checkout to Razorpay")),
            SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text("Back")),
            Text(suc ? "Payment is done" : ""),
          ],
        ),
      ),
    );
  }
}
