class AppConstants {
  static RegExp emailRegexp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static RegExp mobileNumberRegexp = RegExp(r'^(?:\+?88)?01[3-9]\d{8}$');
  static RegExp strongPasswordRegexp =
      RegExp(r'^(?=.*[!@#\$&*~])(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#\$&*~]{9,}$');
}
