// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:storepro/db/database_helper.dart';
import '../../db/database_helper.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void generateInvoice(double total) async {
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (context) => pw.Center(
        child: pw.Text("StorePro Invoice\n\nTotal: ₹$total"),
      ),
    ),
  );
  await Printing.layoutPdf(onLayout: (format) => pdf.save());
ElevatedButton(
  onPressed: () => generateInvoice(total),
  child: Text("Generate Invoice"),
);
}
class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  List<Map<String, dynamic>> products = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    final res = await DatabaseHelper.instance.getAllProducts();
    setState(() => products = res);
  }

  void addToBill(Map<String, dynamic> product) {
    setState(() => total += product['price']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sales")),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: products.map((p) {
                return ListTile(
                  title: Text(p['name']),
                  trailing: Text("₹${p['price']}"),
                  onTap: () => addToBill(p),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Total: ₹$total", style: TextStyle(fontSize: 22)),
          ),
        ],
      ),
    );
  }
}