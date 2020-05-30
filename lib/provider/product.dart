//this is blueprint of a Single product how it look like
//this will show how a product is look like
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  //creating the instance variable or member variable
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite; //this actually is not final because it actually changeable
  ///creating a constructor initialize a product
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });
  void _setFavValue(bool newValue){
     isFavorite = newValue;
      notifyListeners();
  }
  Future<void> toggleFavoriteStatus()async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'https://shopping-app-45175.firebaseio.com/products/$id.json';
    try{
      final response = await http.patch(
      url,
      body: json.encode(
        {
          'isFavorite':isFavorite,
        },
      ),
    );
    if(response.statusCode>=400){
      _setFavValue(oldStatus);
    }
    }catch(error){
      _setFavValue(oldStatus);
    }
    
  }
}
