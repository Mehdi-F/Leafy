import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/starting_screen.dart';


class AuthProvider  with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  User? get user => _user;
  bool get isAuthenticated => _user != null;

  // Check the current user when the app starts
 /* Future<User?> getCurrentUser() async{
    final user = _auth.currentUser;
    _user = user;
    notifyListeners();
    return user;
  }*/
  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // get profile picture
  Future<String> getCurrentUserPhotoUrl() async {
    final User? user = _auth.currentUser;
    final String? photoUrl = user?.photoURL;
    if (photoUrl != null) {
      return photoUrl;
    } else {
      return '';
    }
  }

  // Sign up with email and password
  Future<bool> signUpWithEmail(BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null){
        return false;
      }
      _user = user;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      } else {
        throw ('Something went wrong. Please try again later.');
      }
    }  catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign up. Please try again later.'),
        ),
      );
      return false;
    }
  }

  //Sign in with Email and password
  Future<bool> signInWithEmail(BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if( user == null){
        return false;
      }
      _user = user;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw ('Invalid email or password');
      } else {
        throw ('Something went wrong. Please try again later.');
      }
    }  catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in. Please try again later.'),
        ),
      );
      return false;
    }
  }

  // Sign in with Google
  Future<bool> signInWithGoogle(BuildContext context) async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null ){
        return false;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        return false;
      }
      _user = user;
      notifyListeners();
      return true;
    } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign in with Google'),
          ),
        );
        return false;
      }
  }
  // Sign out
  void signOut(BuildContext context) async {
    await _user!.updatePhotoURL('');
    await _auth.signOut();
    _user = null;
    notifyListeners();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StartingScreen()),
    );
  }

  // Delete account
  Future<bool> deleteAccount(BuildContext context) async {
    try{
      if (_user == null) {
        return false;
      }
      await _user!.updatePhotoURL('');
      await _user!.delete();
      _user = null;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your account has been deleted.'),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartingScreen()),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please reauthenticate to delete your account.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong. Please try again later.')),
        );
      }
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong. Please try again later.')),
      );
      return false;
    }
  }

  // Handle Delete Account method to use when deleting account with a button ( keep for later)
  /*Future<void> _handleDeleteAccount(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.deleteAccount(context);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Your account has been deleted.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete your account.')),
      );
    }
  }*/

  // Email Validator
  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required.';
    }
    if (!EmailValidator.validate(email)) {
      return 'Invalid email format.';
    }
    return null;
  }

  // Password validator
  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password.';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special character.';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter.';
    }
    return null;
  }

}
