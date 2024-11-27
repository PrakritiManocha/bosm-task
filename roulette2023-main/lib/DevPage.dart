import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roulette2023/listcard.dart';

class DevPage extends StatefulWidget {
  const DevPage({super.key});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  List<String> appdName = [
    'Sparsh Goenka',
    'Sayan Banerjee',
    'Jaiditya Singh',
    'Chayan Bhansali',
    'Shubhang Gautam',
    'Akshay Shukla',
    'Shreya Kar',
    'Satvik Beli',
    'Siddharth Khemani',
    'Udbhav Dwivedi'
  ];
  List<String> appdGit = [
    'https://github.com/sparshg',
    'https://github.com/SayanBanerjee09082002',
    'https://github.com/Lanner1321',
    'https://github.com/ChayanBhansali',
    'https://github.com/gautamshubhang',
    'https://github.com/Akshay1032',
    'https://www.youtube.com/watch?v=xvFZjo5PgG0',
    'https://github.com/MikeyyLite',
    'https://github.com/Shadow2073',
    'https://github.com/darknest2312'
  ];
  List<String> appdLin = [
    'https://www.linkedin.com/in/sparshgoenka',
    'https://www.linkedin.com/in/sayan-banerjee-90274922a/',
    'https://www.linkedin.com/in/jaiditya-singh',
    'https://www.linkedin.com/in/chayan-bhansali-0501b6234',
    'https://www.linkedin.com/in/shubhang-gautam-821b09251/',
    'https://www.linkedin.com/in/akshay-shukla-5a589b256/',
    'https://www.youtube.com/watch?v=xvFZjo5PgG0',
    'https://www.linkedin.com/in/satvik-beli-48b000256/',
    'https://www.linkedin.com/in/siddharth-khemani-028588174',
    'https://www.linkedin.com/in/udbhav-dwivedi-23088a250'
  ];

  List<String> desName = [
    'Tushar Saini',
    'Gaurav Aggarwal',
    'Yash Jain',
    'Rohit Nagpal',
    'Devansh Bansal',
  ];
  List<String> desGit = [
    'https://github.com/TusharSaini17',
    'https://github.com/Bittu25',
    '',
    '',
    '',
  ];

  List<String> desLin = [
    'https://www.linkedin.com/in/tushar-saini2004/',
    'https://www.linkedin.com/in/gaurav-aggarwal-bb38081ba',
    'https://www.linkedin.com/in/yash-jain-0a106b260',
    'https://www.linkedin.com/in/rohit-nagpal-9a1506250/',
    'https://www.linkedin.com/in/devansh-bansal-82b729250',
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Developers",
            style: GoogleFonts.lalezar(
                fontWeight: FontWeight.w400, color: Colors.white, fontSize: 32),
          ),
          centerTitle: true,
          bottom: TabBar(indicatorColor: Colors.purple, tabs: [
            Tab(text: null, icon: SvgPicture.asset("assets/images/text.svg")),
            Tab(text: null, icon: SvgPicture.asset("assets/images/UX.svg")),
          ]),
          leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.menu)),
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: TabBarView(children: [
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: appdName.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, left: 16, right: 16),
                        child: DevCard(
                          name: appdName[index],
                          role: "App Developer",
                          git: appdGit[index],
                          linkedin: appdLin[index],
                        ),
                      )),
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: desName.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, left: 16, right: 16),
                        child: DevCard(
                          name: desName[index],
                          role: "Designer",
                          git: desGit[index],
                          linkedin: desLin[index],
                        ),
                      )),
            ])),
      ),
    );
  }
}
