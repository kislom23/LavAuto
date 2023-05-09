import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavauto/firebase_options.dart';
import 'package:lavauto/screens/home_page.dart';
import 'modules/auth/authentification.dart';
import 'modules/client/details_page.dart';
import 'modules/client/profile_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vakloe',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.orange,
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const Authentification(),
        '/details': (context) => const DetailsPage(),
        '/profile': (context) => const ProfilePage(),
      },
      home: const Authentification(),
    );
  }
}
