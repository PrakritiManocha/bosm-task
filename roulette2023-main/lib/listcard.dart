import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DevCard extends StatelessWidget {
  const DevCard(
      {Key? key,
      required this.name,
      required this.role,
      required this.git,
      required this.linkedin})
      : super(key: key);
  final String name;
  final String role;
  final String git;
  final String linkedin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                color: const Color(0xff2c3028),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(name,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      Text(role,
                          style: GoogleFonts.inter(
                              color: Colors.grey, fontSize: 15))
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        Uri url = Uri.parse(git);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      icon: SvgPicture.asset("assets/images/giticon.svg")),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    width: MediaQuery.sizeOf(context).width * 0.007,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0XFFbb57f3), Color(0XFF6756c2)])),
                  ),
                  IconButton(
                      onPressed: () async {
                        Uri url = Uri.parse(linkedin);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      icon: SvgPicture.asset("assets/images/Union.svg")),
                ],
              ),
            )),
      ],
    );
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {}
}
