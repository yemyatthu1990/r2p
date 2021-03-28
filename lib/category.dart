
import 'package:floor/floor.dart';
@entity
class Category {
  @primaryKey
  final String id;

  final String name;
  Category(this.id, this.name);
}

