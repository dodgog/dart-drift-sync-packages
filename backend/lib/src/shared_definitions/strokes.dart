import 'package:json_annotation/json_annotation.dart' as j;

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class Scribble {
  final List<Point> points;
  const Scribble(this.points);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class Point {
  final double x;
  final double y;
  const Point(this.x, this.y);
}
