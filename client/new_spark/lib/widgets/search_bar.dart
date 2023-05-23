import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback onTapIcon;

  const SearchBar({super.key, required this.hintText, required this.onTapIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black38),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
          suffixIcon: IconButton(
              onPressed: onTapIcon, icon: const Icon(MdiIcons.magnify)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 2.0),
              borderRadius: BorderRadius.circular(30.0))),
    );
  }
}
