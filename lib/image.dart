
import 'package:floor/floor.dart';

@entity
class Image {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String key;
  final String url;
  final String relativePath;
  final String eTag;
  final double validTill;
  final double touched;
  final int length;

  Image(this.id, this.key, this.url, this.relativePath, this.eTag, this.validTill, this.touched, this.length);

}