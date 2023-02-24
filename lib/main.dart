import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leafy/providers/disease_provider.dart';
import 'package:leafy/screens/home_screen.dart';
import 'package:leafy/screens/main_screen.dart';
import 'package:leafy/screens/registration_screen.dart';
import 'package:leafy/screens/results_screen.dart';
import 'package:leafy/screens/starting_screen.dart';
import 'package:leafy/providers/auth_provider.dart';
import 'package:leafy/providers/user_provider.dart';
import 'package:leafy/utils/palette_blue.dart';
import 'package:leafy/utils/palette_orange.dart';
import 'package:provider/provider.dart';

import 'config/firebase_options.dart';
import 'models/disease_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DiseaseAdapter());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await Hive.openBox<Disease>('plant_diseases');
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
        ChangeNotifierProvider<DiseaseProvider>(create: (_) => DiseaseProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthWrapper(),
          routes: {
            '/home':(context) => HomeScreen(),
            '/main':(context) => MainScreen(),
            '/register':(context) => RegistrationScreen(),
            '/results':(context) => ResultsScreen(),
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
      return const MainScreen();
    }
    return const StartingScreen();
  }
}



