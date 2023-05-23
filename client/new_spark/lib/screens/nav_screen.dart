import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../models/message_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/responsive.dart';
import 'screens.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<IconData> _icons = [
    MdiIcons.homeOutline,
    MdiIcons.chatAlertOutline,
    MdiIcons.accountCircleOutline,
  ];

  int _selectedIndex = 0;

  //list of screens in the nav bar
  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

//method navigating between three screens
  var _selectedTab = _SelectedTab.home;
  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        extendBody: true,
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
                preferredSize: Size(screenSize.width, 100.0),
                child: CustomAppBar(
                    currentUser: currentUser,
                    icons: _icons,
                    selectedIndex: _selectedIndex,
                    onTap: (index) => setState(() => _selectedIndex = index)))
            : null,
        //changing screens per navigation bar
        body: _screens[_selectedTab.index],
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? DotNavigationBar(
                backgroundColor: Colors.grey.shade400.withOpacity(0.8),
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                currentIndex: _SelectedTab.values.indexOf(_selectedTab),
                dotIndicatorColor: Colors.grey.withOpacity(0.8),
                onTap: _handleIndexChanged,
                marginR: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 40.0),
                itemPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                curve: Curves.slowMiddle,
                //icons of navigation bar
                items: [
                  DotNavigationBarItem(
                      icon: const Icon(
                        MdiIcons.homeOutline,
                        size: 30.0,
                      ),
                      selectedColor: Colors.purple[700],
                      unselectedColor: Colors.black45),
                  DotNavigationBarItem(
                      icon: const Icon(MdiIcons.messageOutline, size: 26.0),
                      selectedColor: Colors.purple[700],
                      unselectedColor: Colors.black45),
                  DotNavigationBarItem(
                      icon:
                          const Icon(MdiIcons.accountCircleOutline, size: 28.0),
                      selectedColor: Colors.purple[700],
                      unselectedColor: Colors.black45),
                ],
              )
            : const SizedBox.shrink());
  }
}

enum _SelectedTab { home, messages, profile }
