// TODO Implement this library.
import 'package:flutter/material.dart';
import 'sales/sales_screen.dart';
import 'inventory/inventory_screen.dart';
import 'customers/customer_screen.dart';
import 'employees/employee_screen.dart';
import 'reports/report_screen.dart';

Widget _card(String title, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (title == "Sales") Navigator.push(context, MaterialPageRoute(builder: (_) => SalesScreen()));
      if (title == "Inventory") Navigator.push(context, MaterialPageRoute(builder: (_) => InventoryScreen()));
      if (title == "Customers") Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerScreen()));
      if (title == "Employees") Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeScreen()));
      if (title == "Reports") Navigator.push(context, MaterialPageRoute(builder: (_) => ReportScreen()));
    },
    child: Card(
      child: Center(child: Text(title, style: TextStyle(fontSize: 18))),
    ),
  );
}
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        children: [
          _card("Sales"),
          _card("Inventory"),
          _card("Customers"),
          _card("Employees"),
          _card("Reports"),
          _card("Settings"),
        ],
      ),
    );
  }

  Widget _card(String title) {
    return Card(
      child: Center(child: Text(title, style: TextStyle(fontSize: 18))),
    );
  }
}
