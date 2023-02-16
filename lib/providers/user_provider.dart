import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProvider extends ChangeNotifier {
  String? _profilePictureUrl;

  String get profilePictureUrl => _profilePictureUrl ?? '';

  String get userName => FirebaseAuth.instance.currentUser?.displayName ?? '';

  Future<void> changePassword(String password) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User is not logged in!');
    }

    await user.updatePassword(password);
  }

  /*Future<void> changeProfilePicture(String filePath) async {
    final storageRef = FirebaseStorage.instance.ref().child('profile_pictures/${FirebaseAuth.instance.currentUser!.uid}');
    final file = await Future.value(filePath).then((path) => path != null ? File(path) : null);

    if (file != null) {
      final storageResult = await storageRef.putFile(file);
      final imageUrl = await storageResult.ref.getDownloadURL();
      _profilePictureUrl = imageUrl;
      notifyListeners();
    } else {
      throw Exception('No file selected');
    }
  }*/

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _profilePictureUrl = null;
    notifyListeners();
  }

  Future<void> deleteAccount(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User is not logged in!');
    }

    try {
      await user.delete();
      await signOut();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Account deleted successfully!'),
      ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? 'An error occurred!'),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred!'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
