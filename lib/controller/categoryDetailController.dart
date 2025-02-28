import 'package:duabook/services/categoryDetailService.dart';
import 'package:get/get.dart';

import '../models/duaModel.dart';
import '../models/subCategoryModel.dart';

class CategoryDetailController extends GetxController {

  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  
  List<SubCategoryModel> _subCategories = [];
  List<SubCategoryModel> get subCategories => _subCategories;

  List<DuaModel> _duas = [];
  List<DuaModel> get duas => _duas;

  setLoading(bool value){
    _isLoading=value;
    update();
  }
  populateSubCategoryList(List<SubCategoryModel> _list){
    _subCategories.clear();
    _subCategories=_list;
    update();
  }
  populateDuaList(List<DuaModel>_list){
    _duas.clear();
    _duas=_list;
    update();
  }

  getSubCategories(int id){
    CategoryDetailService().getSubCategories(id);
  }

   getDuas(SubCategoryModel subCategoryModel) {
     CategoryDetailService().getDuas(subCategoryModel);
   }


}
