import 'package:anime/models/movie/moviemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


mixin MovieController on Model{


  final String _url = 'https://anime-b2dfd-default-rtdb.firebaseio.com/movies.json';

  bool _isGetMovieLoading = true;
  bool get isGetMovieLoding => _isGetMovieLoading;

  bool _isAddMovieLoading = true;
  bool get isAddMovieLoding => _isAddMovieLoading;

  bool _isDeleteMovieLoading = true;
  bool get isDeleteMovieLoding => _isDeleteMovieLoading;

  List<MovieModel> _allMovies = [];
  List<MovieModel> get allMovies => _allMovies;

  String _selectedMovieId;


  selectMovie(String id) {
    return _selectedMovieId = id;
  }


  Future<bool> getMovie() async {

      _isGetMovieLoading = true;
      notifyListeners();


      try {
        http.Response _response = await http.get(_url);
        var _data = json.decode(_response.body);
        if(_response.statusCode == 200){
          _data.forEach((x, i){
            final MovieModel _newMovie = MovieModel.fromJson(i, x);
              _allMovies.add(_newMovie);
          });
          _isGetMovieLoading = false;
          notifyListeners();
          return true;
        }else{
          _isGetMovieLoading = false;
          notifyListeners();
          return false;
        }
      } catch (e) {
      _isGetMovieLoading = false;
        notifyListeners();
        return false;
      }

      
      // try {
      //   Firestore.instance.collection('movie').getDocuments().then((QuerySnapshot snapshot) {
      //     snapshot.documents.forEach((i) {
      //       final MovieModel _newMovie = MovieModel.fromJson(i);
      //       _allMovies.add(_newMovie);
      //     });
      //     _isGetMovieLoading = false;
      //     notifyListeners();
      //     return true;
      //   });
      // } catch (e) {
      //   _isGetMovieLoading = false;
      //   notifyListeners();
      //   return false;
      // }
  }



  Future<bool> addMovie(String movieName, double movieDuration) async {


    _isAddMovieLoading = true;
    notifyListeners();


    Map<String, dynamic> _data = {
      'movieName' : movieName,
      'movieDuration' : movieDuration,
      'movieRate' : 1.5,
      'movieViews' : 1,
      'publishedDate' : DateTime.now().toString().substring(0,10),
      "movieImage" : 'https://firebasestorage.googleapis.com/v0/b/anime-b2dfd.appspot.com/o/images%2Fpic1.jpg?alt=media&token=8d94355d-434a-4bca-9cf5-ccffd3511b59'
    };

    try {
      http.Response _response = await http.post(_url, body: json.encode(_data));
      if(_response.statusCode == 200){
        _isAddMovieLoading = false;
        notifyListeners();
        return true;
      }else{
        _isAddMovieLoading = false;
        notifyListeners();
        return false;
      }
      //Firestore.instance.collection('movie').add(_data);
    } catch (e) {
      _isAddMovieLoading = false;
      notifyListeners();
      return false;
    }

  }



  Future<bool> deleteMovie(String id) async {

    _isDeleteMovieLoading = true;
    notifyListeners();

    http.Response _response = await http.delete('https://anime-b2dfd-default-rtdb.firebaseio.com/movies/$id.json');

    if(_response.statusCode == 200){
      _allMovies.removeWhere((MovieModel movie) {
        return movie.movieId == id;
      });
      _isDeleteMovieLoading = false;
      notifyListeners();
      return true;
    }else{
      _isDeleteMovieLoading = false;
      notifyListeners();
      return false;
    }

  }


}