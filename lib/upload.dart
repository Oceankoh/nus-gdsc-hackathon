import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'globals.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String picture = Globals.defaultPic;
  String SE = Globals.se;
  String category = '';

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

  File _imageFile;

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );
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
            Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: kIsWeb
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                        padding: EdgeInsets.all(15), child: Text('Submit')),
                    onPressed: () {},
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
