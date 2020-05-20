import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final product = Provider.of<Product>(context,listen: false); //setting up listener
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
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
