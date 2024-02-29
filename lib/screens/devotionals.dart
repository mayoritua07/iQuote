import 'package:flutter/material.dart';

class DevotionalScreen extends StatefulWidget {
  const DevotionalScreen({super.key});
  @override
  State<DevotionalScreen> createState() {
    return _DevotionalScreenState();
  }
}

class _DevotionalScreenState extends State<DevotionalScreen> {
  void selectDate() {
    // DatePickerDialog(
    //     initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: selectDate, icon: const Icon(Icons.calendar_month))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height / 10,
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: Text("Devotional",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
