import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Day extends StatefulWidget {
  const Day({super.key});

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        selectedDayPredicate: (date) {
          return isSameDay(date, _selectedDate);
        },
      ),
    );
  }
}
