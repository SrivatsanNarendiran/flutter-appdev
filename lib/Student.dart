import 'package:flutter/material.dart';
import 'package:university_buddy/welcome_page.dart';
import 'package:firebase_database/firebase_database.dart';

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  var formKey = GlobalKey<FormState>();
  var srn = '', branch = '', section = '';
  int sem = 0 ;
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
                      TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter SRN',
                            labelText: 'SRN',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter details";
                            } else {
                              srn = value;
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
                                      databaseRef.child("Student")
                                          .child(sem.toString())
                                          .child(branch)
                                          .child(section)
                                          .child(srn)
                                          .set("Have to get details");

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