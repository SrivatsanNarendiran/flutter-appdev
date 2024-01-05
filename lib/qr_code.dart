//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:university_buddy/welcome_page.dart';

class QRPage extends StatefulWidget {
  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  TextEditingController _editingController =
      TextEditingController(text: DateTime.now().toString());
  String? _data;
  String? _datetime;
  var formKey = GlobalKey<FormState>();
  var date = '', time = '', branch = '', code = '';
  int classroom = 0, sem = 0;
  String section = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Code Generator")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: 'Enter date of class DD/MM/YYYY',
                  labelText: 'Date',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter details";
                  } else {
                    date = value;
                  }
                }),
                SizedBox(
                  height: 8,
            ),
                  TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: 'Enter time of class',
                  labelText: 'Time',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter details";
                  } else {
                    time = value;
                  }
                }),
                SizedBox(
              height: 16,
            ),
                TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter classroom number',
                  labelText: 'Classroom',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter details";
                  } else {
                    classroom = int.parse(value);
                  }
                }),
                SizedBox(
              height: 16,
            ),
                TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Semester',
                  labelText: 'Semester',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter details";
                  } else {
                    sem = int.parse(value);
                  }
                }),
                SizedBox(
              height: 16,
            ),
                TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Branch of students',
                  labelText: 'Branch',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter details";
                  } else {
                    branch = value;
                  }
                }),
                SizedBox(
              height: 16,
            ),
                TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Subject Code',
                  labelText: 'Subject Code',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter details";
                  } else {
                    code = value;
                  }
                }),
                SizedBox(
              height: 16,
            ),
                TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Section',
                  labelText: 'Section',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter details";
                  } else {
                    section = value;
                  }
                }),
                SizedBox(
              height: 16,
            ),
                TextField(
                decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                controller: _editingController),
                RaisedButton(
              onPressed: () {
                setState(() {
                  if (formKey.currentState!.validate()) {
                    _data = _editingController.text + "-" + date + "-" +
                        time + "-" + classroom.toString() + "-" + branch +
                        "-" + sem.toString() + "-" + section + "-" + code;
                  }
                });

              },
                child: Text(
                "Generate QR",
              ),
            ),
                Padding(
                  padding: const EdgeInsets.all(70.0),
                  child: Center(
                    child: QrImage(
                    data: '$_data',
                    version: QrVersions.auto,
                    size: 400,
                  ),
              ),
            ),
          ],
        ),
      ),

    ))
    )
    ;
  }
}
