import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:roulette2023/common/bottomsheet.dart';
import 'package:roulette2023/utils/gradientcolor.dart';

class Match extends StatelessWidget {
  const Match(
      {Key? key,
      required this.matchid,
      required this.sport,
      required this.gender,
      required this.date,
      required this.team1,
      required this.team2,
      required this.bet,
      required this.w,
      required this.size,
      required this.status,
      required this.canbet,
      required this.isbet,
      required this.updateHome,
      required this.won})
      : super(key: key);
  final String sport;
  final String gender;
  final Timestamp date;
  final String team1;
  final String team2;
  final int bet;
  final double w;
  final double size;
  final String? matchid, won;

  final String status;
  final bool isbet;
  final bool canbet;
  final Function()? updateHome;

  @override
  Widget build(BuildContext context) {
    var sty = GoogleFonts.lalezar(color: Colors.white, fontSize: 17);
    var texthead = GoogleFonts.lalezar(color: Colors.white, fontSize: 20);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/sports/${sport.toLowerCase()}.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.25), BlendMode.darken)),
            ),
            height: w * size,
            width: w * size,
          ),
          Container(
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 197, 197, 197),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            height: w * size * 0.15,
            width: w * size * 0.5,
            child: Center(
              child: GradientText(
                status,
                style: GoogleFonts.lalezar(
                    color: const Color(0xFF474747),
                    fontSize: 10,
                    fontWeight: FontWeight.w900),
                gradient: const LinearGradient(
                    colors: [Color(0xFFD256FF), Color(0xFF6256BF)]),
              ),
            ),
          )
        ]),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF474747),
          ),
          height: w * (size - 0.05),
          width: w * (1 - size),
          child: Column(children: [
            Row(
              children: [
                Text('$sport  ', style: sty),
                Text(gender,
                    style: GoogleFonts.lalezar(
                        color: const Color(0xFF7B7B7B),
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(DateFormat('d MMM  ').format(date.toDate()), style: sty)
              ],
            ),
            const Spacer(),
            FittedBox(
              child: Text("$team1  vs  $team2",
                  overflow: TextOverflow.ellipsis, style: texthead),
              fit: BoxFit.contain,
            ),
            const Spacer(),
            if (isbet)
              Row(
                children: [
                  Text("Bet: $bet", style: sty),
                  const Spacer(),
                  if (won != null)
                    GradientText("${won!}${(won == "Tie") ? "" : " Won"}",
                        style: sty,
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 222, 132, 255),
                          Color.fromARGB(255, 144, 129, 255)
                        ]))
                ],
              )
            else
              Row(
                mainAxisAlignment: (canbet)
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: w * 0.075,
                    child: (canbet)
                        ? ElevatedButton(
                            onPressed: () => {
                              amount_btmsheet(context, matchid!, sport, gender,
                                  team1, team2, false, updateHome)
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0xFFD256FF),
                                    Color(0xFF6256BF)
                                  ]),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                width: w * 0.18,
                                height: w * 0.10,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Bet',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                  Text(DateFormat('jm').format(date.toDate()), style: sty)
                ],
              )
          ]),
        ),
      ],
    );
  }
}
