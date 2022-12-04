import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialSignInController {
  FirebaseMessaging msg = FirebaseMessaging.instance;
  String? Token, appletoken, idtoken, usertoken;

  Future<UserCredential> signWithApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ]);

    final String accessToken = (appleIdCredential.authorizationCode.toString());
    idtoken = (appleIdCredential.identityToken.toString());
    usertoken = (appleIdCredential.userIdentifier.toString());
    appletoken = accessToken;

    print("token : $accessToken");
    final oAuthProvider = OAuthProvider("apple.com");
    final credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode);
    final x = await FirebaseAuth.instance.signInWithCredential(credential);
    print("x is : ${appleIdCredential.identityToken}");
    // final authResult = await _firebaseAuth.signInWithCredential(credential);
    //  final firebaseUser = x.user;
    //
    //
    //  print("x: $firebaseUser");
    //  name = oAuthProvider.scopes[1];
    //  email = oAuthProvider.scopes[0];
    //  accestoken = credential.accessToken!;
    //  secret = credential.secret!;
    //  idtoken = credential.idToken!;
    //
    //  print("name: $name");
    //   print("email: $email");
    //    print("accestoken: $accestoken");
    //     print("secret: $secret");
    //      print("idtoken: $idtoken");
    return x;
  }
  //Google Auth

  Future<UserCredential> signWithGoogle() async {
    print("wow");

    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("try this : ${googleAuth.accessToken}");
    Token = googleAuth.accessToken;
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

// // Facebook
//   Future<UserCredential> signInWithFacebook() async {
//     final LoginResult result = await FacebookAuth.instance.login();

//     final OAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(result.accessToken!.token);

//     return await FirebaseAuth.instance
//         .signInWithCredential(facebookAuthCredential);
//   }
}
