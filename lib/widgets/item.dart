import 'package:flutter/material.dart';



class Item extends StatefulWidget {

final String image;

Item(this.image);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        children: [
          Container(
            height: 220.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.fill
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(pressed == false ? Icons.favorite_border : Icons.favorite),
              color: Colors.red,
              iconSize: 20.0,
              onPressed: () {
                setState(() {
                  pressed = !pressed;
                });
              }
            ),
          ),
          ListTile(
            title: Text(
              'Movie Name',
              style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '2020 - Comedy - 2:00H\n4.8 - 20 Reviews',
              style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}