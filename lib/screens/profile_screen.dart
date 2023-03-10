import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/palette_blue.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  File? _image;

  final picker = ImagePicker();

  void _onChangePicture(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();

    // Pick an image from the device's gallery
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload the image to Firebase Storage and get the URL of the uploaded image
      final photoUrl = await authProvider.uploadProfilePicture(File(pickedFile.path));

      if (photoUrl != null) {
        // Update the user's photo URL in the Firebase Authentication database
        await authProvider.user!.updatePhotoURL(photoUrl);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to change profile picture.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

    // Change picture Button
    final changePictureButton = Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () => _onChangePicture(context),
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
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                      child: photoUrl.isEmpty
                          ? Text(
                        name.isNotEmpty ? name[0].toUpperCase() : '',
                        style: TextStyle(fontSize: 40.0, color: PaletteBlue.blueToDark),
                      ) : null,
                    ),
                    changePictureButton,
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(fontSize: 18, color: Colors.white),
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