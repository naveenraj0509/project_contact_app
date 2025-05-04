import 'package:flutter/material.dart';

class BuildTextWidget extends StatefulWidget {
  final String text;
  final Color? textColor;


  const BuildTextWidget({
    super.key,
    required this.text,
    this.textColor,
  });

  @override
  State<BuildTextWidget> createState() => _BuildTextWidgetState();
}

class _BuildTextWidgetState extends State<BuildTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(color: widget.textColor ?? Colors.red),
    );
  }
}


// class TextWidget extends StatelessWidget {
//   final String text;
//   final double? fontSize;
//
//   const TextWidget({super.key,required this.text,this.fontSize});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(text,style: TextStyle(fontSize: fontSize,color: Colors.yellow),);
//   }
// }
