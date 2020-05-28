//this file is the data provider file  it will help you to define a data for a provider
//this is a globle data center
import 'package:flutter/widgets.dart';
import 'product.dart';
import 'package:http/http.dart' as http; //to avoid any name clash http.
//this class is for multiple products with a mixin called changeNotifier
class Products with ChangeNotifier {
//here i am defining the list of products
//it is list of product
  List<Product> _items = [
    //making the instance of the Product data class
    //create a real life object
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
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

  void addProduct(Product product) {
    ///Notes
    ///************************************************************************* */
    ///firebase need this url to make commnication                               * 
    ////products => means this create a folder in a data base name products      * 
    ///firebase url always end with .json extension                              *
    ///************************************************************************* */
    const url ='https://shopping-app-45175.firebaseio.com/products.json';
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
      // _items.add(newProduct);
    );
    _items.add(newProduct);
    // _items.add(value);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('.....');
    }
  }

  void deleteProduct(String id){
    _items.removeWhere((prod) => prod.id==id);
    notifyListeners();
  }
}
