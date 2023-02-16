import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leafy/utils/palette_orange.dart';

import '../services/firebase_auth.dart';
import '../utils/palette_blue.dart';
import '../utils/showSnackBar.dart';

class RegistrationScreen extends StatefulWidget{
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>{
  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Password visibility/validation
  bool _passwordVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasPasswordLowercase = false;
  bool _hasPasswordUppercase = false;
  bool _hasPasswordSpecial = false;
  bool _validPassword = false;

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

      if (_isPasswordEightCharacters &&_hasPasswordOneNumber&&_hasPasswordLowercase&&_hasPasswordUppercase&&_hasPasswordSpecial)
        _validPassword =true;
    });
  }


  //Editing Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Text Fields
  String email = '';
  String password ='';
  String error = '';

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void signUpUser() async{
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context
    );
  }

  @override
  Widget build(BuildContext context){

    //email field
    final emailField = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        onChanged: (val){
          setState(() => email = val);
        },
        validator:(value){
          if(value!.isEmpty){
            return ("Email required");
          }
          if(!EmailValidator.validate(value, true)){
            return ("Email is invalid");
          }
        },
        onSaved: (value)
        {
          emailController.text = value!;
        },
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
            errorStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )
        ),
      ),
    );

    //password field
    final passwordField = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: passwordController,
        obscureText: !_passwordVisible,
        onChanged: (password) => onPasswordChanged(password),
        validator:(value){
          if(value!.isEmpty){
            return ("Password required");
          }
          if(!_validPassword){
            return ("Please verify all criteria");
          }
        },
        onSaved: (value)
        {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            icon: _passwordVisible ? Icon(Icons.visibility, color: PaletteBlue.blueToDark,) :
            Icon(Icons.visibility_off, color: PaletteBlue.blueToDark,),
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
          errorStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          )
        ),
      ),
    );

    // Register Button
    final registerButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            //showSnackBar(context,_formKey.currentState!.validate().toString());
            signUpUser();
          }else{
            showSnackBar(context, "Something is off");
          }
        },
        style: TextButton.styleFrom(
          foregroundColor: PaletteBlue.blueToDark,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minimumSize:  Size(MediaQuery.of(context).size.width,30),
          alignment: Alignment.center,
        ),
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
                    const SizedBox(height:25),
                    passwordField,
                    const SizedBox(height:25),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _isPasswordEightCharacters ?  Colors.green : Colors.transparent,
                              border: _isPasswordEightCharacters ? Border.all(color: Colors.transparent) :
                              Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,),),
                        ),
                        SizedBox(width: 10,),
                        Text("Contains at least 8 characters",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _hasPasswordOneNumber ?  Colors.green : Colors.transparent,
                              border: _hasPasswordOneNumber ? Border.all(color: Colors.transparent) :
                              Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,),),
                        ),
                        SizedBox(width: 10,),
                        Text("Contains at least 1 number",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _hasPasswordLowercase ?  Colors.green : Colors.transparent,
                              border: _hasPasswordLowercase ? Border.all(color: Colors.transparent) :
                              Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,),),
                        ),
                        SizedBox(width: 10,),
                        Text("Contains at least 1 Lowercase",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _hasPasswordUppercase ?  Colors.green : Colors.transparent,
                              border: _hasPasswordUppercase ? Border.all(color: Colors.transparent) :
                              Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,),),
                        ),
                        SizedBox(width: 10,),
                        Text("Contains at least 1 Uppercase",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _hasPasswordSpecial ?  Colors.green : Colors.transparent,
                              border: _hasPasswordSpecial? Border.all(color: Colors.transparent) :
                              Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,),),
                        ),
                        SizedBox(width: 10,),
                        Text("Contains at least 1 special character", style: TextStyle(color: Colors.white),)
                      ],
                    ),

                    //confirmPasswordField,
                    const SizedBox(height:35),
                    registerButton,
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}

