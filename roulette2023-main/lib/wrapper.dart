import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:roulette2023/common/appbar.dart';
import 'package:roulette2023/common/bottombar.dart';
import 'package:roulette2023/screens/bets.dart';
import 'package:roulette2023/screens/home.dart';
import 'package:roulette2023/screens/leaderboard.dart';

class Wrapper extends StatelessWidget {
  Wrapper(this.toggleCollapsed, this.changeIndex, this.index, this.reverse,
      {Key? key})
      : super(key: key);
  final Function toggleCollapsed;
  final Function changeIndex;
  final int index;
  final bool reverse;
  final title = ["Home", "My Bets", "Leaderboard"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      // backgroundColor: ,

      appBar: myAppBar(context, title[index], toggleCollapsed),
      body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: reverse,
          transitionBuilder: (child, animation, secondaryAnimation) =>
              SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              ),
          child: body(index)),
      bottomNavigationBar: BottomBar(index: index, changeIndex: changeIndex),
    );
  }
}

Widget body(int i) {
  if (i == 0) {
    return const Home();
  } else if (i == 1) {
    return const BetPage();
  } else if (i == 2) {
    return const Leaderboard();
  }
  return Container();
}
