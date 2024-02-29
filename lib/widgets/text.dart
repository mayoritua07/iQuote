import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  const MyText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
          // color: Colors.white,
          fontSize: 40.spMin,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic),
    );
  }
}
