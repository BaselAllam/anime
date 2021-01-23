import 'package:anime/models/mainmodel.dart';
import 'package:anime/screens/searchresult.dart';
import 'package:anime/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class HomePage extends StatefulWidget {

final MainModel movie;

HomePage(this.movie);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

@override
void initState() {
  widget.movie.getMovie();
  super.initState();
}


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
              return Navigator.push(context, MaterialPageRoute(builder: (_) {return SearchResult('Result', widget.movie);}));
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            ScopedModelDescendant(
              builder: (context, child, MainModel category){
                return Container(
                  height: 100.0,
                  margin: EdgeInsets.all(10.0),
                  child: category.isGetCategoryLoding == true ? Center(child: CircularProgressIndicator()) : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${category.allCategories[0].categoryName}',
                        style: TextStyle(color: Colors.teal, fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${category.allCategories[1].categoryName}',
                        style: TextStyle(color: Colors.teal, fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${category.allCategories[2].categoryName}',
                        style: TextStyle(color: Colors.teal, fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ]
                  ),
                );
              }
            ),
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
        return Navigator.push(context, MaterialPageRoute(builder: (_) {return SearchResult(title, widget.movie);}));
      },
      trailing: Icon(Icons.navigate_next, color: Colors.black, size: 20.0),
    );
  }
  scrollSection() {
    return ScopedModelDescendant(
      builder: (context, child, MainModel movie){
        if(movie.isGetMovieLoding == true){
          return Center(child: CircularProgressIndicator());
        }else if(movie.allMovies.isEmpty){
          return Center(child: Text('no movie found', style: TextStyle(fontSize: 30.0)));
        }else{
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movie.allMovies.length,
            itemBuilder: (context, index){
              return Item(
                image : movie.allMovies[index].movieImage,
                movieDuration: movie.allMovies[index].movieDuration,
                movieName: movie.allMovies[index].movieName,
                movieRate: movie.allMovies[index].movieRate,
                movieViews: movie.allMovies[index].movieViews,
                publishedDate: movie.allMovies[index].publishedDate,
                id: movie.allMovies[index].movieId
              );
            },
          );
        }
      }
    );
  }
}