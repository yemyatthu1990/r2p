import 'package:floor/floor.dart';

@entity
class SubCategory {
  @primaryKey
  final String id;
  final String icon;
  final String name;
  final String catId;
  SubCategory(this.id,this.icon, this.name, this.catId);
}