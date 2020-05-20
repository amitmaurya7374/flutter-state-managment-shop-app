//this is the first page of the app which shows overall product we have
import 'package:flutter/material.dart';
import 'package:shop_state/widget/product_grid.dart';


//creating the enum for the popupmenuitem vale argument so that we can easily use then 
enum FliterOptions{
  Favorites,
  All,
}
class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          ///PopMenu button is basically open a dropMenu ,menu which open up as an  overlay
          ///itembuilder: It build the enteriesfor thid pop up menu
          PopupMenuButton(
            onSelected: (FliterOptions selectedValue){
              print(selectedValue);
            },
            
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Only Favorites',
                ),
                //using enum instead of using integer value because it better approach
                value: FliterOptions.Favorites, //to find out which choice was or which item is chosen  by the user
                
              ),
              
              PopupMenuItem(
                child: Text('Favorites'),
                value: FliterOptions.All,
              ),
            ],
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
