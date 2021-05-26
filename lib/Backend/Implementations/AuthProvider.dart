import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:us_together/Backend/Entities/User.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';
import 'package:us_together/Backend/Implementations/UserProvider.dart';

abstract class BaseAuth {
  Future<bool> signInWithEmail(String email, String password);
  Future<bool> signUpWithEmail(User cuser, String password);
  Future<bool> loginWithGoogle();
  Future <void> logOut();
  Future<String> currentUser();
}

class AuthProvider  extends BaseAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserProvider _userProvider = new UserProvider();
  final SPreferences _preferences = new SPreferences();

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = result.user;
      if (user != null) {

        User currentUser = User();
        await _userProvider.GetUser(email).then((value) {
          currentUser = value;
        });

        await _preferences.setCurrentUser(currentUser);

        return true;
      } else
        return false;
    } catch(e) {
      return false;
    }
  }

  Future<bool> signUpWithEmail(User cuser, String password) async {
    try {
      print(1);
      FirebaseUser user;
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: cuser.email, password: password).then((value){
        user = value.user;
      }).catchError((e) => print(e));
      print(2);
      print("Result : $result");
      //FirebaseUser user = result.user;
      print(3);
      if (user != null) {
        _preferences.setCurrentUser(cuser);
        print(4);
        _userProvider.AddUser(cuser);
        print(5);
        return true;
      } else
        return false;
    } catch (e) {
        print("nope");
          print(e);
      return false;
    }
  }

  Future <void> logOut() async {
    try {
      await _auth.signOut();
    } catch(e) {
      print("Erreur pendant la deconnexion");
    }
  }

  Future<bool> loginWithGoogle () async {

    List<String> displayName = [];
    String Lastname = "";
    String Firstname = "";
    String Email = "";
    String Username = "";
    DateTime CreatedDate = DateTime.now();

    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) {
        print("le account est null");
        return false;
      }
      AuthResult result = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: (await account.authentication).idToken,
          accessToken: (await account.authentication).accessToken));
      if (result.user == null){
        print("le user est nul");
        return false;
      }
      displayName = result.user.displayName.split(" ");
      Firstname = displayName[0];
      Lastname = displayName[1];
      Username = result.user.displayName;
      Email = result.user.email;

      User currentUser = new User();
      currentUser.firstname = Firstname;
      currentUser.lastname = Lastname;
      currentUser.username = Username;
      currentUser.email = Email;
      currentUser.createdDate = CreatedDate;
      currentUser.updatedDate = CreatedDate;
      currentUser.fcmToken = "";
      currentUser.image = "";

      await _preferences.setCurrentUser(currentUser);
      _userProvider.UserExist(currentUser.email).then((value) {
        if (value == false) {
          _userProvider.AddUser(currentUser);
        }
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }

}