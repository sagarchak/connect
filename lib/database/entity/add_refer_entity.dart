import 'package:connect/generated/json/base/json_field.dart';
import 'package:connect/generated/json/add_refer_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class AddReferEntity {
	String? name;
	String? mobile;
	String? product;

	AddReferEntity();

	factory AddReferEntity.fromJson(Map<String, dynamic> json) => $AddReferEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddReferEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}