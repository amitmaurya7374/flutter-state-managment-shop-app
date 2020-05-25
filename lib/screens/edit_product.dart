//this file help the user to add the product like product title image price
///this file is standalone page so we use the scaffold
///i want to create a form that take user input
///so flutter has built in widget Form()
///that can handle the user input automatically
///

import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  ///so here i the problem with form
  ///i want my cursor to go to the next field by pressing the next key on keyboard
  ///to do that we have to manage it with the focusNode
  ///
  ///***************************Important Note********************************** *
  ///here is a note when we use the Focus Node you have to dispose the focusnode * 
  ///otherwise it will cause memory leak                                         *
  ///******************************************************************************
  final _priceFocusNode = FocusNode(); //setp1
  final _descriptionFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          //using the form to get user input
          child: ListView(
            children: <Widget>[
              TextFormField(
                //decoration is used for how your textfield look like
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                //textInputAction :it show how your keyword should look like when user tap on that textfield
                textInputAction: TextInputAction
                    .next, //it will show the enter button on the keyboard
                //setp3
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(
                      _priceFocusNode); //when the button is pressed we want that pricefocusnode to the next textfield
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode, //step 2
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                // textInputAction: TextInputAction.next,
                //user have to move to next fieldown hiss own because we can not tell
                ///when user done with typying//
              ),
            ],
          ),
        ),
      ),
    );
  }
}
