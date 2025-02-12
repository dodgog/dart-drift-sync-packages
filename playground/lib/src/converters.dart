import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'converters.g.dart';

@j.JsonSerializable()
class Preferences {
  bool receiveEmails;
  String selectedTheme;

  Preferences(this.receiveEmails, this.selectedTheme);

  factory Preferences.fromJson(Map<String, dynamic> json) =>
      _$PreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$PreferencesToJson(this);

  static JsonTypeConverter2<Preferences, Uint8List, Object?>
  converter = TypeConverter.jsonb(
    fromJson: (Object? json) {
      return Preferences.fromJson(json as Map<String, Object?>);
    },
    toJson: (pref) => pref.toJson(),
  );
  // // static JsonTypeConverter2<Preferences, String, Object?>
  // // converter = TypeConverter.json2(
  // //   fromJson: (Object? json) {
  // //     // if (json == null) return null;
  // //     return Preferences.fromJson(json as Map<String, Object?>);
  // //   },
  // //   toJson: (pref) => pref.toJson(),
  // );
}
