import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import '../State Managment/task.dart';
import '../service/addtask.dart';
import '../service/chat.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime now = DateTime.now();
  String dateFormat = DateFormat('EEEE d/M/y').format(DateTime.now());
  DateTime selectedDate = DateTime.now();

  bool isChecked = false;
  int selectedIndex = 0;
  bool isLoading = false;

  Color indigo = const Color(0xFF3F51B5);
  Color lightBlue = const Color(0xFF29B6F6);
  Color green = const Color(0xFF4CAF50);

  final TaskController controller = Get.put(TaskController());

  Query dbRef = FirebaseDatabase.instance.ref().child('Activity');
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Activity');

  /* Future<void> fetchData(DateTime selectedDate) async {
    var selectedData = await dbRef
        .orderByChild("date")
        .equalTo(selectedDate.toString())
        .once();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Today's Task", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.1,
        centerTitle: true,
      ),
      body: Column(children: [
        Container(height: 20),
        /* DatePicker(
          selectedDate,
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.black,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            fetchData(date);
          },
        ), */
        Container(height: 20),
        Expanded(
          child: FirebaseAnimatedList(
              query: dbRef,
              defaultChild: const Center(child: CircularProgressIndicator()),
              itemBuilder: (context, snapshot, animation, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 249, 250, 255),
                    title: Center(
                        child: Text(
                      snapshot.child('title').value.toString(),
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Before: ${snapshot.child('Description').value.toString()}",
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            "After: ${snapshot.child('Member').value.toString()}",
                            style: GoogleFonts.openSans(
                              fontSize: 16, // Adjust the font size as needed
                              fontWeight: FontWeight
                                  .bold, // You can change the font weight
                              color: Colors.green, // Change the text color
                            ),
                          ),
                        ]),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(snapshot.child('date').value.toString()),
                        Text(snapshot.child("dayName").value.toString()),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.to(() => Task(hint: 'Enter Your Title', title: "Title")),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
