// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // void upload() async {
  //   final storageImage = await FirebaseStorage.instance
  //       .ref()
  //       .child('public_images')
  //       .child('pic0.jpg')
  //       .getDownloadURL();
  // Object quote = Quote(
  //     content: ["This is the first online quote"],
  //     author: "Itua Iregbeyanose",
  //     image: storageImage);
  // var loc = FirebaseDatabase.instance.ref("Quotes");
  // loc = loc.push();
  // loc.set({
  //   "content": [
  //     "The sky is the starting point",
  //     {"Matt 5:16": "The link"},
  //     "I am just starting with them"
  //   ],
  //   "author": "Itua Iregbeyanose",
  //   "image": storageImage,
  //   "isFavorite": false,
  //   "notes": []
  // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                  minRadius: 90,
                  maxRadius: 120,
                  child: Image.asset("assets/images/splash.png")),
              const TextField(),
              Row(
                children: [
                  const Expanded(child: TextField()),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye_rounded)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return const HomeScreen();
                    }),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child:
                    Text("Login", style: GoogleFonts.montserrat(fontSize: 25)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
