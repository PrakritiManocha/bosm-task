import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Rank extends StatelessWidget {
  const Rank(
      {Key? key,
      required this.Name,
      required this.Won,
      required this.Lost,
      required this.avatar,
      required this.rank,
      required this.Points})
      : super(key: key);
  final String Name;
  final int Won;
  final int Lost;
  final int rank;
  final String avatar;
  final int Points;

  @override
  Widget build(BuildContext context) {
    final sty = GoogleFonts.outfit(
        color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500);
    return Card(
        elevation: 0,
        color: const Color(0xff474747),
        child: ExpansionTile(
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          backgroundColor: const Color(0xff858585).withOpacity(0.45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Row(
            children: [
              Text("#$rank", style: sty),
              const SizedBox(width: 20),
              SvgPicture.asset(
                'assets/images/avatars/${int.parse(avatar) % 81}.svg',
                height: 50,
                width: 50,
              ),
              const SizedBox(width: 20),
              FittedBox(
                  child: Text(
                      (Name.length > 13) ? Name.substring(0, 13) + "..." : Name,
                      style: sty,
                      overflow: TextOverflow.ellipsis)),
              const Spacer(),
              Text(Points.toString(), style: sty)
            ],
          ),
          children: [
            Text("Matches Won :- ${Won}", style: sty),
            const SizedBox(height: 10),
            Text("Matches Lost:- ${Lost}", style: sty),
            const SizedBox(height: 10)
          ],
        ));

    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Container(
    //     decoration: BoxDecoration(
    //         color: Color(0xFF484444),
    //       border: Border(bottom: BorderSide(color: Colors.grey))
    //     ),
    //     width: MediaQuery.of(context).size.width,
    //     height:MediaQuery.of(context).size.height*0.1,
    //     child: ExpansionTile(
    //       title:Row(
    //         children: [
    //           CircleAvatar(radius: 30),
    //           SizedBox(width: 20),
    //           Text("$Name",style: GoogleFonts(fontFamily: 'Outfit', color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold))
    //         ],
    //       ),
    //       children: [
    //               Text("$Name",style: GoogleFonts(fontFamily: 'Outfit', color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),
    //               Text("$Name",style: GoogleFonts(fontFamily: 'Outfit', color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),
    //               Text("$Name",style: GoogleFonts(fontFamily: 'Outfit', color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold))
    //                 ],
    //     ),
    //
    //
    //   ),
    // );
  }
}
