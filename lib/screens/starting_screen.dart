import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leafy/utils/palette_orange.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/palette_blue.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  // Colors
  final Color bgColor = Color(0xfff1f1f1);
  final Color greyText = Color(0xffA1A1A1);

  // Keys
  final _formKey = GlobalKey<FormState>();

  // Editing Controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Initially password is obscure
  bool _passwordVisible = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    //email field
    final emailField = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        autofocus: false,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validator: authProvider.emailValidator,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: PaletteOrange.orangeToDark),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

    //password field
    final passwordField = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _passwordVisible,
        validator: authProvider.passwordValidator,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ?  Icons.visibility_off: Icons.visibility,
              color: PaletteBlue.blueToDark,
            ),
            onPressed: (){
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

    // Login Button
    final loginButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: PaletteBlue.blueToDark,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minimumSize:  Size(MediaQuery.of(context).size.width,20),
          alignment: Alignment.center,
        ),
        onPressed: (){
          _submit(context);
        },
        child: const Text(
          "Login",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final googleButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      color: PaletteBlue.blueToDark,
      child: TextButton(
        onPressed: (){
          authProvider.signInWithGoogle(context).then((success){
            if(success){
              Navigator.pushNamed(context, '/main');
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Failed to sign in with Google. Please try again.')));
            }
          });
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          minimumSize: Size(MediaQuery.of(context).size.width, 30),
          alignment: Alignment.center,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FontAwesomeIcons.google),
            SizedBox(width: 10),
            Text('Sign in with Google',
                style: TextStyle(color: Colors.white, fontSize: 18)
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.asset("assets/Full_Logo.png",
                    width: 300,
                    ),
                  ),
                  SizedBox(height: 35),
                  Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          emailField,
                          SizedBox(height:25),
                          passwordField,
                          SizedBox(height:25),
                        ],
                      )
                  ),
                  //Expanded(child:registerButton),
                  SizedBox(width:20),
                  loginButton,
                  SizedBox(height:25),
                  Row(
                    children: <Widget>[
                      Expanded(child:
                        Divider(color: greyText),
                      ),
                      SizedBox(width:20),
                      Text("Or",
                      style: TextStyle(
                        color: greyText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width:20),
                      Expanded(child:
                        Divider(color: greyText),
                      ),
                    ],
                   ),
                  SizedBox(height:25),
                  googleButton,
                  SizedBox(height:25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget> [
                      const Text('Not a member ? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          'Join now',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: PaletteBlue.blueToDark,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
  void _submit(BuildContext context) async{
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if(_formKey.currentState!.validate()){
        final success = await authProvider.signInWithEmail(context, _emailController.text, _passwordController.text);
        if(success){
          Navigator.pushNamed(context, '/main');
        }else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
              Text('Failed to sign in. Please check your email and password.')));
        }
    }
  }
}

