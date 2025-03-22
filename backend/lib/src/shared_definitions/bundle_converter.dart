import 'package:json_annotation/json_annotation.dart' as j;

import 'package:backend/client_definitions.dart';

part 'bundle_converter.g.dart';


@j.JsonSerializable()
class BundleConverter extends j.JsonConverter<Bundle, Map<String, dynamic>> {
  const BundleConverter();

  @override
  Bundle fromJson(Map<String, dynamic> json) => Bundle.fromJson(json);

  @override
  Map<String, dynamic> toJson(Bundle object) => object.toJson();
}
