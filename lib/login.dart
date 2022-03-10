import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_hackathon/globals.dart';
import 'package:gdsc_hackathon/home.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final userCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();

  @override
  void dispose() {
    userCtrl.dispose();
    pwdCtrl.dispose();
    super.dispose();
  }

  _login() async {
    print(MediaQuery.of(context).size.width);
    await FirebaseFirestore.instance
        .collectionGroup('enterprises')
        .where("name", isEqualTo: userCtrl.text)
        .where("pwd", isEqualTo: pwdCtrl.text)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        Globals.se = doc['name'];
      }
    });
    return Globals.se.isNotEmpty;
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
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: kIsWeb
                    ? (MediaQuery.of(context).size.width < 1100 ? MediaQuery.of(context).size.width * 0.8: MediaQuery.of(context).size.width * 0.5)
                    : MediaQuery.of(context).size.width,
                child: TextField(
                  controller: userCtrl,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Username'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: kIsWeb
                    ? (MediaQuery.of(context).size.width < 1100 ? MediaQuery.of(context).size.width * 0.8: MediaQuery.of(context).size.width * 0.5)
                    : MediaQuery.of(context).size.width,
                child: TextField(
                  controller: pwdCtrl,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Password'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: kIsWeb
                    ? (MediaQuery.of(context).size.width < 1100 ? MediaQuery.of(context).size.width * 0.8: MediaQuery.of(context).size.width * 0.5)
                    : MediaQuery.of(context).size.width,
                child: MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                      padding: EdgeInsets.all(15), child: Text('Login')),
                  onPressed: () async  {
                    if (await _login()) {
                      Route route = MaterialPageRoute(builder: (context) => MyHomePage(title: Globals.se + " products"));
                      Navigator.pushReplacement(context, route);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
