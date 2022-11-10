import '../../utils/my_material.dart';

class FooterPage extends StatelessWidget {
  final bool signUp;
  const FooterPage({Key? key, this.signUp = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              child: MyText(
                  signUp
                      ? AppLocalizations.of(context)!.signUp
                      : AppLocalizations.of(context)!.signIn,
                  style: TextStyle(
                      color: signUp ? colorWhite : colorPrimary,
                      fontFamily: poppins,
                      fontSize: getProportionateScreenWidth(
                          textSizeLargeMedium, context),
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: getShortSize(5, context),
            ),
            InkWell(
              onTap: () {
                signUp
                    ? Navigator.of(context).pushNamed(pageSignIn)
                    : Navigator.of(context).pushNamed(pageSignUp);
              },
              child: MyText(
                  signUp
                      ? AppLocalizations.of(context)!.signIn
                      : AppLocalizations.of(context)!.signUp,
                  style: TextStyle(
                      color: signUp ? colorWhite : colorPrimary,
                      fontFamily: poppins,
                      decoration: TextDecoration.underline,
                      fontSize:
                          getProportionateScreenWidth(textSizeSMedium, context),
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        SizedBox(
          height: getShortSize(5, context),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(paddingSmall),
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: 25,
                width: 25,
                decoration:
                    BoxDecoration(color: colorWhite, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: colorPrimary,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
