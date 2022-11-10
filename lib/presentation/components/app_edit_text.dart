import 'package:flutter_structure/utils/my_material.dart';

class AppEditText extends StatelessWidget {
  final String? hintText, labelText;
  final TextEditingController controller;
  final bool isPassword, showCursor;
  final TextInputType inputType;
  final double? width;
  final Color? color, backgroundColor,cursorColor;
  final BorderRadius? borderRadius;
  final InputBorder border, enabledBorder,focusedBorder;
  final EdgeInsets? padding,contentPadding;
  final Widget? suffixIcon;
  final TextStyle? hintStyle, labelStyle, style;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final int maxLines;
  final FocusNode? focusNode;

  AppEditText(this.hintText, this.controller,
      {this.isPassword = false,
      this.inputType: TextInputType.text,
      this.width,
      this.backgroundColor,
      this.borderRadius,
        this.cursorColor,
      this.padding,this.contentPadding,
      this.suffixIcon,
        this.border :InputBorder.none,
        this.enabledBorder :InputBorder.none,
        this.focusedBorder :InputBorder.none,
      this.hintStyle,
      this.labelStyle,
      this.style,
      this.labelText,
      this.prefixIcon,
      this.textAlign: TextAlign.start,
      this.color: Colors.grey,
      this.maxLines: 1,
      this.showCursor: true,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: TextFormField(
        showCursor: showCursor,
        obscureText: isPassword,
        controller: controller,
        keyboardType: inputType,
        focusNode: focusNode,
        maxLines: maxLines,
        minLines: 1,
        cursorColor: cursorColor,
        style: style,
        textAlign: textAlign!,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          hintText: hintText,
          hintStyle: hintStyle,
          labelText: labelText,
          labelStyle: labelStyle,
          border: border,
          enabledBorder: enabledBorder,
          focusedBorder:  focusedBorder,
        ),
      ),
    );
  }
}
