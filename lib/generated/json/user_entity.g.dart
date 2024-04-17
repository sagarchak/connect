import 'package:connect/generated/json/base/json_convert_content.dart';
import 'package:connect/database/entity/user_entity.dart';
import 'package:objectbox/objectbox.dart';


UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
	final UserEntity userEntity = UserEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		userEntity.id = id;
	}
	final int? custId = jsonConvert.convert<int>(json['custId']);
	if (custId != null) {
		userEntity.custId = custId;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		userEntity.name = name;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		userEntity.email = email;
	}
	final String? mobile = jsonConvert.convert<String>(json['mobile']);
	if (mobile != null) {
		userEntity.mobile = mobile;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		userEntity.address = address;
	}
	final String? dob = jsonConvert.convert<String>(json['dob']);
	if (dob != null) {
		userEntity.dob = dob;
	}
	final String? pan = jsonConvert.convert<String>(json['pan']);
	if (pan != null) {
		userEntity.pan = pan;
	}
	final String? aadhaar = jsonConvert.convert<String>(json['aadhaar']);
	if (aadhaar != null) {
		userEntity.aadhaar = aadhaar;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		userEntity.image = image;
	}
	final String? aboutMe = jsonConvert.convert<String>(json['aboutMe']);
	if (aboutMe != null) {
		userEntity.aboutMe = aboutMe;
	}
	final int? points = jsonConvert.convert<int>(json['points']);
	if (points != null) {
		userEntity.points = points;
	}
	final dynamic emailVerifiedAt = jsonConvert.convert<dynamic>(json['emailVerifiedAt']);
	if (emailVerifiedAt != null) {
		userEntity.emailVerifiedAt = emailVerifiedAt;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		userEntity.status = status;
	}
	final dynamic updatedBy = jsonConvert.convert<dynamic>(json['updatedBy']);
	if (updatedBy != null) {
		userEntity.updatedBy = updatedBy;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
	if (updatedAt != null) {
		userEntity.updatedAt = updatedAt;
	}
	final dynamic createdBy = jsonConvert.convert<dynamic>(json['createdBy']);
	if (createdBy != null) {
		userEntity.createdBy = createdBy;
	}
	final dynamic createdAt = jsonConvert.convert<dynamic>(json['createdAt']);
	if (createdAt != null) {
		userEntity.createdAt = createdAt;
	}
	final dynamic deletedBy = jsonConvert.convert<dynamic>(json['deletedBy']);
	if (deletedBy != null) {
		userEntity.deletedBy = deletedBy;
	}
	final dynamic deletedAt = jsonConvert.convert<dynamic>(json['deletedAt']);
	if (deletedAt != null) {
		userEntity.deletedAt = deletedAt;
	}
	return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['custId'] = entity.custId;
	data['name'] = entity.name;
	data['email'] = entity.email;
	data['mobile'] = entity.mobile;
	data['address'] = entity.address;
	data['dob'] = entity.dob;
	data['pan'] = entity.pan;
	data['aadhaar'] = entity.aadhaar;
	data['image'] = entity.image;
	data['aboutMe'] = entity.aboutMe;
	data['points'] = entity.points;
	data['emailVerifiedAt'] = entity.emailVerifiedAt;
	data['status'] = entity.status;
	data['updatedBy'] = entity.updatedBy;
	data['updatedAt'] = entity.updatedAt;
	data['createdBy'] = entity.createdBy;
	data['createdAt'] = entity.createdAt;
	data['deletedBy'] = entity.deletedBy;
	data['deletedAt'] = entity.deletedAt;
	return data;
}