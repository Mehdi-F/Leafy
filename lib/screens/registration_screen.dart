import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leafy/utils/palette_orange.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/palette_blue.dart';
import '../utils/password_requirement.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget{
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>{
  // Form Key
  final _formKey = GlobalKey<FormState>();

  //Editing Controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  // Password visibility/validation
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasPasswordLowercase = false;
  bool _hasPasswordUppercase = false;
  bool _hasPasswordSpecial = false;
  bool _validPassword = false;
  bool _validEmail = false;
  bool _validMatch = false;
  bool _passwordMatch = false;
  String _confirmPassword = '';

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final lowerRegex = RegExp(r'[a-z]');
    final upperRegex = RegExp(r'[A-Z]');
    final specialRegex = RegExp(r'[!@#\$&*~_-]');
    setState(() {
      _isPasswordEightCharacters = false;
      if(password.length >= 8)
        _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if(numericRegex.hasMatch(password))
        _hasPasswordOneNumber = true;

      _hasPasswordLowercase = false;
      if(lowerRegex.hasMatch(password))
        _hasPasswordLowercase = true;

      _hasPasswordUppercase = false;
      if(upperRegex.hasMatch(password))
        _hasPasswordUppercase = true;

      _hasPasswordSpecial = false;
      if(specialRegex.hasMatch(password))
        _hasPasswordSpecial = true;

      if (_isPasswordEightCharacters &&_hasPasswordOneNumber&&_hasPasswordLowercase&&
          _hasPasswordUppercase&&_hasPasswordSpecial)
        _validPassword =true;
    });
    _updatePasswordMatch();
  }
  onEmailChanged(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    setState(() {
      _validEmail = emailRegex.hasMatch(email);
    });
    _updatePasswordMatch();
  }
  onConfirmPasswordChanged(String password) {
    setState(() {
      _confirmPassword = password;
      _passwordMatch = _confirmPasswordController.text == _passwordController.text;
    });
    _updatePasswordMatch();
  }

  _updatePasswordMatch() {
    setState(() {
      _passwordMatch = _confirmPasswordController.text == _passwordController.text;
    });
  }


  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);

    //email field
    final emailField = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        autofocus: false,
        controller: _emailController,
        onChanged: (email) => onEmailChanged(email),
        keyboardType: TextInputType.emailAddress,
        validator:authProvider.emailValidator,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
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
        obscureText: !_passwordVisible,
        onChanged: (password) => onPasswordChanged(password),
        validator:authProvider.passwordValidator,
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
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PaletteOrange.orangeToDark, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
    final confirmPasswordField = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: !_confirmPasswordVisible,
        validator:(value) {
          if (value!.isEmpty) {
            return 'Please confirm your password';
          }
          if (!_passwordMatch) {
            return 'Passwords do not match';
          }
          return null;
        },
        onChanged: (confirmPassword) => onConfirmPasswordChanged(confirmPassword),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _confirmPasswordVisible ?  Icons.visibility_off: Icons.visibility,
              color: PaletteBlue.blueToDark,
            ),
            onPressed: (){
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _confirmPasswordVisible = !_confirmPasswordVisible;
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
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PaletteOrange.orangeToDark, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

    // Register Button
    final registerButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: PaletteBlue.blueToDark,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minimumSize:  Size(MediaQuery.of(context).size.width,30),
          alignment: Alignment.center,
        ),
        onPressed: () async {
          _register(context);
        },
        child: const Text(
          "Register",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: PaletteBlue.blueToDark,
      appBar: AppBar(
        title: Text("Register",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,color: Colors.white),
        ),
        backgroundColor: PaletteBlue.blueToDark.shade200,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset("assets/userIcon.png",
                        width: 150,
                      ),
                    ),
                    const SizedBox(height:35),
                    emailField,
                    const SizedBox(height:20),
                    PasswordRequirementWidget(
                      hasRequirement: _validEmail,
                      text: 'Valid email format',
                    ),
                    const SizedBox(height:25),
                    passwordField,
                    const SizedBox(height:20),
                    PasswordRequirementWidget(
                      hasRequirement: _isPasswordEightCharacters,
                      text: 'Contains at least 8 characters',
                    ),
                    SizedBox(height: 10,),
                    PasswordRequirementWidget(
                      hasRequirement: _hasPasswordOneNumber,
                      text: 'Contains at least 1 number',
                    ),
                    SizedBox(height: 10,),
                    PasswordRequirementWidget(
                      hasRequirement: _hasPasswordLowercase,
                      text: 'Contains at least 1 lowercase letter',
                    ),
                    SizedBox(height: 10,),
                    PasswordRequirementWidget(
                      hasRequirement: _hasPasswordUppercase,
                      text: 'Contains at least 1 uppercase letter',
                    ),
                    SizedBox(height: 10,),
                    PasswordRequirementWidget(
                      hasRequirement: _hasPasswordSpecial,
                      text: 'Contains at least 1 special character',
                    ),
                    const SizedBox(height:25),
                    confirmPasswordField,
                    const SizedBox(height:20),
                    PasswordRequirementWidget(
                      hasRequirement: _passwordMatch,
                      text: 'Confirmation must match password',
                    ),
                    const SizedBox(height:30),
                    registerButton,
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
  _register(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState!.validate() && _validPassword && _validEmail && _passwordMatch) {
      // If the form is valid and the password and confirmation password match,
      // create the user with the email and password.
      final result = await authProvider.signUpWithEmail(context, _emailController.text, _passwordController.text);
      if (result) {
        // If the registration was successful, navigate to the home screen.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // If the registration failed, show an error message.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed. Please try again.'),
          ),
        );
      }
    }
  }

}

