import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/provider/products_provider.dart';
import 'products_item.dart';
 ///this file build a grid on productoverview screen
 

 class ProductGrid extends StatelessWidget {
///here i need data so i setup a listener here by :
///importing the provider.dart package
///then in the build method setup the listener


  @override
  Widget build(BuildContext context) {
    //Setting up a listener
    //<Products> this will tellwhich type of data you want to listen
   final productData =  Provider.of<Products>(context);  //this setup a direct communication channel behind the scene 
   //this will give the object 
    final product = productData.items;
    return GridView.builder(
      //gridView.builder required three things 1) itemCount =>tell the length of the product
      //2) itemBuilder=> which has function which hold the index and context of the list and that function should return the widget
      //3)gridDelegate => it tell how the structure of grid should look like
      padding: const EdgeInsets.all(10.0),
      itemCount: product.length,
      itemBuilder: (context, index) => ProductItem(
        //Now here i am passing data to ProductItem widget from ProductOverView screen
        id: product[index].id, //accessing data from  a list of loadedProducts
        title: product[index].title,
        imageUrl: product[index].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //it should give us 2 colunm
          childAspectRatio: 3 / 2, //heigher then the width
          crossAxisSpacing: 10, //spacing between the columns
          mainAxisSpacing: 10 //which space between the rows

          ),
    );
  }
}
