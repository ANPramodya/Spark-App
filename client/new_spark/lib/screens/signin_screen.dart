import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/screens/nav_screen.dart';
import 'package:new_spark/screens/screens.dart';
import 'package:new_spark/screens/stepper_test.dart';
import 'package:new_spark/services/authentication.dart';
import 'package:new_spark/widgets/custom_snackbar.dart';
import 'package:new_spark/widgets/gradient_text.dart';

GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late bool _passwordVisible;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.only(
            top: 40.0, left: 20.0, right: 20.0, bottom: 0.0),
        decoration: BoxDecoration(),
        child: Column(children: [
          Center(
              child: GradientText(
            text: 'Unity',
            style: TextStyle(
                fontSize: 40.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold),
            gradient: LinearGradient(colors: [
              Colors.purple,
              Colors.blue.shade400,
            ]),
          )
              // Text('Unity',
              //     style: TextStyle(
              //         fontSize: 40.0,
              //         letterSpacing: 1.0,
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold)),
              ),
          const SizedBox(
            height: 30.0,
          ),
          const Center(
            child: Text(
              'Login',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const CircleAvatar(
            radius: 60.0,
            backgroundColor: Colors.amber,
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 300.0,
            child: Form(
                key: _signInFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Something';
                        }
                        final emailRegex = RegExp(
                            r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.8,
                          fontSize: 18.0),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            MdiIcons.email,
                            color: Colors.grey,
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.circular(20.0)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 16.0),
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Something';
                          }
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.8,
                            fontSize: 18.0),
                        obscureText: !_passwordVisible,
                        autocorrect: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              MdiIcons.lock,
                              color: Colors.grey,
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius: BorderRadius.circular(20.0)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 16.0),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.grey,
                                )))
                        // Set floatingLabelBehavior to always
                        ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                        onPressed: () {}, child: Text('Forgot Password?')),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.purple,
                            Colors.blue.shade400,
                          ]),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                              onPressed: () async {
                                try {
                                  if (_signInFormKey.currentState!.validate()) {
                                    showProgressSnackbar(
                                        context, 'Please wait');

                                    var responseCode = await Authentication()
                                        .signin(_emailController.text,
                                            _passwordController.text, context);
                                    print(responseCode);
                                    if (responseCode == 200) {
                                      _signInFormKey.currentState?.dispose();

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const NavScreen()));
                                    } else if (responseCode == 404) {
                                      throw Exception();
                                    }
                                  }
                                } catch (e) {
                                  showErrorSnackbar(
                                      context, 'Wrong Credentials! try again');
                                }
                              },
                              child: const Text(
                                'SignIn',
                                style: TextStyle(
                                    letterSpacing: 0.8,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                          Icon(
                            MdiIcons.arrowRight,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 90.0,
                    ),
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? "),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const NewSignup()));
                  },
                  child: Text('Sign up'))
            ],
          )
        ]),
      ),
    ));
  }
}
