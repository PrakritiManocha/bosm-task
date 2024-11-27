import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.index, required this.changeIndex})
      : super(key: key);
  final int index;
  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xff242424).withOpacity(0.89),
      currentIndex: index,
      onTap: (index) {
        changeIndex(index);
      },
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Home.svg',
            ),
            label: '',
            activeIcon: SvgPicture.asset('assets/images/1_active.svg')),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/My Bets.svg',
            ),
            label: '',
            activeIcon: SvgPicture.asset('assets/images/2_active.svg')),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Leaderboard.svg',
            ),
            label: '',
            activeIcon: SvgPicture.asset('assets/images/3_active.svg')),
      ],
    );
  }
}
