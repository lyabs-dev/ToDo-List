import 'package:flutter_structure/utils/my_material.dart';

class CircleButton extends StatefulWidget {

  final Function onPressed;
  final FontWeight? textFontWeight;
  final IconData? icon;
  final double size, heightFirthCircle,heightSecondCircle;
  final Color primaryColor, iconColor,firthReaction,secondReaction;

  const CircleButton(this.icon, this.onPressed,
      {Key? key,
        this.primaryColor = buttonColor,
        this.iconColor = colorWhite,
        this.size = textSizeNormal,
        this.firthReaction = colorSecondary,
        this.secondReaction = buttonColor,
        this.heightFirthCircle = 50,
        this.heightSecondCircle = 25,
        this.textFontWeight
      })
      : super(key: key);

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _reaction = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onTapDown: (tDown) {
        setState(() {
          _reaction = true;
        });
      },
      onTapUp: (tUp) {
        setState(() {
          _reaction = false;
        });
      },
      onTap: () => widget.onPressed(),
      child: Container(
        height: widget.heightFirthCircle,
        width: widget.heightFirthCircle,
        padding: EdgeInsets.all(paddingSmall),
        decoration: BoxDecoration(
            color:_reaction ? widget.firthReaction : widget.primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: widget.heightSecondCircle,
          width:  widget.heightSecondCircle,
          decoration:
          BoxDecoration(color:_reaction? widget.secondReaction: colorWhite, shape: BoxShape.circle),
          child: Center(
            child: Icon(
            widget.icon,
                color: _reaction ? colorWhite : widget.iconColor,size:widget.size
            ),
          ),
        ),
      ),
    );
  }
}
//color: