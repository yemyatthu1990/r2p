import 'package:floor/floor.dart';

import 'category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM Category')
  Future<List<Category>> getAllCategories();

  @Query('SELECT * FROM Category')
  Stream<List<Category>> getAllCategoriesAsStream();

  @Query('SELECT * FROM Category WHERE id = :id')
  Stream<Category?> getCategoryById(String id);

  @insert
  Future<void> insertCategory(Category category);
}
