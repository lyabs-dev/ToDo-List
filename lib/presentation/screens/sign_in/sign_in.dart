import '../../../utils/my_material.dart';
import 'components/fields_sign_in.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: colorWhite,
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: colorWhite,
                  width: size.width,
                  height: size.height,
                  padding: EdgeInsets.only(
                      left: paddingLargeMedium,
                      right: paddingLargeMedium,
                      bottom: paddingXXXLarge),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getShortSize(50, context),
                      ),
                      MyText(AppLocalizations.of(context)!.welcomeBack,
                          style: TextStyle(
                              color: colorPrimary,
                              fontFamily: poppins,
                              fontSize: getProportionateScreenWidth(
                                  textSizeXXLarge, context),
                              fontWeight: FontWeight.w900)),
                      FieldSignIn(),
                      FooterPage()
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image(image: AssetImage(PathImage.signIn),filterQuality: FilterQuality.high,fit: BoxFit.cover,),
            ),
          ],
        ));
  }
}
