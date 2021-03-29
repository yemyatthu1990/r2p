import 'package:floor/floor.dart';

import 'detail.dart';

@dao
abstract class DetailDao {
  @Query('SELECT * FROM Detail WHERE catSubCatId = :catSubCatId')
  Future<Detail?> getDetail(String catSubCatId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDetail(Detail detail);
}
