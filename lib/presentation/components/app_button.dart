import 'package:flutter_structure/utils/my_material.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final Function onPressed;
  final FontWeight? textFontWeight;
  final double? fontSize,
      borderRadius,
      paddingHorizontal,
      paddingVertical;
  final Color primaryColor, textColor,highlightColor;
  final bool whitIcons;

   AppButton(this.text, this.onPressed,
      {Key? key,
        this.primaryColor = colorPrimary,
        this.textColor = colorWhite,
        this.fontSize = textSizeMedium,
        this.borderRadius = 10,
        this.textFontWeight,
        this.highlightColor: colorPrimaryLight,
        this.icon,
        this.paddingHorizontal = 15.0,
        this.paddingVertical = 14.0,
        this.whitIcons = false})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onTap: () => onPressed(),
        highlightColor: colorPrimaryLight,
        hoverColor: colorWhite,
        child: Ink(
        //  width: getProportionateScreenWidth(width!, context),
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius:
              BorderRadius.all(Radius.circular(borderRadius!))),
          padding: EdgeInsets.symmetric(
              horizontal:paddingHorizontal!,
              vertical:
              getProportionateScreenHeight(paddingVertical!, context)),
          child: whitIcons
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ icon!,
              Text(
               text!,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(fontSize!, context),
                  color: textColor,
                  fontWeight: textFontWeight ?? FontWeight.w600,
                ),
              ),

            ],
          )
              : Text(
            text!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:getProportionateScreenWidth(fontSize!, context) ,

              color:
              textColor,
              fontWeight:textFontWeight ?? FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
