import 'package:authentification/Add_address.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:authentification/Start.dart';
import 'HomePage.dart';
import 'Add_address.dart';

void main() => runApp(Accounts());

// ignore: must_be_immutable
class Accounts extends StatelessWidget {
  Accounts({Key key, this.title = ''}) : super(key: key);
  String title;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Account',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff123456),
        appBar: AppBar(
          title: Text('Account'),
        ),
        body: Center(child: AccountsPage(title: 'Account')),
      ),
    );
  }
}

class AccountsPage extends StatefulWidget {
  AccountsPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
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

  @override
  void initState() {
    super.initState();
    //  this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff123456),
        body: SingleChildScrollView(
          child: Container(
            child: !isloggedin
                ? CircularProgressIndicator()
                : Column(children: <Widget>[
                    SizedBox(height: 35.0),
                    Container(
                      height: 400,
                      child: Center(
                        child: Image.network(
                            "https://png.pngtree.com/png-vector/20191003/ourmid/pngtree-user-login-or-authenticate-icon-on-gray-background-flat-icon-ve-png-image_1786166.jpg",
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      color: Colors.red,
                      child: Center(
                        child: Text('NAME: ${user.displayName}'),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 50,
                      width: 200,
                      color: Colors.red,
                      child: Center(
                        child: Text('EMAIL: ${user.email}'),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Address()));
                        },
                        child: Text("Add address")),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Text("Back")),
                  ]),
          ),
        ));
  }
}
