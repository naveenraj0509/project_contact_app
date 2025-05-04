import 'package:flutter/material.dart';


class BuildTextFieldWidget extends StatefulWidget {
  final Widget? iconWidget;
  final dynamic hintText;
  final Color? color;
  final TextEditingController? textEditingController;

  const BuildTextFieldWidget({super.key,  this.hintText, this.color, this.iconWidget, this.textEditingController, });

  @override
  State<BuildTextFieldWidget> createState() => _BuildTextFieldWidgetState();
}

class _BuildTextFieldWidgetState extends State<BuildTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return  TextField(style:TextStyle(color: Colors.white),controller: widget.textEditingController,
      decoration: InputDecoration(
        prefixStyle: TextStyle(color: Colors.red),
        fillColor: Colors.white10,
        filled: true,
        prefixIcon: widget.iconWidget,
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 18, color: widget.color?? Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5),
          ),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
