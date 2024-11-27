import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget myAppBar(
    BuildContext context, String title, Function toggleCollapsed) {
  return AppBar(
    leading: IconButton(
        icon: SvgPicture.asset('assets/images/menu.svg'),
        onPressed: () {
          toggleCollapsed();
        }),
    flexibleSpace: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          color: Colors.black.withOpacity(0.4),
        ),
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      title,
      style: GoogleFonts.lalezar(
          fontWeight: FontWeight.w400, color: Colors.white, fontSize: 32),
    ),
  );
}
