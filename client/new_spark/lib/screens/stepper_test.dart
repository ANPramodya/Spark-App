import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/screens/screens.dart';
import 'package:new_spark/widgets/custom_snackbar.dart';
import 'package:new_spark/widgets/gradient_text.dart';

import '../services/authentication.dart';

// final _signUpForm1Key = GlobalKey<FormState>();
// final _signUpForm2Key = GlobalKey<FormState>();
// final _signUpForm3Key = GlobalKey<FormState>();
final List<GlobalKey<FormState>> _formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
];

class NewSignup extends StatefulWidget {
  const NewSignup({super.key});

  @override
  State<NewSignup> createState() => _NewSignupState();
}

class _NewSignupState extends State<NewSignup> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _uniEmailController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  late bool _passwordVisible;
  late bool _confirmPasswordVisible;
  String? _selectedUniversity = '';
  String? _selectedFaculty = '';
  int currentStep = 0;
  int numOfSteps = 3;
  List<String> universities = [
    'University of Kelaniya',
    "University of Colombo",
    "University of Moratuwa",
    "University of Peradeniya",
    "University of Ruhuna",
    "University of Jaffna",
    "University of Uwa",
    'University of Sabaragamuwa',
    "University of Rajarata"
  ];
  List<String> faculties = [
    "Faculty of Science",
    "Faculty of Engineering",
    "Faculty of Medicine",
    "Faculty of Arts",
    "Faculty of Management",
  ];

  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.scaffold,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GradientText(
          text: 'Create Account',
          style: TextStyle(fontSize: 30.0),
          gradient: LinearGradient(colors: [
            Colors.purple,
            Colors.blue.shade400,
          ]),
        ),
      ),
      body: Container(
          color: Palette.scaffold,
          child: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: Colors.purple)),
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepContinue: () async {
                final isLastStep = currentStep == numOfSteps - 1;
                //validate
                try {
                  if (currentStep == 0) {
                    //validate form1
                    if (_formKeys[0].currentState!.validate()) {
                      setState(() {
                        currentStep += 1;
                      });
                    } else {
                      showErrorSnackbar(context, 'not Continue');
                    }
                  } else if (currentStep == 1) {
                    // validate form 2
                    if (_formKeys[1].currentState!.validate()) {
                      setState(() {
                        currentStep += 1;
                      });
                    } else {
                      showErrorSnackbar(context, 'not Continue');
                    }
                  } else if (currentStep == 2) {
                    //validate form 3
                    if (_formKeys[2].currentState!.validate()) {
                      print('complete');
                      //signup
                      var responseCode = await Authentication().signUp(
                          context,
                          'username',
                          _passwordController.text,
                          _uniEmailController.text,
                          _firstNameController.text,
                          _lastNameController.text,
                          _selectedUniversity!,
                          _selectedFaculty!,
                          'true');
                      if (responseCode == 201) {
                        _disposeFormKeys();
                        await Future.delayed(Duration(seconds: 2));
                        print('keys disposed');
                        // Navigator.popAndPushNamed(context, '/signin');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NavScreen()));
                      } else if (responseCode == 403) {
                        showErrorSnackbar(context,
                            'University Email already have an account!');
                      }
                    } else {
                      showErrorSnackbar(context, 'not Continue');
                    }

                    //navigate to Login Page
                  }
                } catch (e) {
                  showErrorSnackbar(context, 'Something went wrong!');
                }
              },
              onStepCancel: () {
                currentStep == 0
                    ? null
                    : setState(() {
                        currentStep -= 1;
                      });
              },
              onStepTapped: (step) => setState(
                () {
                  currentStep = step;
                },
              ),
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                final isLastStep = currentStep == numOfSteps - 1;
                if (currentStep == 0) {
                  return Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.purple,
                          Colors.blue.shade400,
                        ]),
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: details.onStepContinue,
                            child: const Text(
                              'Next',
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
                  );
                } else if (currentStep == 1) {
                  return Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: details.onStepContinue,
                                  child: const Text('Verify',
                                      style: TextStyle(
                                          letterSpacing: 0.8,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white))),
                              Icon(
                                MdiIcons.arrowRight,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(25.0)),
                          child: TextButton(
                              onPressed: details.onStepCancel,
                              child: const Text('Back',
                                  style: TextStyle(
                                      letterSpacing: 0.8,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54))),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: details.onStepContinue,
                                  child: const Text('SignUp',
                                      style: TextStyle(
                                          letterSpacing: 0.8,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white))),
                              Icon(
                                MdiIcons.arrowRight,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(25.0)),
                          child: TextButton(
                              onPressed: details.onStepCancel,
                              child: const Text('Back',
                                  style: TextStyle(
                                      letterSpacing: 0.8,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54))),
                        ),
                      ],
                    ),
                  );
                }

                // return Container(
                //   margin: EdgeInsets.only(top: 50),
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: ElevatedButton(
                //         child: Text(isLastStep ? 'SignUp' : 'Next'),
                //         onPressed: details.onStepContinue,
                //       )),
                //       const SizedBox(
                //         width: 12.0,
                //       ),
                //       if (currentStep != 0)
                //         Expanded(
                //             child: ElevatedButton(
                //                 onPressed: details.onStepCancel,
                //                 child: Text('Back')))
                //     ],
                //   ),
                // );
              },
              steps: <Step>[
                Step(
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep >= 0,
                    title: Text('University'),
                    content: Column(
                      children: [
                        Form(
                            key: _formKeys[0],
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _fullNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Full Name';
                                    }
                                  },
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.8,
                                      fontSize: 18.0),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        MdiIcons.cardAccountDetails,
                                        color: Colors.grey,
                                      ),
                                      labelText: 'Full Name',
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.purple),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 16.0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Choose University';
                                      }
                                    },
                                    isExpanded: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedUniversity = newValue;
                                      });
                                    },
                                    items: universities
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(),
                                              ),
                                            ))
                                        .toList(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.8,
                                      fontSize: 18.0,
                                    ),
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      labelText: 'Univerity',
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      prefixIcon: Icon(MdiIcons.accountSchool),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 0.0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Choose Faculty';
                                      }
                                    },
                                    isExpanded: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedFaculty = newValue;
                                      });
                                    },
                                    items: faculties
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(),
                                              ),
                                            ))
                                        .toList(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.8,
                                      fontSize: 18.0,
                                    ),
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      labelText: 'Faculty',
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      prefixIcon: Icon(MdiIcons.accountSchool),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 0.0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )),
                Step(
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep >= 1,
                    title: Text('Email'),
                    content: Column(
                      children: [
                        Form(
                            key: _formKeys[1],
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _uniEmailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Something';
                                    }
                                    final emailRegex = RegExp(
                                        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
                                    if (!emailRegex.hasMatch(value)) {
                                      return 'Enter a valid email';
                                    }
                                    print('validated email');
                                    return null;
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
                                      labelText: 'Email (university)',
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.purple),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 16.0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                  controller: _otpController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Something';
                                    }
                                    print('validated');
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.8,
                                      fontSize: 18.0),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        MdiIcons.formTextboxPassword,
                                        color: Colors.grey,
                                      ),
                                      labelText: 'OTP',
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.purple),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 16.0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto),
                                ),
                              ],
                            )),
                      ],
                    )),
                Step(
                    isActive: currentStep >= 2,
                    title: Text('SignUp'),
                    content: Column(
                      children: [
                        Form(
                            key: _formKeys[2],
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _firstNameController,
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
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        MdiIcons.accountCircle,
                                        color: Colors.grey,
                                      ),
                                      labelText: 'First Name',
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.purple),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 16.0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                  controller: _lastNameController,
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
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        MdiIcons.accountCircle,
                                        color: Colors.grey,
                                      ),
                                      labelText: 'Last Name',
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.purple),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 16.0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter password';
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
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 16.0),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: Colors.grey,
                                            )))
                                    // Set floatingLabelBehavior to always
                                    ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                    controller: _confirmPasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter same password';
                                      } else if (_passwordController.text !=
                                          _confirmPasswordController.text) {
                                        return 'Enter same Password';
                                      }
                                    },
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.8,
                                        fontSize: 18.0),
                                    obscureText: !_confirmPasswordVisible,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          MdiIcons.lock,
                                          color: Colors.grey,
                                        ),
                                        labelText: ' Confirm Password',
                                        labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 16.0),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _confirmPasswordVisible =
                                                    !_confirmPasswordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              _confirmPasswordVisible
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: Colors.grey,
                                            )))
                                    // Set floatingLabelBehavior to always
                                    ),
                              ],
                            )),
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  // List<Step> getSteps() => [
  //       Step(
  //           state: currentStep > 0 ? StepState.complete : StepState.indexed,
  //           isActive: currentStep >= 0,
  //           title: Text('Account'),
  //           content: Column(
  //             children: [
  //               TextField(
  //                 controller: fullNameController,
  //                 decoration: InputDecoration(labelText: 'FullName'),
  //               ),
  //               TextField(
  //                 controller: universityController,
  //                 decoration: InputDecoration(labelText: 'University'),
  //               ),
  //               TextField(
  //                 controller: facultyController,
  //                 decoration: InputDecoration(labelText: 'Faculty'),
  //               )
  //             ],
  //           )),
  //       Step(
  //           state: currentStep > 1 ? StepState.complete : StepState.indexed,
  //           isActive: currentStep >= 1,
  //           title: Text('Address'),
  //           content: Column(
  //             children: [
  //               TextField(
  //                 controller: uniEmailController,
  //                 decoration: InputDecoration(labelText: 'University Email'),
  //               ),
  //               TextField(
  //                 controller: otpController,
  //                 decoration: InputDecoration(labelText: 'OTP'),
  //               )
  //             ],
  //           )),
  //       Step(
  //           isActive: currentStep >= 2,
  //           title: Text('Complete'),
  //           content: Column(
  //             children: [
  //               TextField(
  //                 controller: usernameController,
  //                 decoration: InputDecoration(labelText: 'Username'),
  //               ),
  //               TextField(
  //                 controller: passwordController,
  //                 decoration: InputDecoration(labelText: 'Password'),
  //               ),
  //               TextField(
  //                 controller: confirmPasswordController,
  //                 decoration: InputDecoration(labelText: 'Confirm Password'),
  //               )
  //             ],
  //           ))
  //     ];
}

// Dispose of global keys in a list
void _disposeFormKeys() {
  for (var key in _formKeys) {
    print('disposing keys');
    key.currentState?.dispose();
  }
}
