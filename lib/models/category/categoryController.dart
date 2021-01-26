import 'package:anime/models/category/categorymodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';




mixin CategoryController on Model{


  bool _isGetCategoryLoading;
  bool get isGetCategoryLoding => _isGetCategoryLoading;

  List<CategoryModel> _allCategories = [];
  List<CategoryModel> get allCategories => _allCategories;



  Future<bool> getMovie() async {

      _isGetCategoryLoading = true;
      notifyListeners();

      
      try {
        Firestore.instance.collection('categories').getDocuments().then((QuerySnapshot snapshot) {
          snapshot.documents.forEach((i) {
            final CategoryModel _newMovie = CategoryModel(
              categoryId: i.documentID,
              categoryName: i['categoryName']
            );
            _allCategories.add(_newMovie);
          });
          _isGetCategoryLoading = false;
          notifyListeners();
          return true;
        });
      } catch (e) {
        _isGetCategoryLoading = false;
        notifyListeners();
        return false;
      }
  }


}