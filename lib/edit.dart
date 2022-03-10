import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_hackathon/globals.dart';
import 'package:gdsc_hackathon/home.dart';
import 'dart:io' as io;
import 'dart:async';

import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key, this.data}) : super(key: key);

  final dynamic data;

  @override
  State<StatefulWidget> createState() => _EditState();
}

class _EditState extends State<EditPage> {
  String picture = Globals.defaultPic;
  String SE = Globals.se;
  String category = '';

  _delete() {
    FirebaseFirestore.instance
        .collectionGroup('products')
        .where("se", isEqualTo: Globals.se)
        .where("id", isEqualTo: widget.data['id'])
        .get()
        .then((snapshot) {
          snapshot.docs[0].reference.delete();
          return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Product"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.memory(base64Decode(widget.data['picture'])),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Product Name: ' + widget.data['name']),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Category: ' + widget.data['category']),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width,
                    child: TextFormField(
                      enabled: false,
                      minLines: 1,
                      maxLines: 7,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Description: ' + widget.data['desc']),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Price: ' + widget.data['price']),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: const Padding(
                          padding: EdgeInsets.all(15), child: Text('Delete')),
                      onPressed: () {
                        _delete();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
