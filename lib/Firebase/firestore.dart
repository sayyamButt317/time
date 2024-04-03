import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore extends StatefulWidget {
  const Firestore({super.key});

  @override
  State<Firestore> createState() => _FirestoreState();
}

class _FirestoreState extends State<Firestore> {
  //Create a collection to store data"
  var collection = FirebaseFirestore.instance.collection("userpost");

  late List<Map<String, dynamic>> items;

  void getallthedata() async {
    //Create a list with templist name
    List<Map<String, dynamic>> templist = [];
    //create a variable and get the collection data
    var data = await collection.get();
    //use docs word and usefoeach loop to get all the element data
    data.docs.forEach((element) {
      //add all the element data into templist
      templist.add(element.data());
    });
  }

  //store data into firestore
  void adddata() async {
    await collection.add({
      "name": "syyambutt",
      "age": "22",
      "job": "terminated employ",
      "time": Timestamp.now(),
    });
  }

  void firestoreQuery() async {
    //get all the document in a collection
    var numberofuser = await collection.get();
    //get the first document  Id
    var firstdocId = numberofuser.docs.first.id;
    //get the last document Id
    var lastdocId = numberofuser.docs.last.id;
    //update the specific user data
    await collection.doc(firstdocId).set({
      "name": "sayyam",
      "age": 23,
      "jobtitle": "useless",
      "time": Timestamp.now(),
    });

//use a where to set conditions and get specific data
    Future<void> whereclause() async {
      var query = await collection.where("age", isLessThanOrEqualTo: 23).get();
    }

    print(firstdocId);
    print(lastdocId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () => adddata(),
          child: const Text("Post"),
        ),
        ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                subtitle: Text(items[index]["jobtitle"] ?? "Unemployed"),
                title: Row(
                  children: [
                    Text(items[index]["name"] ?? "Not Given"),
                  ],
                ),
              );
            })
      ],
    ));
  }
}
