import 'package:floor/floor.dart';

import 'sub_category.dart';

@dao
abstract class SubCategoryDao {
  @Query('SELECT * FROM SubCategory WHERE catId = :catId')
  Stream<List<SubCategory>> getSubCategoriesAsStream(String catId);

  @Query('DELETE FROM SubCategory')
  Future<void> deleteAll();

  @insert
  Future<void> insertSubCategory(SubCategory subCategory);
}
