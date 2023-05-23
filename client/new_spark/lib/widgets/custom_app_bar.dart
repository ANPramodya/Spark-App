import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_spark/widgets/custom_tab_bar.dart';
import 'package:new_spark/widgets/user_card.dart';

import '../models/user_model.dart';
import 'circle_button.dart';
import 'gradient_text.dart';

class CustomAppBar extends StatelessWidget {
  final User currentUser;
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar({
    super.key,
    required this.currentUser,
    required this.icons,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(color: Colors.white, boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 4.0)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GradientText(
              //gradient custom widget
              text: 'Unity',
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.7),
              gradient: LinearGradient(colors: [
                Colors.purple,
                Colors.blue.shade400,
              ]),
            ),
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: CustomTabBar(
                icons: icons,
                selectedIndex: selectedIndex,
                onTap: onTap,
                isBottomIndicator: true,
              ),
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              UserCard(user: currentUser),
              const SizedBox(
                width: 12.0,
              ),
              CircleButton(
                icon: Icons.search,
                onPressed: () => print('Search'),
                iconSize: 30.0,
              ),
              CircleButton(
                  icon: MdiIcons.facebookMessenger,
                  iconSize: 30.0,
                  onPressed: () => print('Messenger'))
            ],
          ))
        ],
      ),
    );
  }
}
