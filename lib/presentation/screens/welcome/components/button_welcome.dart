import '../../../../utils/my_material.dart';

class ButtonWelcome extends StatelessWidget {
  const ButtonWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)),
        onTap: () {
          Navigator.of(context).pushNamed(pageSignIn);
        },
        highlightColor: colorPrimaryLight,
        hoverColor: colorWhite,
        child: Ink(
          //  width: getProportionateScreenWidth(width!, context),
            decoration: BoxDecoration(
                color: colorSecondary,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                Text(
                  AppLocalizations.of(context)!.getStarted,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(
                        textSizeNormal, context),
                    color: colorWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 37,
                  width: 37,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: colorWhite, shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_forward,
                    color: colorSecondary,
                    size: 20,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
