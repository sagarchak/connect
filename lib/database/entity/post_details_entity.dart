import 'package:connect/generated/json/base/json_field.dart';
import 'package:connect/generated/json/post_details_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class PostDetailsEntity {
	int? postId;
	String? title;
	String? content;
	dynamic videoUrl;
	String? image;
	String? webUrl;
	int? updatedBy;
	String? updatedAt;
	dynamic createdBy;
	String? createdAt;
	dynamic deletedBy;
	dynamic deletedAt;

	PostDetailsEntity();

	factory PostDetailsEntity.fromJson(Map<String, dynamic> json) => $PostDetailsEntityFromJson(json);

	Map<String, dynamic> toJson() => $PostDetailsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}