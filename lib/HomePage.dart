//import 'dart:io';

import 'package:authentification/Add_address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authentification/Start.dart';
import 'package:authentification/razorpay.dart';
import 'package:authentification/Accounts.dart';
import 'Add_address.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

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

  signout() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: Column(
          children: [
            DrawerHeader(
              child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Hi There',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  height: 100,
                  color: Colors.black),
            ),
            ListTile(
              title: Text("Account"),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Accounts()));
              },
            ),
            ListTile(
              title: Text("Add Address"),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Address()));
              },
            ),
            ListTile(
              title: Text("Order History"),
              leading: Icon(Icons.money),
            ),
            ListTile(
              title: Text("Help & Support"),
              leading: Icon(Icons.phone),
            ),
            ListTile(
              title: Text("Updates"),
              leading: Icon(Icons.update),
            ),
            ListTile(
              title: Text("Log out"),
              leading: Icon(Icons.logout),
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Alert Message'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () => signout(),
                      child: Text('Yes,Logout'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
        appBar: AppBar(
          title: Text('HomePage'),
        ),
        body: SingleChildScrollView(
            child: Container(
          child: !isloggedin
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    SizedBox(height: 60.0),
                    Container(
                      height: 300,
                      child: Image(
                        image: AssetImage("images/welcome.jpg"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                      width: 50.0,
                    ),

                    Container(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Hello ${user.displayName} you are Logged in as ${user.email}",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    )),

                    SizedBox(height: 20.0),

                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                        child: Text("CheckIn")),

                    SizedBox(height: 20.0),

                    // ignore: deprecated_member_use
                  ],
                ),
        )));
  }
}
