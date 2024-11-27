import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:roulette2023/screens/wheelspin.dart';
import 'package:roulette2023/utils/database.dart';
import 'package:roulette2023/widgets/homecard.dart';
import 'package:roulette2023/common/tile.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController tabController;
  var index = 0;
  late Stream<QuerySnapshot<Object?>> matchStream;

  @override
  void initState() {
    super.initState();
    matchStream = Database.retrieveMatches();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double p = 10;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int endTime =
        Database.currentUser.slotTime.millisecondsSinceEpoch + 1000 * 7200;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (endTime <= Database.now.millisecondsSinceEpoch) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SpinWheel(updateHome: () => setState(() {})),
              ),
            );
          }
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: CountdownTimer(
            endTime: endTime,
            widgetBuilder: (_, time) {
              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: const AssetImage('assets/spin.png'),
                      fit: BoxFit.fill,
                      colorFilter: time == null
                          ? null
                          : ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.darken),
                    ),
                  ),
                  child: Center(
                    child: Text(
                        time == null
                            ? ''
                            : '${time.hours ?? 0}:${time.min ?? 0}:${time.sec ?? 0}',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700)),
                  ));
            },
          ),
        ),
        // backgroundColor: Colors.grey.shade900,
      ),
      body: Container(
        width: w,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background.png'))),
        child: Column(children: [
          SizedBox(height: h * 0.1),
          Homecard(
              name: Database.currentUser.name,
              bal: Database.currentUser.wallet),
          TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text('Ongoing',
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
              ),
              Tab(
                child: Text('Upcoming',
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
              ),
            ],
            labelColor: Colors.white,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: matchStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List docs = snapshot.data!.docs
                    .where((e) =>
                        e['status'] == 'InProgress' &&
                        (e['date'] as Timestamp).millisecondsSinceEpoch <=
                            Database.now.millisecondsSinceEpoch)
                    .toList();
                docs.sort((a, b) => (b['date'] as Timestamp).compareTo(
                      a['date'] as Timestamp,
                    ));
                //print server time
                // print(FieldValue.serverTimestamp());

                List docs2 = snapshot.data!.docs
                    .where((e) =>
                        e['status'] == 'InProgress' &&
                        (e['date'] as Timestamp).millisecondsSinceEpoch >
                            Database.now.millisecondsSinceEpoch)
                    .toList();
                docs2.sort((a, b) => (a['date'] as Timestamp).compareTo(
                      b['date'] as Timestamp,
                    ));

                return Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: p, vertical: 5),
                            child: Match(
                                matchid: docs[index].id,
                                sport: docs[index]['sport'],
                                gender: docs[index]['gender'] == 'f'
                                    ? "(Girls)"
                                    : (docs[index]['gender'] == 'm'
                                        ? "(Boys)"
                                        : ""),
                                date: docs[index]['date'] as Timestamp,
                                team1: docs[index]['college1'],
                                team2: docs[index]['college2'],
                                bet: 200,
                                w: w - 2 * p,
                                size: 0.38,
                                status: 'Ongoing',
                                canbet: false,
                                isbet: false,
                                updateHome: null,
                                won: null),
                          );
                        },
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      ),
                      ListView.builder(
                        itemCount: docs2.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: p, vertical: 5),
                            child: Match(
                                matchid: docs2[index].id,
                                sport: docs2[index]['sport'],
                                gender: docs2[index]['gender'] == 'f'
                                    ? "(Girls)"
                                    : (docs2[index]['gender'] == 'm'
                                        ? "(Boys)"
                                        : ""),
                                date: docs2[index]['date'] as Timestamp,
                                team1: docs2[index]['college1'],
                                team2: docs2[index]['college2'],
                                bet: 200,
                                w: w - 2 * p,
                                size: 0.38,
                                status: 'Upcoming',
                                canbet: true,
                                isbet: false,
                                updateHome: () => setState(() {}),
                                won: null),
                          );
                        },
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      ),
                    ],
                  ),
                );
              }),
        ]),
      ),
    );
  }
}
