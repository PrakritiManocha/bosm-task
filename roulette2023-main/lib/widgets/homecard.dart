import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homecard extends StatelessWidget {
  const Homecard({Key? key, required this.name, required this.bal})
      : super(key: key);
  final String name;
  final num bal;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: const Color(0xFF474747),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 130 / 800,
          width: MediaQuery.of(context).size.width * 205 / 361,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: w * 0.1,
                        height: h * 0.02,
                        child: Image.asset('assets/images/Wallet.png'),
                      ),
                      Text(
                        "Wallet Balance : ",
                        style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    bal.toStringAsFixed(2),
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
