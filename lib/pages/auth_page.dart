import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_suitmedia/pages/main_page.dart';
import 'package:intern_suitmedia/widgets/form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late TextEditingController name;
  late TextEditingController palindrome;

  @override
  void initState() {
    name = TextEditingController();
    palindrome = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    palindrome.dispose();
    super.dispose();
  }

  CupertinoAlertDialog myAlert(String message) {
    return CupertinoAlertDialog(
      title: const Text("Checker"),
      content: Text(message),
    );
  }

  bool isPalindrome(String text) {
    text = text.replaceAll(" ", "");
    String temp = "";
    for (int i = text.length; i > 0; i--) {
      temp += text[i - 1];
    }

    palindrome.text = temp;
    if (text == temp) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 185),
                    height: 116,
                    width: 116,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/ic_photo.png')),
                    ),
                  ),
                  const SizedBox(height: 58),
                  CustomForm(
                    hintText: 'Name',
                    controller: name,
                  ),
                  const SizedBox(height: 22),
                  CustomForm(
                    hintText: 'Palindrome',
                    controller: palindrome,
                  ),
                  const SizedBox(height: 45),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        if (isPalindrome(name.text)) {
                        showDialog(
                          context: context,
                          builder: (_) => myAlert("isPalindrome"),
                        );
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (_) => myAlert("not palindrome"),
                      );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.indigo[800],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'CHECK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => MainPage(
                          name: name.text,
                        )));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.indigo[800],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
