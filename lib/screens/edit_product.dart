//this file help the user to add the product like product title image price
///this file is standalone page so we use the scaffold
///i want to create a form that take user input
///so flutter has built in widget Form()
///that can handle the user input automatically
///

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/provider/product.dart';
import 'package:shop_state/provider/products_provider.dart';

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
  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  var _isLoading = false;
  var _isInit = true; //this variable is used for did change dependencies
  //this is the step 1 for key
  final _form = GlobalKey<
      FormState>(); //here i creating a key by instancite the Global Key class
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //this method run so many time in Build method
    ///so to stop that i initialize a variablle isInit first true then  initialize it false
    if (_isInit) {
      //getting the data fro Navigator as an argument ;
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        final product =
            Provider.of<Products>(context, listen: false).findById(productId);
        _editedProduct = product;
        _initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          // 'imageUrl':_editedProduct.imageUrl
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
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

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occurred!'),
                content: Text('Something went wrong.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
    // Navigator.of(context).pop();
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form, //step 2 assing the global key
                //using the form to get user input
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
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
                      //to validate the input form takes the valedator argument
                      //it takes a function which retuns a string
                      ///here i the note validator return a string
                      ///if you return null that means no error
                      ///if you retun a text that means error;
                      ///for eg validator :(value){return 'this a wrong input';}//means error
                      ///validator:(value){return null;} //no error
                      validator: (value) {
                        //her i put my logic
                        //after logic we have to triggred the validator we use the form key
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          title: value,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode, //step 2
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        //her i put my logic
                        //after logic we have to triggred the validator we use the form key
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        if (double.tryParse(value) == null) {
                          //this will check if the value is number or not
                          return 'Please enter the valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater then zero';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value),
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      // textInputAction: TextInputAction.next,
                      //user have to move to next fieldown hiss own because we can not tell
                      ///when user done with typying//
                      validator: (value) {
                        //her i put my logic
                        //after logic we have to triggred the validator we use the form key
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        if (value.length < 10) {
                          return 'Please enter atleast 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
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
                            // initialValue: _initValues['imageUrl'],
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
                            validator: (value) {
                              //her i put my logic
                              //after logic we have to triggred the validator we use the form key
                              if (value.isEmpty) {
                                return 'Please provide a value';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter valid url that start with http or https';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
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
