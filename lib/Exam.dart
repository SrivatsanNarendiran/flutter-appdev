import 'package:flutter/material.dart';
import 'package:university_buddy/welcome_page.dart';
import 'package:firebase_database/firebase_database.dart';

class Exam extends StatefulWidget {
  const Exam({Key? key}) : super(key: key);

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  var formKey = GlobalKey<FormState>();
  var date = '', time = '', branch = '', code = '', srn = '';
  int classroom = 0, sem = 0;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Exam Creation")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
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
                    height: 16,
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Student SRN',
                        labelText: 'SRN',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter details";
                        } else {
                          srn  = value;
                        }
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: () {
                                formKey.currentState!.reset();
                              },
                              child: Text("Clear"))),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  //database code
                                  databaseRef.child("Exam")
                                      .child(date)
                                      .child(time)
                                      .child(classroom.toString())
                                      .child(branch)
                                      .child(sem.toString())
                                      .child(code)
                                      .child(srn)
                                      .set("Absent");

                                }
                              },
                              child: Text("Submit"))),
                    ],
                  )
                ],
              ))),
        ));
  }
}
