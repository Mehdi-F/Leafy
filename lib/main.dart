import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leafy/screens/home_screen.dart';
import 'package:leafy/screens/registration_screen.dart';
import 'package:leafy/screens/starting_screen.dart';
import 'package:leafy/providers/auth_provider.dart';
import 'package:leafy/providers/user_provider.dart';
import 'package:leafy/utils/palette_blue.dart';
import 'package:leafy/utils/palette_orange.dart';
import 'package:provider/provider.dart';

import 'config/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthWrapper(),
          routes: {
            '/home':(context) => HomeScreen(),
            '/register':(context) => RegistrationScreen(),
          },
          theme: ThemeData(
              primarySwatch: PaletteOrange.orangeToDark,
              iconTheme: const IconThemeData(color: PaletteBlue.blueToDark)
          ),

        ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomeScreen();
    }
    return const StartingScreen();
  }
}



