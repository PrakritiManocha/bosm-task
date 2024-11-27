import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BotAvatar extends StatelessWidget {
  const BotAvatar(
      {Key? key,
      required this.radius,
      required this.name,
      required this.avatar,
      required this.points})
      : super(key: key);
  final double radius;
  final String name;
  final String avatar;
  final int points;
  @override
  Widget build(BuildContext context) {
    final sty = GoogleFonts.outfit(
        color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500);
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/avatars/${int.parse(avatar) % 81}.svg',
          height: 2 * radius,
          width: 2 * radius,
        ),
        const SizedBox(height: 10),
        Text(name, style: sty),
        Text("$points", style: sty)
      ],
    );
  }
}
