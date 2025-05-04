import 'package:flutter/material.dart';

class BuildAddContactAppbarWidget extends StatefulWidget {
  final String? leadText;
  final String? centerText;
  final String? actionText;
  final Function? onActionPressed;
  const BuildAddContactAppbarWidget({super.key, this.leadText, this.centerText, this.actionText, this.onActionPressed});

  @override
  State<BuildAddContactAppbarWidget> createState() => _BuildAddContactAppbarWidgetState();
}

class _BuildAddContactAppbarWidgetState extends State<BuildAddContactAppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            widget.leadText??"",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blue),
          ),
        ),
        Spacer(),

        Text(
          widget.centerText??"",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white),
        ),
        Spacer(),
        TextButton(
          onPressed: (){
    widget.onActionPressed!();
    },
          child: Text(
            widget.actionText??"",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
