import 'package:flutter/material.dart';

class CustomAlertBox extends StatefulWidget {
  final String title, description, text;
  final Image? image;

  const CustomAlertBox(
      {super.key,
      required this.title,
      required this.description,
      required this.text,
      this.image});

  @override
  State<CustomAlertBox> createState() => _CustomAlertBoxState();
}

class _CustomAlertBoxState extends State<CustomAlertBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 20.0, top: 65.0, right: 20.0, bottom: 20.0),
          margin: const EdgeInsets.only(top: 45.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
              ]),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(widget.title),
            const SizedBox(
              height: 15,
            ),
            Text(widget.description),
            const SizedBox(
              height: 22.0,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(widget.text),
              ),
            )
          ]),
        ),
        Positioned(
            left: 20.0,
            right: 20.0,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 35.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: widget.image,
              ),
            ))
      ],
    );
  }
}
