import 'package:floor/floor.dart';

@entity
class Detail {
  @primaryKey
  final String id;
  final String catSubCatId;
  final String image;
  final String body;

  Detail(this.id, this.catSubCatId, this.image, this.body);
}