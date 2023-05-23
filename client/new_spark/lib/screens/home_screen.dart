import 'package:new_spark/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../widgets/responsive.dart';
import 'home_screen_desktop.dart';
import 'home_screen_mobile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        drawer: CustomDrawer(), //left-side custom drawer widget
        //view according to screen size responsiveness
        body: Responsive(
          mobile: HomeScreenMobile(),
          desktop: HomeScreenDesktop(),
        ),
      ),
    );
  }
}
