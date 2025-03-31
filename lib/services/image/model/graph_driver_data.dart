import 'package:json_annotation/json_annotation.dart';

part 'graph_driver_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class GraphDriverData {
  GraphDriverData({
    required this.name,
    required this.data,
  });

  /// Name of the storage driver.
  String name;

  /// Low-level storage metadata, provided as key/value pairs.
  ///
  /// This information is driver-specific, and depends on the storage-driver in use,
  /// and should be used for informational purposes only.
  Map<String, String> data;

  factory GraphDriverData.fromJson(Map<String, dynamic> json) =>
      _$GraphDriverDataFromJson(json);

  Map<String, dynamic> toJson() => _$GraphDriverDataToJson(this);
}
