//this is the first page of the app which shows overall product we have
import 'package:flutter/material.dart';
import 'package:shop_state/widget/product_grid.dart';


//creating the enum for the popupmenuitem vale argument so that we can easily use then 
enum FliterOptions{
  Favorites,
  All,
}
class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;
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
              ///i did this because i only want filtering only on this single not on entire app wide state
              setState(() {
                if(selectedValue == FliterOptions.Favorites){
                //do something
              _showOnlyFavorite=true;
              }else{
               _showOnlyFavorite = false;
              }
                
              });
              //Now here i doing a filtering
              
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
                child: Text('All'),
                value: FliterOptions.All,
              ),
            ],
          )
        ],
      ),
      body: ProductsGrid(_showOnlyFavorite),
    );
  }
}
