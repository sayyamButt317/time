import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Controller/taskcontroller.dart';

class Task extends StatefulWidget {
  Task({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  int selectedColor = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late TextEditingController _titleController;
  late TextEditingController _desController;
  /* widget.controller ?? TextEditingController(); */
  late TextEditingController _memberController;
  late TextEditingController _dateController;

  DateTime selectedDate = DateTime.now();

  Color indigo = const Color(0xFF3F51B5);
  Color lightBlue = const Color(0xFF29B6F6);
  Color green = const Color(0xFF4CAF50);
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Activity');
  final Controller getxcontroller = Get.put<Controller>(Controller());

  @override
  void initState() {
    super.initState();
    _titleController = widget.controller ?? TextEditingController();
    _memberController = widget.controller ?? TextEditingController();
    _desController = widget.controller ?? TextEditingController();
    _dateController = widget.controller ??
        TextEditingController(
          text: DateFormat.yMd().format(DateTime.now()),
        );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _desController.dispose();
    _dateController.dispose();
    _memberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Add Task",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 8.0,
          top: 8.0,
          bottom: 8.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Disease",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Disease here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                controller: _titleController,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Before Medicine",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Before Medicine',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                controller: _desController,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "After Medicine",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: _memberController,
                decoration: InputDecoration(
                  hintText: 'Enter After Medicine',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Date",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: DateFormat.yMd().format(selectedDate),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      _getdatefromuser();
                    },
                    child: const Icon(Icons.calendar_today_outlined),
                  ),
                ),
                controller: _dateController,
              ),
              const SizedBox(height: 18),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /* _colorPallete(), */
                    MaterialButton(
                        onPressed: () => _storeData(),
                        height: 40,
                        minWidth: 80,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.black,
                        child: loading
                            ? const CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white)
                            : const Text(
                                "Create",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))
                  ])
            ],
          ),
        ),
      ),
    );
  }

  _getdatefromuser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickerDate != null) {
      setState(() {
        selectedDate = pickerDate;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    } else {
      debugPrint('its a null or something wrong');
    }
  }

  Future<void> _storeData() async {
    if (_titleController.text.isNotEmpty &&
        _desController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _memberController.text.isNotEmpty) {
      /* int colorIndex = widget.selectedColor;
      String colorTable = '';
      switch (colorIndex) {
        case 0:
          colorTable = 'indigo';
          break;
        case 1:
          colorTable = 'lightBlue';
          break;
        case 2:
          colorTable = 'green';
          break;
        default:
          colorTable = 'indigo';
      } */

      String dayName = DateFormat('EEEE').format(selectedDate);
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child('Activity').push();
      await databaseRef.set({
        'title': _titleController.text.toString(),
        'Description': _desController.text.toString(),
        'Member': _memberController.text.toString(),
        'date': _dateController.text.toString(),
        'dayName': dayName,
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
      }).then((value) {
        Fluttertoast.showToast(
          msg: "Task Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        getxcontroller.isprofileloading(false);
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Warning!",
          "Failed to add task!",
          backgroundColor: Colors.transparent,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          colorText: Colors.red,
          borderWidth: 1,
          borderColor: Colors.red,
        );
        getxcontroller.isprofileloading(false);
      });
    } else {
      Get.snackbar(
        "Warning!",
        "All fields are required!",
        backgroundColor: Colors.transparent,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        colorText: Colors.red,
        borderWidth: 1,
        borderColor: Colors.red,
      );
    }
  }

  /* _colorPallete() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Color",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: GoogleFonts.lato().fontFamily,
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      Wrap(
        children: List<Widget>.generate(
          3,
          (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  widget.selectedColor = index;
                  debugPrint("$index");
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? indigo
                      : index == 1
                          ? lightBlue
                          : green,
                  child: widget.selectedColor == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          },
        ),
      )
    ]);
  } */
}
