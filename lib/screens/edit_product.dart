//this file help the user to add the product like product title image price
///this file is standalone page so we use the scaffold
///i want to create a form that take user input
///so flutter has built in widget Form()
///that can handle the user input automatically
///

import 'package:flutter/material.dart';
import 'package:shop_state/provider/product.dart';

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
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  var _editedProduct = Product(
    ///actually it is an empty product
    id: null,
    title: ' ',
    description: '',
    price: 0,
    imageUrl: '',
  );

  //this is the step 1 for key
  final _form = GlobalKey<
      FormState>(); //here i creating a key by instancite the Global Key class
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    //this will save the data
    //here is the problem we to intreact with the form widget to get that data
    //so do so we need a key to intreact inside a code
    //step 3 of form key
    _form.currentState.save(); //this will save our form
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  ///*********************************************************************************** */
  ///*********************************************************************************** */
  ///////****************************************************************************** */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Product'),

        //Now i want to save my data afterthe form is filled
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form, //step 2 assing the global key
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
                onSaved: (value) {
                  _editedProduct = Product(
                    id: null,
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
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
                onSaved: (value) {
                  _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value),
                    imageUrl: _editedProduct.imageUrl,
                  );
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
                onSaved: (value) {
                  _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: value,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),

              //Now here I want to have image preview and text
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    //this will show the image preview
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(
                            child: Text(
                            'Please enter the url',
                            textAlign: TextAlign.center,
                          ))
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter the ImageUrl',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller:
                          _imageUrlController, //i done this because i want the image before the form is submmited
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: null,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
