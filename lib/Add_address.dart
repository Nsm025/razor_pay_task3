import 'package:authentification/Accounts.dart';
import 'package:flutter/material.dart';
import 'Accounts.dart';

void main() => runApp(Address());

// ignore: must_be_immutable
class Address extends StatelessWidget {
  String title;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Address',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFB3E5FC),
        appBar: AppBar(
          title: Text('Address'),
        ),
        body: Center(child: AddressPage()),
      ),
    );
  }
}

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final fullname = new TextEditingController();
  final houseno = new TextEditingController();
  final locality = new TextEditingController();
  final city = new TextEditingController();
  final pincode = new TextEditingController();

  getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(
                  nameHolder: fullname.text,
                  housenoHolder: houseno.text,
                  locHolder: locality.text,
                  cityHolder: city.text,
                  pinHolder: pincode.text,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFB3E5FC),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: fullname,
                      autocorrect: true,
                      decoration: InputDecoration(hintText: 'Full Name'),
                    )),
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: houseno,
                      autocorrect: true,
                      decoration:
                          InputDecoration(hintText: 'HouseNo/BuildingNo'),
                    )),
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: locality,
                      autocorrect: true,
                      decoration: InputDecoration(hintText: 'Locality'),
                    )),
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: city,
                      autocorrect: true,
                      decoration: InputDecoration(hintText: 'City'),
                    )),
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: pincode,
                      autocorrect: true,
                      decoration: InputDecoration(hintText: 'Pincode'),
                    )),
                SizedBox(height: 20.0),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () => getItemAndNavigate(context),
                  color: Color(0xffFF1744),
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ));
  }
}

class SecondScreen extends StatelessWidget {
  final nameHolder;
  final housenoHolder;
  final locHolder;
  final cityHolder;
  final pinHolder;

  SecondScreen(
      {Key key,
      @required this.nameHolder,
      this.housenoHolder,
      this.locHolder,
      this.cityHolder,
      this.pinHolder})
      : super(key: key);

  goBack(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Accounts()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Show Address"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Text(
                'Full Name = ' + nameHolder,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                ' HouseNo/BuildingNo = ' + housenoHolder,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                'Locality = ' + locHolder,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                'City = ' + cityHolder,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )),
              Center(
                  child: Text(
                'Pincode = ' + pinHolder,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () => goBack(context),
                color: Colors.lightBlue,
                textColor: Colors.white,
                child: Text('Go Back'),
              )
            ]));
  }
}
