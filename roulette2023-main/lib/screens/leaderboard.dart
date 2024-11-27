import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roulette2023/common/avatar.dart';
import 'package:roulette2023/widgets/listcard.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user.dart';
import '../utils/database.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/background.png')),
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: Database.getLeaderboardData(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              var data = snapshot.data!.docs
                  .map((doc) =>
                      UserData.fromJson(doc.data() as Map<String, dynamic>))
                  .toList();

              return LeaderboardContent(data: data);
            }));
  }
}

class LeaderboardContent extends StatefulWidget {
  const LeaderboardContent({
    super.key,
    required this.data,
  });

  final List<UserData> data;

  @override
  State<LeaderboardContent> createState() => _LeaderboardContentState();
}

class _LeaderboardContentState extends State<LeaderboardContent> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sty = GoogleFonts.outfit(
        color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500);
    final us = widget.data
        .toList()
        .indexWhere((element) => element.email == Database.currentUser.email);
    final data = (_controller.value.text.isNotEmpty)
        ? widget.data
            .where((user) => user.name
                .toLowerCase()
                .startsWith(_controller.value.text.toLowerCase()))
            .toList()
        : widget.data;
    print(data.toString());
    print(_controller.value.text);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: kToolbarHeight + 20.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            onChanged: (_) => setState(() {}),
            cursorColor: Colors.white,
            style: GoogleFonts.outfit(
                color: Colors.white, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0)),
              filled: true,
              fillColor: const Color(0xff474747).withOpacity(0.7),
              contentPadding: const EdgeInsets.all(8.0),
              hintText: "Search",
              hintStyle: GoogleFonts.outfit(
                  color: Colors.white, fontWeight: FontWeight.w400),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BotAvatar(
                radius: 50,
                name: widget.data[0].name.split(' ')[0],
                avatar: widget.data[0].avatar,
                points: widget.data[0].score),
            if (widget.data.length > 1)
              BotAvatar(
                  radius: 40,
                  name: widget.data[1].name.split(' ')[0],
                  avatar: widget.data[1].avatar,
                  points: widget.data[1].score),
            if (widget.data.length > 2)
              BotAvatar(
                  radius: 30,
                  name: widget.data[2].name.split(' ')[0],
                  avatar: widget.data[2].avatar,
                  points: widget.data[2].score),
          ],
        ),
        const SizedBox(height: 15),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFF474747),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: max(0, data.length),
                      itemBuilder: (context, index) {
                        return Rank(
                            Name: data[index].name,
                            Won: data[index].won,
                            Lost: data[index].lost,
                            rank: index + 1,
                            avatar: data[index].avatar,
                            Points: data[index].score);
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: const LinearGradient(
                              colors: [Color(0xFFA550D7), Color(0xFF6256BF)])),
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        title: Row(
                          children: [
                            Text("#${us + 1}", style: sty),
                            const SizedBox(width: 20),
                            SvgPicture.asset(
                              'assets/images/avatars/${int.parse(Database.currentUser.avatar) % 81}.svg',
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(width: 20),
                            Text("You", style: sty),
                            const Spacer(),
                            Text(Database.currentUser.score.toString(),
                                style: sty)
                          ],
                        ),
                        children: [
                          Text("Matches Won :- ${Database.currentUser.won}",
                              style: sty),
                          const SizedBox(height: 10),
                          Text("Matches Lost:- ${Database.currentUser.lost}",
                              style: sty),
                          const SizedBox(height: 10)
                        ],
                      ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
