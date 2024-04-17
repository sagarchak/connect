import 'package:connect/generated/json/base/json_field.dart';
import 'package:connect/generated/json/rewards_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class RewardsEntity {
	int? giftId;
	String? title;
	String? description;
	int? point;
	String? image;
	int? status;
	int? updatedBy;
	String? updatedAt;
	int? createdBy;
	String? createdAt;
	dynamic deletedBy;
	dynamic deletedAt;
	int? redeemId;

	RewardsEntity();

	factory RewardsEntity.fromJson(Map<String, dynamic> json) => $RewardsEntityFromJson(json);

	Map<String, dynamic> toJson() => $RewardsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}