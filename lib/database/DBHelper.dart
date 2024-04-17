

import 'package:connect/database/entity/user_entity.dart';
import 'package:connect/utils/SharedPrefer.dart';
import 'package:connect/utils/common_utils.dart';

import '../objectbox.g.dart';

class DBHelper {
  DBHelper._privateConstructor();

  static final DBHelper mInstance = DBHelper._privateConstructor();

  //Inserting Values into UserDetails
  void putUser(UserEntity? user) async {
    if (user != null && CommonUtils.checkIfNotNull(user.mobile)) {
      Box<UserEntity>? userBox =   CommonUtils.boxStore?.box<UserEntity>();
      Query<UserEntity>? builder = userBox?.query(UserEntity_.mobile.equals(user.mobile!).and(UserEntity_.custId.equals(user.custId!))).build();
      UserEntity? resultUser = builder?.findFirst();
      if (resultUser != null) {
        user.id = resultUser.id;
      } else {
        user.id = 0;
      }
      userBox?.put(user);



    }
  }

  //Querying particular Data from MyDetails
  UserEntity? getMainUser() {
    Box<UserEntity>? userBox =  CommonUtils.boxStore?.box<UserEntity>();
    List<UserEntity>? userList = userBox?.getAll();
    if(userList != null && userList.isNotEmpty){
      return userList.first;
    }
    return null;
  }

  deleteMainUser() async {
    String? token = await SharedPrefer.getString(SharedPrefer.TOKEN);
    if (CommonUtils.checkIfNotNull(token)) {
      Box<UserEntity>? userBox = CommonUtils.boxStore?.box<UserEntity>();
      userBox?.removeAll();
    }
  }

  void deleteAll() {
    Box<UserEntity>? userBox = CommonUtils.boxStore?.box<UserEntity>();
    userBox?.removeAll();
  }
}
