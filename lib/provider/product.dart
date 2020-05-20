//this is blueprint of a Single product how it look like
//this will show how a product is look like
import 'package:flutter/widgets.dart';

class Product with ChangeNotifier{
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
  void toggleFavoriteStatus(){
        isFavorite = !isFavorite;
        notifyListeners();
  }
}
