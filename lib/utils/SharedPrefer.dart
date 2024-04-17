import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefer {
  static String TOKEN = "token";
  static String IS_SYNCING = "is_syncing";
  static String TRUCK_REG_NUM = "_truck_reg_num";
  static String TRUCK_START_KM = "_truck_start_km";
  static String TRUCK_END_KM = "_truck_end_km";
  static String WORK_LOCATION = "_work_location";
  static String CLIENT_WORKSPACE = "_client_workspace";
  static String LAST_PAGE_TYPE = "_last_page_type";
  static String SUBSCRIBED = "_is_subscribed";
  static String CLOCK_IN_TIME = "clock_in_time";
  static String LOCATION_PERMISSION_ALLOWED = "_is_location_permission_allowed";
  static String NEW_UPDATE_AVAIALBLE = "_new_update_available";
  static String FORCE_UPDATE = "_force_update";
  static String VIDEO_ID = "_video_id";
  static String LAST_DURATION = "_last_duration";

  static Future<void> removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<void> saveBoolean(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> getBoolean(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(key) != null) {
      return prefs.getBool(key)!;
    }
    return false;
  }

  static Future<void> saveInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<void> saveDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static Future<int?> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt(key) != null) {
      return prefs.getInt(key);
    }
    return -1;
  }

  static Future<void> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
