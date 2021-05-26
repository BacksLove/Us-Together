import 'package:shared_preferences/shared_preferences.dart';
import 'package:us_together/Backend/Entities/User.dart';

class SPreferences {

  void addString(String key, String text) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, text);
  }

  void addInt(String key, int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  void addDouble(String key, double value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble(key, value);
  }

  void addBool(String key, bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  Future<int> getInt(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  Future<String> getString(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  Future<bool> getBool(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }

  Future<double> getDouble(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getDouble(key);
  }

  void setCurrentUser(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("currentUserLastname", user.lastname);
    pref.setString("currentUserFirstname", user.firstname);
    pref.setString("currentUserUsername", user.username);
    pref.setString("currentUserEmail", user.email);
    pref.setString("currentUserImage", user.image);
    pref.setString("currentUserFcmToken", user.fcmToken);
    pref.setString("currentUserCreatedAt", user.createdDate.toIso8601String());
    pref.setString("currentUserUpdatedAt", user.updatedDate.toIso8601String());
    pref.setString("currentUserFcmToken", user.fcmToken);

  }

  Future<User> getCurrentUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    User currentUser = new User();
    currentUser.lastname = pref.getString("currentUserLastname");
    currentUser.firstname = pref.getString("currentUserFirstname");
    currentUser.username = pref.getString("currentUserUsername");
    currentUser.email = pref.getString("currentUserEmail");
    currentUser.image = pref.getString("currentUserImage");
    currentUser.fcmToken = pref.getString("currentUserFcmToken");
    currentUser.createdDate = DateTime.parse(pref.getString("currentUserCreatedAt"));
    currentUser.updatedDate = DateTime.parse(pref.getString("currentUserUpdatedAt"));
    currentUser.fcmToken = pref.getString("currentUserFcmToken");

    return currentUser;
  }

}