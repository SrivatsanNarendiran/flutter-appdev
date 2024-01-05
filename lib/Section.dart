import 'package:flutter/material.dart';
import 'package:university_buddy/welcome_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';


class Section extends StatefulWidget {
  const Section({Key? key}) : super(key: key);

  @override
  State<Section> createState() => _SectionState();
}



class _SectionState extends State<Section> {
  var formKey = GlobalKey<FormState>();
  String roomnumber = '';
  String classlati = '' , classlong = '' ;
  String classcoordinates = '';
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Section Creation")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Classroom number',
                        labelText: 'Classroom Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter details";
                        } else {
                          roomnumber = value;
                        }
                      }),
                  SizedBox(
                    height: 16,
                  ),

                  TextFormField(
                      decoration: InputDecoration(
                        hintText: 'These will be automatically loaded. You can enter if you wish to',
                        labelText: 'Class Coordinates',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          classcoordinates = "Default";
                        } else {
                          classcoordinates = value;
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
                              onPressed:  () async {
                                if (formKey.currentState!.validate()) {
                                  //Geolocation Coordinates Code
                                  Future<Position> location =  _determinePosition();
                                  if(location.runtimeType != null) {
                                    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation );
                                    databaseRef.child("Classroom")
                                        .child(roomnumber)
                                        .child("Latitude")
                                        .set(position.latitude.toString());
                                    databaseRef.child("Classroom")
                                        .child(roomnumber)
                                        .child("Longitude")
                                        .set(position.longitude.toString());
                                  }

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
