import 'package:anime/models/category/categoryController.dart';
import 'package:anime/models/movie/moviecontroller.dart';
import 'package:scoped_model/scoped_model.dart';




class MainModel extends Model with CategoryController, MovieController{}