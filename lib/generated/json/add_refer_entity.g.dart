import 'package:connect/generated/json/base/json_convert_content.dart';
import 'package:connect/database/entity/add_refer_entity.dart';

AddReferEntity $AddReferEntityFromJson(Map<String, dynamic> json) {
	final AddReferEntity addReferEntity = AddReferEntity();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		addReferEntity.name = name;
	}
	final String? mobile = jsonConvert.convert<String>(json['mobile']);
	if (mobile != null) {
		addReferEntity.mobile = mobile;
	}
	final String? product = jsonConvert.convert<String>(json['product']);
	if (product != null) {
		addReferEntity.product = product;
	}
	return addReferEntity;
}

Map<String, dynamic> $AddReferEntityToJson(AddReferEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['mobile'] = entity.mobile;
	data['product'] = entity.product;
	return data;
}