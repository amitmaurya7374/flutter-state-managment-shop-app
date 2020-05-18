import 'package:flutter/material.dart';
import 'package:shop_state/screens/product_detail_screen.dart';

/*this is the product items in a class this widget is used in a ProductOverview screen
this will be the grid item that render for every items
*/

class ProductItem extends StatelessWidget {
  //creating the instance variable to get a data
  //productItem need that so to accept that data I create that avriable and constructor
  final String id;
  final String title;
  final String imageUrl;
  //to get that data we need to initialize the variable with the help of constructor
  ProductItem({
    this.id,
    this.title,
    this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Card(
        elevation: 6.0,
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: id,
              );
            },
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          footer: GridTileBar(
            leading: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.deepOrange,
              ),
              onPressed: () {},
            ),
            backgroundColor: Colors.black45,
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.deepOrange,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
