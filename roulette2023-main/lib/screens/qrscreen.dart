import 'dart:ui';
import '../utils/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pointsController.dispose();
    super.dispose();
  }

  @override
  TextEditingController pointsController = TextEditingController(text: '');
  String currentPoints = '0';
  // String encryptedText(String plaintext) {
  //final key = encryptor.Key.fromUtf8(key32);
  //final iv = encryptor.IV.fromUtf8(iv2);
  //final encrypter =encryptor.Encrypter(encryptor.AES(key, mode: encryptor.AESMode.ecb));

  // final encrypted = encrypter.encrypt(plaintext, iv: iv);
  // final decrypted = encrypter.decrypt(encrypted, iv: iv);
  // return encrypted.base64;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: [
        Image.asset(
          'assets/images/background.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
          child: Center(
            child: ClipRRect(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.9,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xff474747).withOpacity(0.7)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scan my QR',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w800),
                    ),
                    const Spacer(flex: 2),
                    Text(
                      'Wallet Balance: ${Database.currentUser.wallet.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                    Text(
                      'Points Redeemed: 5',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.045),
                    ),
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    const Spacer(flex: 8),
                    TextFormField(
                      // maxLength: 4,
                      // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: pointsController,
                      onChanged: (value) => setState(() {
                        if ((int.tryParse(value) ?? 0) >
                            Database.currentUser.wallet) {
                          currentPoints =
                              Database.currentUser.wallet.floor().toString();
                          pointsController.text = currentPoints;
                          pointsController.selection = TextSelection.collapsed(
                              offset: pointsController.text.length);
                        } else {
                          currentPoints = value;
                        }
                      }),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          helperStyle: const TextStyle(color: Colors.white),
                          hintText: 'Redeem points',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            ),
                          )),
                    ),
                    const Spacer(flex: 4)
                  ],
                ),
              ),
            )),
          ),
        ),
      ]),
    );
  }
}
