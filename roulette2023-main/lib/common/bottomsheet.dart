import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roulette2023/utils/gradient_border.dart';

import '../utils/database.dart';

Future amount_btmsheet(
    BuildContext context,
    String matchid,
    String sport,
    String gender,
    String team1,
    String team2,
    bool selectedT1,
    void Function()? updateHome) {
  TextEditingController controller = TextEditingController(text: '100');
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
  return showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.6),
      elevation: 50,
      context: context,
      backgroundColor: const Color.fromARGB(255, 45, 45, 45).withOpacity(0.8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: SizedBox(
              height: h * 0.5,
              width: w,
              child: BottomColumn(controller: controller, matchid: matchid, sport: sport, gender: gender, team1: team1, team2: team2, selectedT1: selectedT1 ,updateHome: updateHome),
            ),
          ));
}

class BottomColumn extends StatefulWidget {
  final TextEditingController controller;
  final String matchid;
  final String sport;
  final String gender;
  final String team1;
  final String team2;
  final bool selectedT1;
  final void Function()? updateHome;
  const BottomColumn({
    super.key,
    required this.controller,
    required this.matchid,
    required this.sport,
    required this.gender,
    required this.team1,
    required this.team2,
    required this.selectedT1,
    required this.updateHome
  });



  @override
  State<BottomColumn> createState() => _BottomColumnState();
}

class _BottomColumnState extends State<BottomColumn> {
  int selectedindex = 0;



  @override
  Widget build(BuildContext context) {
    // int selectedindex = -1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 3,
            width: 50,
            color: const Color(0xff474747).withOpacity(0.75),
          ),
        ),
        const Spacer(flex: 1),
        // Text(
        //   "$team1   vs   $team2",
        //   style: GoogleFonts.lalezar(
        //       fontSize: 22,
        //       fontWeight: FontWeight.w500,
        //       color: Colors.white),
        // ),
        // const Spacer(flex: 1),
        Text("${widget.sport} ",
          style: GoogleFonts.lalezar(
              fontSize: 22,
              fontWeight: FontWeight.w300,
              color: Colors.white),
        ),
        const Spacer(flex: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             InkWell(
                  onTap: (){
                    setState(() {
                      selectedindex=0;
                    });
                  },
                  child: Container(
                    // margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    width: 150,
                    height: 55,
                    decoration:BoxDecoration(
                      color: selectedindex==0?Colors.purple:Colors.black26,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(child :Text("${widget.team1}",style: TextStyle(fontSize: 25,fontFamily: 'Lalezar',color: Colors.white)), fit: BoxFit.contain,),
                    )),
                  ),
                ),
            SizedBox(width: 40),
            InkWell(
              onTap: (){
                setState(() {
                  selectedindex=1;
                  // widget.selectedT1=fasl;
                });
              },
              child: Container(
                // margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                width: 150,
                height: 55,

                decoration:BoxDecoration(
                    color:  selectedindex==1?Colors.purple:Colors.black26,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(child :Text("${widget.team2}",style: TextStyle(fontSize: 25,fontFamily: 'Lalezar',color: Colors.white)), fit: BoxFit.contain,),
                )),
              ),
            )
          ],
        ),

        const Spacer(flex: 2),
        SizedBox(
            height: 42,
            child: Center(
                child: Text(
              "Select amount",
              style: GoogleFonts.lalezar(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ))),
        const Spacer(),
        Container(
          height: 61,
          width: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: const GradientBorder(
                borderGradient: LinearGradient(colors: [
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(51, 51, 51, 1)
                ]),
                width: 1,
              )),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    int amount = int.parse(widget.controller.text);
                    amount -= 100;
                    if (amount < 0) amount = 0;
                    widget.controller.text = amount.toString();
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(17, 17, 17, 0.4),
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                    width: 80,
                    child: TextField(
                      controller: widget.controller,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.top,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none),
                    )),
                GestureDetector(
                  onTap: () {
                    int amount = int.parse(widget.controller.text);
                    amount += 100;
                    widget.controller.text = amount.toString();
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(17, 17, 17, 0.4),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(flex: 2),
        SizedBox(
          width: 226,
          height: 44,
          child: Row(
            children: [
              GestureDetector(
                child: Container(
                    height: 44,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                      ],
                    )),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const Spacer(),
              GestureDetector(
                child: Container(
                    height: 44,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Confirm",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                      ],
                    )),
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return WillPopScope(
                        onWillPop: () => Future.value(false),
                        child: const SimpleDialog(
                          elevation: 0.0,
                          backgroundColor: Colors.transparent,
                          children: [
                            Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                  // print(FirebaseAuth.instance.currentUser);
                  Database.storeBetData(
                           widget.matchid,
                          int.parse(widget.controller.text),
                          selectedindex==0 ? widget.team1 : widget.team2)
                      .then((_) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    if (widget.updateHome != null) widget.updateHome!();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Bet Placed Successfully')));
                  }).catchError((e) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    if (widget.updateHome != null) widget.updateHome!();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Error: ${e.toString().replaceFirst("Exception: ", "")}')));
                  });
                  // Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
        const Spacer(flex: 4),
      ],
    );
  }
}
