import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class BuildUserContactTileWidget extends StatefulWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final Color? fillColor;
  final Icon? icon;


  const BuildUserContactTileWidget(
      {super.key, required this.text, this.textColor, this.fontSize, this.fillColor, this.icon});

  @override
  State<BuildUserContactTileWidget> createState() =>
      _BuildUserContactTileWidgetState();
}

class _BuildUserContactTileWidgetState
    extends State<BuildUserContactTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(tileColor: widget.fillColor ?? Colors.black,
      focusColor: Colors.red,
      leading: widget.icon,
      title: Text(
        widget.text,
        style: TextStyle(
          color: widget.textColor ?? Colors.red,
          fontSize: widget.fontSize,
          // fontWeight: FontWeight.bold
        ),
      ),
    );
    ;
  }
}
