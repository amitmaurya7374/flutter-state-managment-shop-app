//how my cart should look like
import 'package:flutter/widgets.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  //create  a constructor to initialize a value to the variable
  CartItem({
    @required this.id,
    @required this.price,
    @required this.title,
    @required this.quantity,
  });
}

//here i create data center with the help of provider
class Cart with ChangeNotifier {
  Map<String, CartItem> _items={}; //A empty map
  Map<String, CartItem> get items {
    return {..._items};
  }
//here i put the logic of how manny item in the cart
int get itemCount{
  return _items.length;
} 
 //calculating the total item price in cart.
 double get totalAmount{
   var total =0.0;
   _items.forEach((key, cartItem) { 
     total = total + cartItem.price*cartItem.quantity;
   });
   return total;
  //  notifyListeners();
 }
  //now we want to add the  item in a cart
  void addItem(
    String productId,
    String title,
    double price,
  ) {
    //checking if the cart is already empty or not
    if (_items.containsKey(productId)) {
      //if we already have the item in a cart then we only need to update   the quantity
      //here is the logic
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          price: existingCartItem.price,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      //we need to add item into cart
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                price: price,
                title: title,
                quantity: 1,
              ));
    }
  notifyListeners();
  }
}
