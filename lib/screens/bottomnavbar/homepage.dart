import 'package:anime/screens/bottomnavbar/searchresult.dart';
import 'package:anime/widgets/item.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List headerImage = [
  'assets/header.jpg', 'assets/header2.jpg'
];

List itemImage = [
  'assets/pic1.jpg', 'assets/pic2.jpg', 'assets/pic1.jpg', 'assets/pic2.jpg', 'assets/pic1.jpg', 'assets/pic2.jpg', 
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'ANIME',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              return Navigator.push(context, MaterialPageRoute(builder: (_) {return SearchResult('Result');}));
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: MediaQuery.of(context).size.height/3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: headerImage.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    width: 300.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(headerImage[index]),
                        fit: BoxFit.fill
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  );
                },
              ),
            ),
            sectionTitle('New Movie'),
            Container(
              height: MediaQuery.of(context).size.height/2.2,
              child: scrollSection()
            ),
            sectionTitle('Popular Movie'),
            Container(
              height: MediaQuery.of(context).size.height/2.2,
              child: scrollSection()
            ),
          ],
        ),
      ),
    );
  }
  sectionTitle(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        return Navigator.push(context, MaterialPageRoute(builder: (_) {return SearchResult(title);}));
      },
      trailing: Icon(Icons.navigate_next, color: Colors.black, size: 20.0),
    );
  }
  scrollSection() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemImage.length,
      itemBuilder: (context, index){
        return Item(itemImage[index]);
      },
    );
  }
}