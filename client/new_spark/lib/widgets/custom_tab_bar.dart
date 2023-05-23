// import 'package:dot_navigation_bar/dot_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class CustomTabBar extends StatelessWidget {
//   final List<IconData> icons;
//   final int selectedIndex;
//   final Function(int) onTap;
//   final bool isBottomIndicator = false;

//   const CustomTabBar(
//       {super.key,
//       required this.icons,
//       required this.selectedIndex,
//       required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return DotNavigationBar(
//       items: [
//         DotNavigationBarItem(
//             icon: const Icon(MdiIcons.homeOutline),
//             selectedColor: Colors.orange[700]),
//         DotNavigationBarItem(
//             icon: const Icon(MdiIcons.chatAlertOutline),
//             selectedColor: Colors.orange[700]),
//         DotNavigationBarItem(
//             icon: const Icon(MdiIcons.accountCircleOutline),
//             selectedColor: Colors.orange[700])
//       ],
//     );
//   }
// }

import 'package:new_spark/config/palette.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;

  const CustomTabBar(
      {super.key,
      required this.icons,
      required this.selectedIndex,
      this.isBottomIndicator = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
          border: isBottomIndicator
              ? const Border(
                  bottom: BorderSide(color: Palette.facebookBlue, width: 3.0))
              : const Border(
                  top: BorderSide(color: Palette.facebookBlue, width: 3.0))),
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
              i,
              Tab(
                icon: Icon(
                  e,
                  color: i == selectedIndex
                      ? Palette.facebookBlue
                      : Colors.black45,
                  size: 30.0,
                ),
              )))
          .values
          .toList(),
      onTap: onTap,
    );
  }
}
