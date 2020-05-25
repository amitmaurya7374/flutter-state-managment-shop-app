//this file help the user to add the product like product title image price
///this file is standalone page so we use the scaffold
import 'package:flutter/material.dart';
class EditProductScreen extends StatefulWidget {
  static const routeName='/edit-screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Your Product'),),
    );
  }
}