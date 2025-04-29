import 'package:json_annotation/json_annotation.dart' as j;

part 'items.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class Items {
  final List<String> items;

  const Items(this.items);

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
