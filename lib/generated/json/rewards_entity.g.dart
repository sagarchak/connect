import 'package:connect/generated/json/base/json_convert_content.dart';
import 'package:connect/database/entity/rewards_entity.dart';

RewardsEntity $RewardsEntityFromJson(Map<String, dynamic> json) {
	final RewardsEntity rewardsEntity = RewardsEntity();
	final int? giftId = jsonConvert.convert<int>(json['giftId']);
	if (giftId != null) {
		rewardsEntity.giftId = giftId;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		rewardsEntity.title = title;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		rewardsEntity.description = description;
	}
	final int? point = jsonConvert.convert<int>(json['point']);
	if (point != null) {
		rewardsEntity.point = point;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		rewardsEntity.image = image;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		rewardsEntity.status = status;
	}
	final int? updatedBy = jsonConvert.convert<int>(json['updatedBy']);
	if (updatedBy != null) {
		rewardsEntity.updatedBy = updatedBy;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
	if (updatedAt != null) {
		rewardsEntity.updatedAt = updatedAt;
	}
	final int? createdBy = jsonConvert.convert<int>(json['createdBy']);
	if (createdBy != null) {
		rewardsEntity.createdBy = createdBy;
	}
	final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
	if (createdAt != null) {
		rewardsEntity.createdAt = createdAt;
	}
	final dynamic deletedBy = jsonConvert.convert<dynamic>(json['deletedBy']);
	if (deletedBy != null) {
		rewardsEntity.deletedBy = deletedBy;
	}
	final dynamic deletedAt = jsonConvert.convert<dynamic>(json['deletedAt']);
	if (deletedAt != null) {
		rewardsEntity.deletedAt = deletedAt;
	}
	final int? redeemId = jsonConvert.convert<int>(json['redeemId']);
	if (redeemId != null) {
		rewardsEntity.redeemId = redeemId;
	}
	return rewardsEntity;
}

Map<String, dynamic> $RewardsEntityToJson(RewardsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['giftId'] = entity.giftId;
	data['title'] = entity.title;
	data['description'] = entity.description;
	data['point'] = entity.point;
	data['image'] = entity.image;
	data['status'] = entity.status;
	data['updatedBy'] = entity.updatedBy;
	data['updatedAt'] = entity.updatedAt;
	data['createdBy'] = entity.createdBy;
	data['createdAt'] = entity.createdAt;
	data['deletedBy'] = entity.deletedBy;
	data['deletedAt'] = entity.deletedAt;
	data['redeemId'] = entity.redeemId;
	return data;
}