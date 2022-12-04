import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hilike/Networking/Mobx/signup_mobx.dart';
import 'package:hilike/Networking/controller/sign_in_controller.dart';
import 'package:hilike/generated/l10n.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'dart:io' show Platform;

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String? ftoken, fname, femail;

  Future<void> facebooklogin() async {
// Create an instance of FacebookLogin
    final fb = FacebookLogin();

// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        ftoken = accessToken!.token;
        print('Access token: ${accessToken.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        fname = profile.name;
        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        femail = email ?? "";

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SocialSignInController controller = SocialSignInController();
    SignupMobx signupMobx = SignupController();
    var token;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/coop.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0x1A1A1A),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: size.height / 2.2,
              ),
              Text(
                S.of(context).welcomeToHilike,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: size.height / 100,
              ),
              Text(
                S
                    .of(context)
                    .findTheBestAndMostSuitablePartner
                    .replaceAll("\\n", "\n"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xfff5f5f5),
                  fontSize: 13,
                  letterSpacing: 0.65,
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Visibility(
                visible: Platform.isIOS,
                child: GestureDetector(
                  onTap: () {
                    controller.signWithApple().then((value) async {
                      signupMobx.setEmail(value.user!.email);
                      signupMobx
                          .setUsername("${Random.secure().nextInt(1515452)}");
                      signupMobx.setProvider("apple");
                      print("usertoken: ${controller.usertoken}");
                      signupMobx.setProvidertoken(controller.idtoken);
                      await signupMobx.socialLoginnew(
                          context, controller.idtoken!, "apple",
                          onSuccess: () => Navigator.pushReplacementNamed(
                              context, 'mainmenu'));
                    });
                  },
                  child: Container(
                    height: size.height / 17,
                    width: size.width / 1.7,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 21,
                        ),
                        Container(
                          height: 20.5,
                          width: 20.5,
                          child: Image.asset("assets/img/222.png"),
                        ),
                        SizedBox(width: 36.5),
                        Text(
                          S.of(context).logInWithApple,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff4f4f4f),
                            fontFamily: 'Roboto',
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller
                      .signWithGoogle()
                      .then((UserCredential value) async {
                    signupMobx.setEmail(value.user!.email);

                    signupMobx.setUsername(
                        value.user!.displayName!.replaceAll(" ", "") +
                            "${Random.secure().nextInt(1515452)}");
                    signupMobx.setProvider("google");
                    signupMobx.setProvidertoken(controller.Token!);

                    await signupMobx.socialLoginnew(
                        context, controller.Token!, "google",
                        onSuccess: () => Navigator.pushReplacementNamed(
                            context, 'mainmenu'));
                  });
                },
                child: Container(
                  height: size.height / 17,
                  width: size.width / 1.7,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 21,
                      ),
                      Container(
                        height: 20.5,
                        width: 20.5,
                        child: Image.asset("assets/img/111.png"),
                      ),
                      SizedBox(width: 36.5),
                      Text(
                        S.of(context).logInWithGoogle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff4f4f4f),
                          fontFamily: 'Roboto',
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  facebooklogin().then((value) async {
                    signupMobx.setEmail(femail);

                    signupMobx.setUsername(fname!.replaceAll(" ", "") +
                        "${Random.secure().nextInt(1515452)}");
                    signupMobx.setProvider("facebook");
                    signupMobx.setProvidertoken(ftoken);

                    await signupMobx.socialLoginnew(
                        context, ftoken!, "facebook",
                        onSuccess: () => Navigator.pushReplacementNamed(
                            context, 'mainmenu'));
                  });
                },
                child: Container(
                  height: size.height / 17,
                  width: size.width / 1.7,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 21,
                      ),
                      Container(
                        height: 20.5,
                        width: 20.5,
                        child: Image.asset("assets/img/333.png"),
                      ),
                      SizedBox(width: 36.5),
                      Text(
                        S.of(context).logInWithFacebook,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff4f4f4f),
                          fontFamily: 'Roboto',
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).iAlreadyHaveAnAccount,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.65,
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: Text(
                        S.of(context).logIn,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff0583f2),
                          fontFamily: 'Roboto',
                          fontSize: 13,
                          letterSpacing: 0.65,
                          fontWeight: FontWeight.normal,
                          // decoration: TextDecoration.underline,
                        ),
                      )),
                  SizedBox(
                    width: 9,
                  ),
                  Text(
                    S.of(context).or,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.65,
                    ),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    child: Text(
                      S.of(context).signUp,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff0583f2),
                        fontFamily: 'Roboto',
                        fontSize: 13,
                        letterSpacing: 0.65,
                        fontWeight: FontWeight.normal,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).ifYouNeedHelpPlease,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.55,
                    ),
                  ),
                  SizedBox(
                    width: 2.5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'p&p');
                    },
                    child: Text(
                      S.of(context).contactUs,
                      style: TextStyle(
                        color: Color(0xff0583f2),
                        fontFamily: 'Roboto',
                        fontSize: 11,
                        letterSpacing: 0.55,
                        fontWeight: FontWeight.normal,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height / 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 9.06,
                      height: 9.11,
                      child: Image.asset("assets/img/!.png")),
                  SizedBox(
                    width: 9,
                  ),
                  Text(
                    "${S.of(context).byRegisteringYouAcceptTheTermsOfUse}  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'policy');
                    },
                    child: Text(
                      S.of(context).usagePolicy,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 11,
                        letterSpacing: 0.55,
                        fontWeight: FontWeight.normal,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
