import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/database.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key, required this.updateHome});
  final void Function() updateHome;

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel>
    with SingleTickerProviderStateMixin {
  List<int> sectors = [150, 10, 500, 0, 1000, 50, 150, 100, 250, 300, 20, 200];
  int randomSectorIndex = -1;
  List<double> sectorRadians = [];
  double angle = 0;

  int earnedValue = 0;
  double totalEarnings = 0;
  int spins = 0;

  Random random = Random();

  late AnimationController controller;

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    generateSectorRadians();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: controller, curve: const Cubic(0.35, -0.3, 0.4, 1)));

    controller.addListener(() {
      if (controller.isCompleted) {
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++');
        recordStats();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey.shade900,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  title: Center(
                      child: Text(
                    'You won $earnedValue',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 24),
                  )),
                  content: const Icon(
                    Icons.check_rounded,
                    color: Colors.green,
                    size: 100,
                  ),
                  actions: [
                    TextButton(
                      child: Center(
                          child: Text(
                        "OK",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 20),
                      )),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        widget.updateHome();
                      },
                    )
                  ],
                ));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Spin the Wheel",
          style: GoogleFonts.lalezar(
              fontWeight: FontWeight.w400, color: Colors.white, fontSize: 32),
        ),
      ),
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/background.png'))),
          child: _gameWheel()),
    );
  }

  Widget _gamecontent() {
    return Stack(
      children: [
        _gameWheel(),
        // _gameActions(),
        // _gamestats(),
      ],
    );
  }

  Widget _gameWheel() {
    return Column(
      children: [
        const Spacer(flex: 2),
        Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              bottom: 100,
              child: Container(
                  height: MediaQuery.of(context).size.width * 0.75,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      'assets/poker.png',
                    ),
                  ))),
            ),
            AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: animation.value * angle,
                    child: Container(
                        height: MediaQuery.of(context).size.width * 0.7,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: const BoxDecoration(
                            // color: Colors.amber,
                            image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/wheel.png',
                          ),
                        ))),
                  );
                }),
            Container(
              height: MediaQuery.of(context).size.width * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: const BoxDecoration(
                // color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/wheel_belt.png')),
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
            child: SvgPicture.asset('assets/spinbtn.svg'),
            onTap: () {
              spin();
            }),
        const Spacer(flex: 2),
      ],
    );
  }

  void generateSectorRadians() {
    double sectorRadian = 2 * pi / sectors.length;

    for (int i = 0; i < sectors.length; i++) {
      sectorRadians.add((i + 1) * sectorRadian);
    }
  }

  void recordStats() {
    earnedValue = sectors[sectors.length - 1 - randomSectorIndex];
    Database.updateSlotTime();
    Database.updateWallet(earnedValue);
    spins++;
  }

  void spin() {
    randomSectorIndex = random.nextInt(sectors.length);
    angle = pi * 4 + sectorRadians[randomSectorIndex];
    controller.reset();
    controller.forward();
  }
}
