import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/showSnackBar.dart';

class FirebaseAuthMethods{
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // GET USER DATA
  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  // Email Sign Up
  Future<void>signUpWithEmail({required String email, required String password, required BuildContext context,})async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await sendEmailVerification(context);
    }
    on FirebaseAuthException catch (e) {
      showSnackBar(context, "Something is off, please verify your parameters!"); // Displaying the usual firebase error message
    }
  }

  // Email login
  Future<void>loginWithEmail({required String email, required String password, required BuildContext context,})async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(!user.emailVerified){
        await sendEmailVerification(context);
      }
    }
    on FirebaseAuthException catch(e){
      showSnackBar(context,e.message!);
    }
  }

  // Email verification
  Future<void>sendEmailVerification(BuildContext context) async {
    try{
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent');
    }on FirebaseAuthException catch(e){
      showSnackBar(context, e.message!);
    }
  }

  // Google Sign in
  Future<void>signInWithGoogle(BuildContext context)async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if(googleAuth?.accessToken != null && googleAuth?.idToken != null){
        /// Create new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        /*if(userCredential.user !=null){
          if(userCredential.additionalUserInfo!.isNewUser){
          }
        }*/
      }
    }
    on FirebaseAuthException catch(e){
      showSnackBar(context,e.message!);
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

// DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}