import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'globals.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String picture = Globals.defaultPic;
  String SE = Globals.se;
  String category = '';
  String? imageFile;

  // late String productName, productDesc, price;
  final productNameCtrl = TextEditingController();
  final productDescCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  final _categories = [
    "",
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile.path;
      });
    }
  }

  Future<void> _uploadFirebase(){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final bytes = io.File(imageFile!).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    return
  }

  @override
  void dispose() {
    // TODO: implement dispose
    productDescCtrl.dispose();
    productNameCtrl.dispose();
    priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: kIsWeb
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width,
                child: TextField(
                  controller: productNameCtrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Product Name'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: kIsWeb
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width,
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: const InputDecoration(
                          errorStyle: TextStyle(color: Colors.redAccent),
                          hintText: 'Category',
                          border: OutlineInputBorder()),
                      isEmpty: category == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: category,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              category = newValue!;
                              state.didChange(newValue);
                            });
                          },
                          items: _categories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
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
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 7,
                  controller: productDescCtrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Description'),
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
                  controller: priceCtrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Price'),
                ),
              ),
            ),
            imageFile != null
                ? (kIsWeb
                    ? Image.network(imageFile!, fit: BoxFit.cover)
                    : Image.file(
                        io.File(imageFile!),
                        fit: BoxFit.cover,
                      ))
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: kIsWeb
                          ? MediaQuery.of(context).size.width / 2
                          : MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text('Add Image')),
                        onPressed: () {
                          _getFromGallery();
                        },
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
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                      padding: EdgeInsets.all(15), child: Text('Submit')),
                  onPressed: () {

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
