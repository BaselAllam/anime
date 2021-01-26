import 'package:anime/models/mainmodel.dart';
import 'package:anime/responsive/responsivehomepage.dart';
import 'package:anime/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class SearchResult extends StatefulWidget {

final MainModel movie;
final String classTitle;

SearchResult(this.classTitle, this.movie);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

@override
void initState() {
  widget.movie.getMovie();
  super.initState();
}


  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          '${widget.classTitle}',
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
        child: ScopedModelDescendant(
          builder: (context, child, MainModel movie){
            if(movie.isGetMovieLoding == true){
              return Center(child: CircularProgressIndicator());
            }else if(movie.allMovies.isEmpty){
              return Center(child: Text('no movie found', style: TextStyle(fontSize: 30.0)));
            }else{
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  childAspectRatio: responsiveResultGrid(data)
                ),
                scrollDirection: Axis.vertical,
                itemCount: movie.allMovies.length,
                itemBuilder: (context, index){
                  return Item(
                    image : movie.allMovies[index].movieImage,
                    movieDuration: movie.allMovies[index].movieDuration,
                    movieName: movie.allMovies[index].movieName,
                    movieRate: movie.allMovies[index].movieRate,
                    movieViews: movie.allMovies[index].movieViews,
                    publishedDate: movie.allMovies[index].publishedDate,
                  );
                },
              );
            }
          }
        ),
      ),
    );
  }
}