import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:new_spark/screens/screens.dart';
import 'package:new_spark/widgets/gradient_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final controller = LiquidController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
              liquidController: controller,
              enableSideReveal: true,
              onPageChangeCallback: (index) {
                setState(() {});
              },
              slideIconWidget: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              pages: [const Page1(), const Page2(), const Page3()]),
          Positioned(
            bottom: 0,
            left: 16,
            right: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      final page = controller.currentPage - 1;
                      controller.animateToPage(
                          page: page > 3 ? 0 : page, duration: 400);
                    },
                    child: const Text('BACK')),
                AnimatedSmoothIndicator(
                  activeIndex: controller.currentPage,
                  count: 3,
                  effect: const WormEffect(
                      spacing: 16,
                      dotColor: Colors.white54,
                      activeDotColor: Colors.white),
                  onDotClicked: (index) {
                    controller.animateToPage(page: index);
                  },
                ),
                TextButton(
                    onPressed: () {
                      final page = controller.currentPage + 1;
                      controller.animateToPage(
                          page: page > 3 ? 0 : page, duration: 400);
                    },
                    child: const Text('NEXT')),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
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

  String? selectedUniversity = '';
  String? selectedFaculty = '';
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.orange.shade500, Colors.amber],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: Column(
          children: [
            const Center(
              child: Text('Unity',
                  style: TextStyle(
                      fontSize: 40.0,
                      letterSpacing: 1.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Center(
              child: Text(
                'SignUp',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            const SizedBox(
              width: 300.0,
              child: TextField(
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                    fontSize: 18.0),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white70, width: 2.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 2.0)),
                    hintText: 'Full Name',
                    hintStyle:
                        TextStyle(color: Colors.white70, fontSize: 18.0)),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            SizedBox(
              width: 300,
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                      hintText: "Choose University",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade400))),
                  items: universities
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(),
                            ),
                          ))
                      .toList(),
                  onChanged: (item) => setState(() {
                        selectedUniversity = item;
                      })),
            ),
            const SizedBox(
              height: 50.0,
            ),
            SizedBox(
              width: 300,
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      hintText: "Choose Faculty",
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade400))),
                  items: universities
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(),
                            ),
                          ))
                      .toList(),
                  onChanged: (item) => setState(() {
                        selectedFaculty = item;
                      })),
            ),
          ],
        ));
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue.shade400,
            Colors.greenAccent,
          ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
          child: Column(
            children: [
              Center(
                  child: GradientText(
                      text: 'Unity',
                      style: const TextStyle(
                          fontSize: 40.0,
                          letterSpacing: 1.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      gradient: LinearGradient(
                          colors: [Colors.purple, Colors.blue.shade400]))),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                  child: GradientText(
                      text: 'SignUp',
                      style: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      gradient: LinearGradient(
                          colors: [Colors.purple, Colors.blue.shade400]))),
              const SizedBox(
                height: 40.0,
              ),
              SizedBox(
                width: 300.0,
                child: TextField(
                  style: TextStyle(
                      color: Colors.purple[900],
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.8,
                      fontSize: 18.0),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.purple.shade400, width: 2.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.purple.shade700, width: 2.0)),
                      hintText: 'University Email Address',
                      hintStyle:
                          TextStyle(color: Colors.purple[900], fontSize: 18.0)),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Send Verification Code to Email',
                    style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        gradient: LinearGradient(
                            colors: [Colors.purple, Colors.blue.shade400])),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.rocket_launch,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 70.0),
              const Divider(
                thickness: 2.0,
                height: 2.0,
                color: Colors.white,
              ),
              const SizedBox(height: 50.0),
              const Text(
                '4 Digit Code',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.purple,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 150.0,
                child: TextField(
                  maxLength: 4,
                  style: TextStyle(
                      color: Colors.purple[900],
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.8,
                      fontSize: 18.0),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.purple.shade400, width: 2.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.purple.shade700, width: 2.0)),
                      hintStyle:
                          TextStyle(color: Colors.purple[900], fontSize: 18.0)),
                ),
              ),
            ],
          )),
    );
  }
}

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  late bool _passwordVisible;
  late bool _confirmPasswordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.purple, Colors.blue.shade400])),
            child: Column(
              children: [
                const Center(
                  child: Text('Unity',
                      style: TextStyle(
                          fontSize: 40.0,
                          letterSpacing: 1.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Center(
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                const SizedBox(
                  width: 300.0,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.8,
                        fontSize: 18.0),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white54, width: 2.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0)),
                        hintText: 'Name (will shown in the profile)',
                        hintStyle:
                            TextStyle(color: Colors.white54, fontSize: 18.0)),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const SizedBox(
                  width: 300.0,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.8,
                        fontSize: 18.0),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white54, width: 2.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0)),
                        hintText: 'Username',
                        hintStyle:
                            TextStyle(color: Colors.white54, fontSize: 18.0)),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    obscureText: !_passwordVisible,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.8,
                        fontSize: 18.0),
                    decoration: InputDecoration(
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
                                color: Colors.white)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white54, width: 2.0)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0)),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: Colors.white54, fontSize: 18.0)),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    obscureText: !_confirmPasswordVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.8,
                        fontSize: 18.0),
                    decoration: InputDecoration(
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
                                  : Icons.visibility_off_outlined,
                              color: Colors.white,
                            )),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white54, width: 2.0)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0)),
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(
                            color: Colors.white54, fontSize: 18.0)),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SigninScreen()));
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(
                            letterSpacing: 0.8,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
                )
              ],
            )),
      ),
    );
  }
}
