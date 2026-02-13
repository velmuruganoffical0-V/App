// TODO Implement this library.
import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  void _login() async {
    final ok = await DatabaseHelper.instance
        .login(phoneCtrl.text, passCtrl.text);

    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Login")));
    }
  }

  void _register() async {
    await DatabaseHelper.instance
        .registerUser(phoneCtrl.text, passCtrl.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Registered! Now login")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StorePro Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: phoneCtrl, decoration: InputDecoration(labelText: "Phone")),
            TextField(controller: passCtrl, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text("Login")),
            TextButton(onPressed: _register, child: Text("Register"))
          ],
        ),
      ),
    );
  }
}