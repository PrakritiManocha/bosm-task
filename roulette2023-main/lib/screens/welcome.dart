import 'package:flutter/material.dart';
import 'package:roulette2023/common/menu.dart';
import 'package:roulette2023/screens/screenmodal.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Gradient kpurp = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromRGBO(210, 86, 255, 1), Color.fromRGBO(98, 86, 191, 1)]);

int currentindex = 0;

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required this.pop}) : super(key: key);
  final bool pop;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  List<ScreenModel> screens = <ScreenModel>[
    ScreenModel(
        img: "assets/images/Welcome-1.png",
        text: "",
        desc:
            "BOSM Roulette is a virtual\n money betting app where you bet on teams participating in BOSM'23 using BITSCOIN"),
    ScreenModel(
        img: "assets/images/Welcome-2.png",
        text: "How the bets work",
        desc:
            "You can bet any amount your wallet permits. If you win, you earn back your BITSCOIN with 25% extra bonus. The lesser the relative bets on your team, the higher the bonus. If you lose, you only get 25% of your BITSCOIN back."),
    ScreenModel(
        img: "assets/images/Welcome-3.png",
        text: "The My Bets Tab",
        desc:
            "The bets tab displays the matches you've bet on. A green status indicates a successful bet, a red status indicates a failed bet and an orange status indicates that the match is either ongoing or has ended in a draw. The amount indiacates the BITSCOIN received from a bet."),
    ScreenModel(
        img: "assets/images/Welcome-4.png",
        text: "The My Bets Tab",
        desc:
            "The bets tab displays the matches you've bet on. A green status indicates a successful bet, a red status indicates a failed bet and an orange status indicates that the match is either ongoing or has ended in a draw. The amount indiacates the BITSCOIN received from a bet."),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover),
            ),
            child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  int sensitivity = 2;
                  if (details.delta.dx < -sensitivity) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  } else if (details.delta.dx > sensitivity) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                            itemCount: screens.length,
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (int index) {
                              setState(() {
                                currentindex = index;
                              });
                            },
                            itemBuilder: (_, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 35.92,
                                        width: 32.88,
                                        child: Image.asset(
                                            "assets/images/cc_icon.png"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: 210 *
                                          MediaQuery.of(context).size.height /
                                          800),
                                  SizedBox(
                                      height: index == 0
                                          ? 250
                                          : index == 1
                                              ? 159
                                              : index == 2
                                                  ? 173
                                                  : 210,
                                      child: Image.asset(
                                        screens[index].img,
                                      )),
                                  const Spacer(),
                                  SizedBox(
                                    width: 312 *
                                        MediaQuery.of(context).size.width /
                                        360,
                                    child: Text(
                                      screens[index].text,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Text(
                                    screens[index].desc,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: index == 0 ? 18.0 : 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 67, 0, 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: screens.length,
                              effect: const ExpandingDotsEffect(
                                dotHeight: 8.0,
                                dotWidth: 8.0,
                                dotColor: Color.fromRGBO(210, 86, 255, 1),
                                activeDotColor: Color.fromRGBO(210, 86, 255, 1),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, gradient: kpurp),
                                child: const Icon(
                                  Icons.navigate_next,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                if (currentindex != 3) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                } else {
                                  if (widget.pop) {
                                    Navigator.of(context).pop();
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MenuPage()));
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
