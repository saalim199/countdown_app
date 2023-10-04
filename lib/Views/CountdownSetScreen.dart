import 'package:countdown_app/Resources/Firestore_Methods.dart';
import 'package:countdown_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountdownSetScreen extends StatefulWidget {
  const CountdownSetScreen({super.key});

  @override
  State<CountdownSetScreen> createState() => _CountdownSetScreenState();
}

class _CountdownSetScreenState extends State<CountdownSetScreen> {
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime? pickedDate;
  DateTime? finalTime;

  @override
  void dispose() {
    super.dispose();
    _eventController.dispose();
    _descController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobilebackgroundColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Set Countdown'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _eventController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Enter Event Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descController,
              keyboardType: TextInputType.text,
              maxLines: 2,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Enter Event Details',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onTap: () async {
                pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate!);
                  setState(() {
                    _dateController.text = formattedDate;
                  });
                  print(_dateController.text);
                }
              },
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                icon: const Icon(Icons.calendar_today),
                filled: true,
                labelText: 'Enter Date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  String format = pickedTime.hour.toString() +
                      " " +
                      pickedTime.minute.toString();
                  setState(() {
                    _timeController.text = format;
                    finalTime = DateTime(pickedDate!.year, pickedDate!.month,
                        pickedDate!.day, pickedTime.hour, pickedTime.minute);
                  });
                  print(_timeController.text);
                  print(finalTime);
                }
              },
              controller: _timeController,
              readOnly: true,
              decoration: InputDecoration(
                icon: const Icon(Icons.timer),
                filled: true,
                labelText: 'Enter Time',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () async {
                    if (_eventController.text.isEmpty ||
                        _descController.text.isEmpty ||
                        _dateController.text.isEmpty ||
                        _timeController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please fill all the fields',
                            style: TextStyle(color: Colors.red),
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      await FirestoreMethods().setDateTime(finalTime!,
                          _eventController.text, _descController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
