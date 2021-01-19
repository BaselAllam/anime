import 'package:anime/models/movie/moviemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';



class MovieController extends Model{


  bool _isGetMovieLoading = true;
  bool get isGetMovieLoding => _isGetMovieLoading;

  bool _isAddMovieLoading = true;
  bool get isAddMovieLoding => _isAddMovieLoading;

  List<MovieModel> _allMovies = [];
  List<MovieModel> get allMovies => _allMovies;


  Future<bool> getMovie() async {

      _isGetMovieLoading = true;
      notifyListeners();
      
      try {
        Firestore.instance.collection('movie').getDocuments().then((QuerySnapshot snapshot) {
          snapshot.documents.forEach((i) {
            final MovieModel _newMovie = MovieModel(
              movieName: i['movieName'],
              movieImage: i['movieImage'],
              movieDuration: i['movieDuration'],
              movieRate: i['moviewRate'],
              movieViews: i['movieViews'],
              publishedDate: i['publishedDate']
            );
            _allMovies.add(_newMovie);
          });
          _isGetMovieLoading = false;
          notifyListeners();
          return true;
        });
      } catch (e) {
        _isGetMovieLoading = false;
        notifyListeners();
        return false;
      }
  }



  Future<bool> addMovie(String movieName, double movieDuration) async {


    _isAddMovieLoading = true;
    notifyListeners();


    Map<String, dynamic> _data = {
      'movieName' : movieName,
      'movieDuration' : movieDuration,
      'movieRate' : 1.5,
      'movieViews' : 1,
      'publishedDate' : DateTime.now().toString().substring(0,10)
    };

    try {
      Firestore.instance.collection('movie').add(_data);
      _isAddMovieLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isAddMovieLoading = false;
      notifyListeners();
      return false;
    }


  }


}