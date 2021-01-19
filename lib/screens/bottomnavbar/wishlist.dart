import 'package:anime/widgets/item.dart';
import 'package:flutter/material.dart';


class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

List itemImage = [
  'assets/pic1.jpg', 'assets/pic2.jpg', 'assets/pic1.jpg', 'assets/pic2.jpg', 'assets/pic1.jpg', 'assets/pic2.jpg', 
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: itemImage.length,
          itemBuilder: (context, index){
            //return Item(itemImage[index]);
          },
        ),
      ),
    );
  }
}