import 'package:firebase_auth/firebase_auth.dart';
import 'package:leafy/providers/user_provider.dart';
import 'package:leafy/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/palette_blue.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final userProvider = context.watch<UserProvider>();
    final authProvider = context.watch<AuthProvider>();

    final currentUser = FirebaseAuth.instance.currentUser;
    final name = currentUser?.displayName ?? 'Anonymous';
    final photoUrl = currentUser?.photoURL ?? '';

  // Sign out Button
    final signOutButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextButton(
        onPressed: ()=> authProvider.signOut(context),
        style: TextButton.styleFrom(
          foregroundColor: PaletteBlue.blueToDark,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minimumSize:  Size(MediaQuery.of(context).size.width,30),
          alignment: Alignment.center,
        ),
        child: const Text(
          "Sign out",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );

    // Delete account Button
    final deleteButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextButton(
        onPressed: ()=> authProvider.deleteAccount(context),
        style: TextButton.styleFrom(
          foregroundColor: PaletteBlue.blueToDark,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minimumSize:  Size(MediaQuery.of(context).size.width,30),
          alignment: Alignment.center,
        ),
        child: const Text(
          "Delete account",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: PaletteBlue.blueToDark,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.white,
                  backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                  child: photoUrl.isEmpty
                      ? Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '',
                    style: TextStyle(fontSize: 40.0),
                  )
                      : null,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome, $name',
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 30),
                signOutButton,
                SizedBox(height: 20),
                deleteButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
