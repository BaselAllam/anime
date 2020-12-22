import 'package:anime/widgets/item.dart';
import 'package:flutter/material.dart';




class SearchResult extends StatefulWidget {

final String classTitle;

SearchResult(this.classTitle);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

List itemImage = [
  'assets/pic1.jpg', 'assets/pic2.jpg', 'assets/pic1.jpg', 'assets/pic2.jpg', 'assets/pic1.jpg', 'assets/pic2.jpg', 
  'assets/pic1.jpg', 'assets/pic2.jpg', 'assets/pic1.jpg', 'assets/pic2.jpg', 'assets/pic1.jpg', 'assets/pic2.jpg', 
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          '${widget.classTitle}\n${itemImage.length.toString()} items',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            return Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            childAspectRatio: 0.55
          ),
          scrollDirection: Axis.vertical,
          itemCount: itemImage.length,
          itemBuilder: (context, index){
            return Item(itemImage[index]);
          },
        ),
      ),
    );
  }
}