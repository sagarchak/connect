import 'package:connect/generated/json/base/json_field.dart';
import 'package:connect/generated/json/user_entity.g.dart';
import 'dart:convert';

import 'package:objectbox/objectbox.dart';

@JsonSerializable()
@Entity()
class UserEntity {
	@Id()
int	id = 0;

	int? custId;
	String? name;
	String? email;
	String? mobile;
	String? address;
	String? dob;
	String? pan;
	String? aadhaar;
	String? image;
	String? aboutMe;
	int? points;
	dynamic emailVerifiedAt;
	int? status;
	dynamic updatedBy;
	String? updatedAt;
	dynamic createdBy;
	dynamic createdAt;
	dynamic deletedBy;
	dynamic deletedAt;

	UserEntity();

	factory UserEntity.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}