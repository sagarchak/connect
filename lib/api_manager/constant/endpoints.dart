class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://pariwar.frontiza.in";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String send_Otp = '$baseUrl/api/send-otp';
  static const String resendOtp = '$baseUrl/api/resend-otp';
  static const String verifyOtp = '$baseUrl/api/verify-otp';
  static const String getProfile = '$baseUrl/api/profile';
  static const String getPostDetails1 = '$baseUrl/api/post/1';
  static const String getPostDetails2 = '$baseUrl/api/post/2';
  static const String getPostDetails3 = '$baseUrl/api/post/3';
  static const String getReward = '$baseUrl/api/gifts';
  static const String postRedeem = '$baseUrl/api/redeem';
  static const String updateProfile = '$baseUrl/api/profile';
  static const String logOut = '$baseUrl/api/logout';
  static const String addRefer = '$baseUrl/api/refers';

}
