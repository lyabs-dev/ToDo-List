import 'package:flutter/foundation.dart';
import 'package:flutter_structure/utils/my_material.dart';

class MyText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? maxLines;
  const MyText(this.text, {Key? key, required this.style, this.textAlign, this.maxLines }): super(key: key);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return DefaultTextStyle(
          style: style,
          child: Text(
            text,
            maxLines: maxLines ,
            textAlign: textAlign,
          ));
    } else {
      return Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style: style,
      );
    }
  }
}
