import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        Icon(
          MdiIcons.closeCircleOutline,
          color: Colors.redAccent,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
            child: Text(
          message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 0.0,
    backgroundColor: Colors.black54,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
  ));
}

void showInfoSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        Icon(
          MdiIcons.informationOutline,
          color: Colors.blue,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 0.0,
    backgroundColor: Colors.black54,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
  ));
}

void showSuccessSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        Icon(
          MdiIcons.checkCircleOutline,
          color: Colors.green,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 0.0,
    backgroundColor: Colors.black54,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
  ));
}

void showProgressSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        Container(
          height: 20.0,
          width: 20.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            strokeWidth: 2.0,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 2),
    elevation: 0.0,
    backgroundColor: Colors.black54,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
  ));
}
