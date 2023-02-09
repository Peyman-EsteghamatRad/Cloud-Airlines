 import "package:flutter/material.dart";
import 'package:frontend/design/colors.dart';

class CustomTextWidget extends StatefulWidget {
  CustomTextWidget(this.text,
      {Key? key,
      this.color = CustomColors.SECOND_THEME,
        this.textSize = 30,
        this.backgroundC = Colors.transparent
      })
      : super(key: key);

  String text;
  Color color;
  double textSize;
  Color backgroundC;

  @override
  State<CustomTextWidget> createState() => _CustomTextWidgetState();
}

class _CustomTextWidgetState extends State<CustomTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,style: TextStyle(color: widget.color, fontSize: widget.textSize, backgroundColor: widget.backgroundC),);
  }
}
