import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roulette2023/DevPage.dart';
import 'package:roulette2023/screens/welcome.dart';
import 'package:roulette2023/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/gradientcolor.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true, reverse = false;
  int index = 0;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<BorderRadius?> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.78).animate(curve);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(curve);
    _borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(32.0),
    ).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleCollapsed() {
    setState(() {
      isCollapsed ? _controller.forward() : _controller.reverse();
      isCollapsed = !isCollapsed;
    });
  }

  void changeIndex(int i) {
    if (i == index) return;
    setState(() {
      reverse = i < index;
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
            Color(0xff7E7E7E),
            Color(0xff000000),
          ])),
      child: Stack(
        children: <Widget>[menu(context), dashboard(context)],
      ),
    ));
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Spacer(flex: 9),
          HamTile('Home', index == 0, () {
            changeIndex(0);
            toggleCollapsed();
          }),
          Spacer(),
          HamTile('My Bets', index == 1, () {
            changeIndex(1);
            toggleCollapsed();
          }),
          Spacer(),
          HamTile('Leaderboard', index == 2, () {
            changeIndex(2);
            toggleCollapsed();
          }),
          Spacer(),
          HamTile('About', index == 3, () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const WelcomePage(pop: true)));
            toggleCollapsed();
          }),
          Spacer(),
          HamTile('Developers', index == 4, () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const DevPage()));
          }),
          Spacer(),
          HamTile('Logout', index == 5, () {
            FirebaseAuth.instance.signOut();
          }),
          Spacer(),
          if (Platform.isIOS)
            HamTile(
              'Delete Account',
              index == 6,
              () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xFF242529),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 10),
                                      blurRadius: 10),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                    "Are you sure to delete your account?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFFFFFF))),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () async {},
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.all(16),
                                          backgroundColor:
                                              const Color(0xFFEE4B2B),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                        child: const Text("Yes",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF000000))),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.all(16),
                                          backgroundColor:
                                              const Color(0xFF4CBB17),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                        child: const Text("No",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF000000))),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    });
              },
            ),
          SvgPicture.asset('assets/images/menu_image.svg'),
        ],
      ),
    );
  }

  Widget dashboard(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      right: isCollapsed ? 0 : -0.5 * w,
      left: isCollapsed ? 0 : 0.5 * w,
      duration: duration,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          elevation: 100,
          child: AnimatedBuilder(
            animation: _borderRadiusAnimation,
            builder: (context, child) {
              return ClipRRect(
                borderRadius: _borderRadiusAnimation.value!,
                child: GestureDetector(
                  onTap: () {
                    if (!isCollapsed) {
                      toggleCollapsed();
                    }
                  },
                  child: Wrapper(toggleCollapsed, changeIndex, index, reverse),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HamTile extends StatelessWidget {
  const HamTile(
    this.title,
    this.gradient,
    this.onTap, {
    super.key,
  });

  final String title;
  final bool gradient;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 15),
          SvgPicture.asset(
            'assets/images/$title.svg',
          ),
          const SizedBox(width: 10),
          if (gradient)
            GradientText(
              title,
              style: GoogleFonts.lalezar(
                  color: const Color(0xFF474747),
                  fontSize: 32,
                  fontWeight: FontWeight.w900),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 222, 132, 255),
                Color.fromARGB(255, 144, 129, 255)
              ]),
            )
          else
            Text(
              title,
              style: GoogleFonts.lalezar(
                  fontWeight: FontWeight.w400,
                  fontSize: 28,
                  color: Colors.white),
            ),
        ],
      ),
    );
  }
}
