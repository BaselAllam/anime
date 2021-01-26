import 'package:anime/models/mainmodel.dart';
import 'package:anime/responsive/responsivehomepage.dart';
import 'package:anime/screens/searchresult.dart';
import 'package:anime/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class HomePage extends StatefulWidget {

final MainModel model;

HomePage(this.model);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

@override
void initState() {
  widget.model.getMovie();
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
    var data = MediaQuery.of(context);
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, MainModel model){
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
                return Navigator.push(context, MaterialPageRoute(builder: (_) {return SearchResult('Result', model);}));
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
                  height: 100.0,
                  margin: EdgeInsets.all(10.0),
                  child: model.isGetCategoryLoding == true ? Center(child: CircularProgressIndicator()) : model.allCategories.isEmpty ? Center(child: Text('no categories')) : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${model.allCategories[0].categoryName}',
                        style: TextStyle(color: Colors.teal, fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${model.allCategories[1].categoryName}',
                        style: TextStyle(color: Colors.teal, fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${model.allCategories[2].categoryName}',
                        style: TextStyle(color: Colors.teal, fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ]
                  ),
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
              sectionTitle('New Movie', model),
              Container(
                height: responsiveHomePageContainer(data),
                child: scrollSection(model)
              ),
              sectionTitle('Popular Movie', model),
              Container(
                height: responsiveHomePageContainer(data),
                child: scrollSection(model)
              ),
            ],
          ),
        ),
      );
      }
    );
  }
  sectionTitle(String title, MainModel model) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        return Navigator.push(context, MaterialPageRoute(builder: (_) {return SearchResult(title, model);}));
      },
      trailing: Icon(Icons.navigate_next, color: Colors.black, size: 20.0),
    );
  }
  scrollSection(MainModel model) {
    if(model.isGetMovieLoding == true){
      return Center(child: CircularProgressIndicator());
    }else if(model.allMovies.isEmpty){
      return Center(child: Text('no movie found', style: TextStyle(fontSize: 30.0)));
    }else{
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.allMovies.length,
        itemBuilder: (context, index){
          return Item(
            image : model.allMovies[index].movieImage,
            movieDuration: model.allMovies[index].movieDuration,
            movieName: model.allMovies[index].movieName,
            movieRate: model.allMovies[index].movieRate,
            movieViews: model.allMovies[index].movieViews,
            publishedDate: model.allMovies[index].publishedDate,
            id: model.allMovies[index].movieId
          );
        },
      );
    }
  }
}