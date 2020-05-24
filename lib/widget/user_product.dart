import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  //get the data from the UserProduct Screen widget
  final String title;
  final String imageUrl;
  UserProductItem({
    this.title,
    this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
              ),
              IconButton(
                color: Colors.red,
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
