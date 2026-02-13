// TODO Implement this library.
import 'package:flutter/material.dart';
import '../../db/database_helper.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final db = DatabaseHelper.instance;
    final res = await db.getAllProducts();
    setState(() => products = res);
  }

  void addProductDialog() {
    final name = TextEditingController();
    final price = TextEditingController();
    final cost = TextEditingController();
    final stock = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Product"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: name, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: price, keyboardType: TextInputType.number),
            TextField(controller: cost, keyboardType: TextInputType.number),
            TextField(controller: stock, keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              await DatabaseHelper.instance.addProduct(
                name.text,
                double.parse(price.text),
                double.parse(cost.text),
                int.parse(stock.text),
              );
              Navigator.pop(context);
              loadProducts();
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inventory")),
      floatingActionButton: FloatingActionButton(
        onPressed: addProductDialog,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(products[i]['name']),
          subtitle: Text("Stock: ${products[i]['stock']}"),
          trailing: Text("₹${products[i]['price']}"),
        ),
      ),
    );
  }
}