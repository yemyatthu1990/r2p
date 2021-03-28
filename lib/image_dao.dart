import 'package:floor/floor.dart';

import 'image.dart';

@dao
abstract class ImageDao {
  @Query('SELECT * FROM Image WHERE key = :key')
  Future<Image?> getImage(String key);

  @insert
  Future<void> insertImage(Image image);
}
