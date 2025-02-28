import 'package:duabook/controller/themeController.dart';
import 'package:duabook/models/duaModel.dart';
import 'package:duabook/models/subCategoryModel.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../controller/categoryDetailController.dart';
import '../database/initDb.dart';

class CategoryDetailService {
  CategoryDetailController _categoryDetailController = Get.find<CategoryDetailController>();
  ThemeController _themeController=Get.find<ThemeController>();

  Future<void> getSubCategories(int id) async {
    _categoryDetailController.setLoading(true);

    try {
      Database db = await initializeDb();

      List<Map<String, dynamic>> duas = await db.query(
        'duatext',
        where: 'category_id = ?',
        orderBy: "id",
        whereArgs: [id],
      );
      List<SubCategoryModel> _list = [];
      for (var item in duas) {
        SubCategoryModel subCategoryModel=SubCategoryModel.fromJson(item);

        List<Map<String, dynamic>> duas = await db.query(
          'sentence',
          where: 'duaText_id = ?',
          whereArgs: [subCategoryModel.id],
        );
        List<DuaModel> duaList = [];
        for (var item in duas) {
          DuaModel dua=DuaModel.fromJson(item);
          duaList.add(dua);
        }
        if(duaList.every((element) => element.done=="1")){
          subCategoryModel.isComplete=true;
        }else{
          subCategoryModel.isComplete=false;
        }
        if(_themeController.selectedAgeGroup==0){
          if(subCategoryModel.littleKids=="t"){
            _list.add(subCategoryModel);
          }
        }else if(_themeController.selectedAgeGroup==1){
          if(subCategoryModel.olderKids=="t"){
            _list.add(subCategoryModel);
          }
        }else if(_themeController.selectedAgeGroup==2){
          if(subCategoryModel.grownUps=="t"){
            _list.add(subCategoryModel);
          }
        }

      }
      _categoryDetailController.populateSubCategoryList(_list);
      _categoryDetailController.setLoading(false);
    } catch (e,stackTrace) {
      print("Exception: $e");
      print("Stack Trace: $stackTrace");

      _categoryDetailController.setLoading(false);
    }
  }

  void getDuas(SubCategoryModel subCategoryModel) async{
    _categoryDetailController.setLoading(true);
    try{
      Database db = await initializeDb();

      List<Map<String, dynamic>> duas = await db.query(
        'sentence',
        where: 'duaText_id = ?',
        whereArgs: [subCategoryModel.id],
      );
      List<DuaModel> _list = [];
      for (var item in duas) {
        _list.add(DuaModel.fromJson(item));
      }
      _categoryDetailController.populateDuaList(_list);

      _categoryDetailController.setLoading(false);
    }catch (e,stackTrace) {
      print("Exception: $e");
      print("Stack Trace: $stackTrace");

      _categoryDetailController.setLoading(false);
    }
  }
}
