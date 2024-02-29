import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AttachmentType { song, bibleVerse }

class Attachment extends StatelessWidget {
  const Attachment(
      {super.key,
      required this.displayText,
      required this.url,
      required this.type});

  final String displayText;
  final String url;
  final AttachmentType type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: Color.fromRGBO(158, 158, 158, 0.719),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          displayText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.spMin, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
