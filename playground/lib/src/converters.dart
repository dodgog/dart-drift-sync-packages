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
}
