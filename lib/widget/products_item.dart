import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/provider/cart.dart';
import 'package:shop_state/provider/product.dart';
import 'package:shop_state/screens/product_detail_screen.dart';

/*this is the product items in a class this widget is used in a ProductOverview screen
this will be the grid item that render for every items
*/

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product =
        Provider.of<Product>(context, listen: false); //setting up listener
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            ///here i a note :
            ///whenever we use the Provider.of(context) the whole build method willrerun whenever the
            ///data changes.
            ///But this did not happened with consumer:
            ///we warp the subpart of widget tree into Consumer widget which is intrested in that data
            ///changes.So that only that part of widget tree rebuild.
            ///child argument take  that widget tree whose data never changes
            builder: (context, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItem(
                  product.id,
                  product.title,
                  product
                      .price); //here i used the addItem method to add product in the cart
              ///Now i want to show the snackbar when user press cart icon
              ///so to do that we have to use scaffold
              ///this will show snackbar at bottom of the scaffold
              ///show snackBar take the widget SnackBar()
              ///SnackBar() take an argument content which take the widget for eg text()
              Scaffold.of(context)
                  .hideCurrentSnackBar(); //this will hide the prevous snack bar and show the latest bar .
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  elevation: 10.0,
                  content: Text('Added item into the cart'),
                  duration: Duration(seconds: 2),
                  //An action that user take to do thing on an snackBar
                  action: SnackBarAction(
                    label: 'undo',
                    onPressed: () {
                      //here you candefine what action  should happen when the user press the undo .
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
