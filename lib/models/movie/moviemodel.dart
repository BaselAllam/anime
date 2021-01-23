



class MovieModel{

  String movieId;
  String movieName;
  double movieRate;
  int movieViews;
  String publishedDate;
  String movieImage;
  double movieDuration;


  MovieModel({this.movieId, this.movieName, this.movieRate, this.movieViews, this.publishedDate, this.movieImage, this.movieDuration});


  factory MovieModel.fromJson(Map<String, dynamic> json, x){
    return MovieModel(
      movieId: x,
      movieName: json['movieName'],
      movieDuration: json['movieDuration'],
      movieRate: json['moviewRate'],
      movieViews: json['movieViews'],
      publishedDate: json['publishedDate'],
      movieImage: json['movieImage']
    );
  }
}