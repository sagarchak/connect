import 'package:connect/generated/json/base/json_convert_content.dart';
import 'package:connect/database/entity/post_details_entity.dart';

PostDetailsEntity $PostDetailsEntityFromJson(Map<String, dynamic> json) {
	final PostDetailsEntity postDetailsEntity = PostDetailsEntity();
	final int? postId = jsonConvert.convert<int>(json['postId']);
	if (postId != null) {
		postDetailsEntity.postId = postId;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		postDetailsEntity.title = title;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		postDetailsEntity.content = content;
	}
	final dynamic videoUrl = jsonConvert.convert<dynamic>(json['videoUrl']);
	if (videoUrl != null) {
		postDetailsEntity.videoUrl = videoUrl;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		postDetailsEntity.image = image;
	}
	final String? webUrl = jsonConvert.convert<String>(json['webUrl']);
	if (webUrl != null) {
		postDetailsEntity.webUrl = webUrl;
	}
	final int? updatedBy = jsonConvert.convert<int>(json['updatedBy']);
	if (updatedBy != null) {
		postDetailsEntity.updatedBy = updatedBy;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
	if (updatedAt != null) {
		postDetailsEntity.updatedAt = updatedAt;
	}
	final dynamic createdBy = jsonConvert.convert<dynamic>(json['createdBy']);
	if (createdBy != null) {
		postDetailsEntity.createdBy = createdBy;
	}
	final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
	if (createdAt != null) {
		postDetailsEntity.createdAt = createdAt;
	}
	final dynamic deletedBy = jsonConvert.convert<dynamic>(json['deletedBy']);
	if (deletedBy != null) {
		postDetailsEntity.deletedBy = deletedBy;
	}
	final dynamic deletedAt = jsonConvert.convert<dynamic>(json['deletedAt']);
	if (deletedAt != null) {
		postDetailsEntity.deletedAt = deletedAt;
	}
	return postDetailsEntity;
}

Map<String, dynamic> $PostDetailsEntityToJson(PostDetailsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['postId'] = entity.postId;
	data['title'] = entity.title;
	data['content'] = entity.content;
	data['videoUrl'] = entity.videoUrl;
	data['image'] = entity.image;
	data['webUrl'] = entity.webUrl;
	data['updatedBy'] = entity.updatedBy;
	data['updatedAt'] = entity.updatedAt;
	data['createdBy'] = entity.createdBy;
	data['createdAt'] = entity.createdAt;
	data['deletedBy'] = entity.deletedBy;
	data['deletedAt'] = entity.deletedAt;
	return data;
}