import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_hackathon/upload.dart';

import 'globals.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> content = [
    Container(height: 20),
  ];

  // void pullData() {
  //   List<Widget> items = [];
  //   FirebaseFirestore.instance
  //       .collectionGroup('products')
  //       .where("se", isEqualTo: Globals.se)
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((doc) {
  //       String desc = doc['desc'];
  //       String cut = desc.substring(0, min(desc.length, 100)) + '...';
  //       Widget item = Padding(
  //         padding: const EdgeInsets.all(5),
  //         child: Container(
  //           width: 500,
  //           height: 100,
  //           child: Padding(
  //             padding: const EdgeInsets.all(15),
  //             child: Column(
  //               children: [
  //                 Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 2),
  //                     child: Text("Product Name: " + doc['name'])),
  //                 const Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 2),
  //                   child: Text("Product Description:"),
  //                 ),
  //                 Text(cut),
  //               ],
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //             ),
  //           ),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(5),
  //             border: Border.all(color: Colors.grey, width: 1),
  //           ),
  //         ),
  //       );
  //       items.add(item);
  //       print(items);
  //     });
  //     setState(() {
  //       content.addAll(items);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('products')
            .where("se", isEqualTo: Globals.se)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              padding: const EdgeInsets.all(5),
              children: snapshot.data!.docs.map((doc) {
                String desc = (doc.data()! as Map)['desc'];
                String cut = desc.substring(0, min(desc.length, 100)) + '...';
                return Align(
                  alignment: Alignment.center,
                  child: Card(
                    elevation: 2,
                    child: SizedBox(
                      width: kIsWeb
                          ? MediaQuery.of(context).size.width / 2
                          : MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Text("Product Name: " +
                                    (doc.data()! as Map)['name'])),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text("Product Description:"),
                            ),
                            Text(cut),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const Upload();
            }),
          );
          // pullData();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
