// TODO Implement this library.
import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  List<String> employees = [];
  final nameCtrl = TextEditingController();

  void addEmployee() {
    setState(() {
      employees.add(nameCtrl.text);
      nameCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employees")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(controller: nameCtrl, decoration: InputDecoration(labelText: "Employee Name")),
          ),
          ElevatedButton(onPressed: addEmployee, child: Text("Add")),
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (_, i) => ListTile(title: Text(employees[i])),
            ),
          )
        ],
      ),
    );
  }
}