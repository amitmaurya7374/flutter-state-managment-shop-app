import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/provider/products_provider.dart';
import 'package:shop_state/screens/edit_product.dart';

class UserProductItem extends StatelessWidget {
  //get the data from the UserProduct Screen widget
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem({
    this.id,
    this.title,
    this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    final scafflod = Scaffold.of(context);
    return Card(
      elevation: 10.0,
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                color: Colors.deepPurple,
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
              ),
              IconButton(
                color: Colors.red,
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                  } catch (error) {
                   scafflod.showSnackBar(
                      SnackBar(
                        content: Text('Deleting failed'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
