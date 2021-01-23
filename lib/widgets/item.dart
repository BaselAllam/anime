import 'package:anime/models/movie/moviecontroller.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class Item extends StatefulWidget {

final String image;
final String movieName;
final double movieRate;
final int movieViews;
final String publishedDate;
final double movieDuration;
final String id;

Item({this.image, this.movieName, this.movieRate, this.movieViews, this.publishedDate, this.movieDuration, this.id});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (context, child, MovieController movie){
        return InkWell(
          onLongPress: () {
            movie.selectMovie(widget.id);
            movie.deleteMovie(widget.id);
          },
          child: Container(
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
                      image: NetworkImage(widget.image),
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
                    '${widget.movieName}',
                    style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${widget.publishedDate} - Comedy - ${widget.movieDuration}H\n${widget.movieRate} - ${widget.movieViews} Views',
                    style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}