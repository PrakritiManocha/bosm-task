import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:roulette2023/screens/welcome.dart';
import 'package:roulette2023/utils/database.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'common/menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isnew = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return FutureBuilder(
                future: Database.updateCurrentUser()
                    .then((_) => Database.syncTime()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (isnew) {
                    return WelcomePage(pop: false);
                  } else {
                    return MenuPage();
                  }
                });
          } else {
            return login(context);
          }
        });
  }

  Widget login(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          width: w,
          //height: size.height,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child:
                        SvgPicture.asset('assets/images/cclog.svg', width: 40),
                  )),
              const Spacer(),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      top: w * 0.2,
                      child: Image(
                          width: w,
                          image: const AssetImage('assets/coins.png'))),
                  const Image(image: AssetImage('assets/cards.png')),
                ],
              ),
              const Spacer(),
              if (Platform.isIOS)
                GradientButton(
                    w: w * 0.75,
                    h: 48,
                    image: const Icon(Icons.apple, color: Colors.white),
                    text: 'Sign in with Apple',
                    onTap: () {
                      signInWithApple();
                    }),
              if (Platform.isIOS) const SizedBox(height: 10),
              if (Platform.isIOS)
                Text(
                  'OR',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                ),
              if (Platform.isIOS) const SizedBox(height: 10),
              GradientButton(
                  w: w * 0.75,
                  h: 48,
                  image: SvgPicture.asset('assets/google.svg'),
                  text: 'Sign in with Google',
                  onTap: () {
                    signInWithGoogle();
                  }),
              const Spacer(),
              const Image(height: 40, image: AssetImage('assets/cclogo.png')),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void signInWithGoogle() async {
    final googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();
    if (googleUser == null) return;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (authResult.additionalUserInfo!.isNewUser) {
      isnew = true;
      await Database.storeUserData(
          name: googleUser.displayName!,
          email: googleUser.email,
          id: FirebaseAuth.instance.currentUser!.uid,
          slotTime: Timestamp.now());
    }
  }

  void signInWithApple() async {
    final appleid = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final credential = OAuthProvider('apple.com').credential(
      idToken: appleid.identityToken,
      accessToken: appleid.authorizationCode,
    );
    UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (authResult.additionalUserInfo!.isNewUser) {
      isnew = true;
      await Database.storeUserData(
          name: appleid.givenName! + ' ' + appleid.familyName!,
          email: appleid.email!,
          id: FirebaseAuth.instance.currentUser!.uid,
          slotTime: Timestamp.now());
    }
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton(
      {super.key,
      required this.w,
      required this.h,
      required this.onTap,
      required this.text,
      required this.image});

  final double w, h;
  final String text;
  final Widget? image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFFD256FF), Color(0xFF6256BF)]),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: w,
          height: h,
          alignment: Alignment.center,
          child: Row(
            children: [
              const Spacer(flex: 3),
              if (image != null) image!,
              if (image != null) const Spacer(flex: 2),
              Text(
                text,
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
