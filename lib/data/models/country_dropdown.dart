import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CountryDropdown {
  int id;
  String name, value, phone_code, native, emoji;

  CountryDropdown(
      {this.id,
      this.name,
      this.value,
      this.phone_code,
      this.native,
      this.emoji});

  factory CountryDropdown.fromJson(Map<String, dynamic> json) {
    return CountryDropdown(
        id: json['id'] as int,
        name: json['name'] as String,
        phone_code: json['phone_code'] as String,
        value: json['iso3'] as String,
        native: json['native'] as String,
        emoji: json['emoji'] as String);
  }
}
