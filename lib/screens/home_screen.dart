import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leafy/utils/palette_blue.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    final currentUser = FirebaseAuth.instance.currentUser;
    final name = currentUser?.displayName ?? 'Anonymous';

    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: PaletteBlue.blueToDark,
        body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Welcome to the App, $name',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text.rich(
                        TextSpan(
                          text: 'To get started, tap the ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: Icon(Icons.camera_alt),
                            ),
                            TextSpan(
                              text: ' icon to take a photo or ',
                            ),
                            WidgetSpan(
                              child: Icon(Icons.image),
                            ),
                            TextSpan(
                              text: ' icon to choose a file from your gallery.',
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}

