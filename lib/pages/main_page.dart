import 'package:flutter/material.dart';
import 'package:intern_suitmedia/pages/user_page.dart';

class MainPage extends StatefulWidget {
  final String name;
  const MainPage({Key? key, required this.name}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String selectedUser = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Second Screen',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            Text(
              widget.name,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(height: 250),
            Center(
              child: Text(
                (selectedUser == "") ? "Selected User Name" : selectedUser,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => const UserPage()))
                      .then((value) {
                    if (value != null) {
                      selectedUser = value[0];
                      setState(() {});
                      return;
                    }
                    selectedUser = "";
                    setState(() {});
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.indigo[800],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Choose a User',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
