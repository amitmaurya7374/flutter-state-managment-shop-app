//this file is the data provider file  it will help you to define a data for a provider
//this is a globle data center
import 'package:flutter/widgets.dart';
import 'package:shop_state/model/http_Exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http; //to avoid any name clash http.
import 'dart:convert'; //this libary help to convert our data into a json format

//this class is for multiple products with a mixin called changeNotifier
class Products with ChangeNotifier {
//here i am defining the list of products
//it is list of product
  List<Product> _items = [
    //making the instance of the Product data class
    //create a real life object
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  //putting the filtering logic////////////////////////////////////////////////////////

  //if you want application wide flitering then this is your  approach
//  var _showFavoritesOnly = false;

  List<Product> get items {
    //using getter to get a value of private _items list

    ///filtering logic
    // if(_showFavoritesOnly){
    //   return _items.where((prodItem)=>prodItem.isFavorite).toList();
    // }

    return [..._items]; //returning the copy of private variable
  }

  // void showFavoritesOnly(){
  //     _showFavoritesOnly = true;
  //     notifyListeners();
  // }
  // void showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  List<Product> get favoritesItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

//this will help in fetch data
  Future<void> fetchAndSetProducts() async {
    const url = 'https://shopping-app-45175.firebaseio.com/products.json';
    try {
      final response = await http.get(url); //we only need url
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      //temporay list
      final List<Product> loadedProducts = [];

      extractedData.forEach(
        (prodId, prodData) {
          //convert that data into a product objects based on product class
          loadedProducts.add(Product(
            id: prodId,
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
            price: prodData['price'],
            title: prodData['title'],
          ));
        },
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

// by adding the async keyword all the code you have automatically get wrapped
//into a future.therefore we do not need to return the future it automatically did that
  Future<void> addProduct(Product product) async {
    ///Notes
    ///************************************************************************* */
    ///firebase need this url to make commnication                               *
    ////products => means this create a folder in a data base name products      *
    ///firebase url always end with .json extension                              *
    ///json data look like a map in dart                                         *
    ///************************************************************************* */
    const url = 'https://shopping-app-45175.firebaseio.com/products.json';
    //here i storing a dataon
    //we use body name argument to convert ourdata in json format
    //because webserver only understand json
    ///await => this tell dart that we want to wait this operation to
    ///finish before we move on to the next line in our dart code
    ///and we donot need of then block
    ///
    ///
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            //this post method return a future
            //i want to store product
            //actually future allows us to define a function that should execute in the future
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      //after the post method get completlyy execute this will run
      print(json.decode(response.body));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
        // _items.add(newProduct);
      );
      _items.add(newProduct);
      // _items.add(value);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error); //throw will help you to throw a new error that can be handle on other
    }

    //this catch error help you to handle error
    // print(error);
    // throw (error); //throw will help you to throw a new error that can be handle on other
    //place.
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://shopping-app-45175.firebaseio.com/products/$id.json';
      //we use body here because we need to add some data
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('.....');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://shopping-app-45175.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException(
          'Unable to delete the item'); //this will throw an exception Exception help you to create an error
    }
    existingProduct = null;

    //you donot need to append data that why i donot use body argument here
  }
}
