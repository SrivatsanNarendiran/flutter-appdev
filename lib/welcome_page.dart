import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:university_buddy/login_page.dart';
import 'package:university_buddy/auth_controller.dart';
import 'package:university_buddy/qr_code.dart';
import 'package:university_buddy/class.dart';
import 'package:university_buddy/Exam.dart';
import 'package:university_buddy/Section.dart';
import 'package:university_buddy/Student.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  String email;

  WelcomePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("MENU BAR"),
        backgroundColor: Colors.pink[700],
      ),
      backgroundColor: Colors.pink[100],
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text((email.split('@')[0]).split('.').join(' '),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0)),
              accountEmail: new Text(
                email,
                style: TextStyle(fontSize: 18, color: Colors.grey[500]),
              ),
              //need to add profile pic here
              decoration: new BoxDecoration(color: Colors.pink[300]),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
            ),
            ListTile(
              leading: Icon(Icons.password),
              title: Text("Change Password"),
            ),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text("LogOut"),
                onTap: () => Get.to(() => LoginPage())),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Exit App"),
                onTap: () {
                  SystemNavigator.pop();
                }),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            MyMenu(
              title: "Class",
              icon: Icons.school,
              warna: Colors.orange,
            ),
            MyMenu(
              title: "QR Scanner",
              icon: Icons.qr_code_scanner_outlined,
              warna: Colors.brown,
            ),
            MyMenu(
              title: "Section",
              icon: Icons.room,
              warna: Colors.blueGrey,
            ),
            MyMenu(
              title: "Exam",
              icon: Icons.quiz,
              warna: Colors.red,
            ),
            MyMenu(
              title: "View",
              icon: Icons.table_view,
              warna: Colors.teal,
            ),
            MyMenu(
              title: "LogOut",
              icon: Icons.logout,
              warna: Colors.brown,
            ),
            MyMenu(
                title: "Students", icon: Icons.person, warna: Colors.deepPurple)
          ],
        ),
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({required this.title, required this.icon, required this.warna});

  final String title;
  final IconData icon;
  final MaterialColor warna;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
          splashColor: Colors.pink,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  size: 70.0,
                  color: warna,
                ),
                Text(title, style: new TextStyle(fontSize: 17.0)),
              ],
            ),
          ),
          onTap: () {
            if (title == "LogOut") {
              Get.to(() => LoginPage());
            } else if (title == "QR Scanner") {
              Get.to(() => QRPage());
            } else if (title == "Class") {
              Get.to(() => Class());
            } else if (title == "Exam") {
              Get.to(() => Exam());
            } else if (title == "Section") {
              Get.to(() => Section());
            } else if (title == "Students") {
              Get.to(() => Student());
            }
          }),
    );
  }
}
