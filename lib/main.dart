import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idea/firebase_options.dart';
// import 'package:idea/screens/home_screen.dart';
import 'package:idea/screens/login_screen.dart';

ThemeData lightTheme = ThemeData.light(
  useMaterial3: true,
).copyWith(
  appBarTheme: const AppBarTheme()
      .copyWith(backgroundColor: const Color.fromRGBO(211, 210, 231, 1)),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate();
  FirebaseFirestore.setLoggingEnabled(false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "iQuote app",
        home: const LoginScreen(),
        theme: lightTheme,
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: const Color.fromARGB(255, 54, 69, 79),
          ),
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}

// notes show as dialog box
// more button should contain my profile and settings(google account)
// for images, use 480x320
// increase size of container for image display and consider removing sliding containers at the top
// use system font for flutter app.
// verify message button bg color
// try to check connection before loading picture and store picture locally for sometime

