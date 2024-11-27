import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roulette2023/common/tile.dart';

import '../utils/database.dart';

class BetPage extends StatefulWidget {
  const BetPage({super.key});

  @override
  State<BetPage> createState() => _BetPageState();
}

class _BetPageState extends State<BetPage> {
  late List<Map<String, dynamic>> _betList;
  late Future<void> _initBetData;
  @override
  void initState() {
    super.initState();
    _initBetData = _initBets();
  }

  Future<void> _initBets() async {
    _betList = await Database.getMyBets();
    _betList.sort((a, b) => (b['date'] as Timestamp).compareTo(
          a['date'] as Timestamp,
        ));
  }

  Future<void> _refreshBets() async {
    final bets = await Database.getMyBets();
    setState(() {
      _betList = bets;
      _betList.sort((a, b) => (b['date'] as Timestamp).compareTo(
            a['date'] as Timestamp,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    double p = 10;
    return FutureBuilder(
        future: _initBetData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final games = _betList;
          if (games.isEmpty) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'Place your bets on the Homepage. Remember that there is no real money invloved. Good Luck!',
                textAlign: TextAlign.center,
                softWrap: true,
                style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ));
          }
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover)),
            child: RefreshIndicator(
              displacement: 80,
              edgeOffset: 80,
              onRefresh: _refreshBets,
              child: ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: p, vertical: 5),
                      child: Match(
                          matchid: null,
                          sport: games[index]['sport'],
                          gender: games[index]['gender'] == 'f'
                              ? "(Girls)"
                              : (games[index]['gender'] == 'm' ? "(Boys)" : ""),
                          date: games[index]['date'] as Timestamp,
                          team1: games[index]['college1'],
                          team2: games[index]['college2'],
                          bet: games[index]['betAmount'],
                          w: w - 2 * p,
                          size: 0.38,
                          status: (games[index]['status']) == "InProgress"
                              ? ((games[index]['date'] as Timestamp)
                                          .millisecondsSinceEpoch >
                                      Database.now.millisecondsSinceEpoch
                                  ? "Upcoming"
                                  : "Ongoing")
                              : "Completed",
                          canbet: false,
                          isbet: true,
                          updateHome: null,
                          won: games[index]['status'] == "InProgress"
                              ? null
                              : games[index]['status']),
                    );
                  }),
            ),
          );
        });
  }
}
