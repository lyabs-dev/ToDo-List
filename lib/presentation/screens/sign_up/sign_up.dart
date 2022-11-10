import '../../../utils/my_material.dart';
import 'components/field_sign_up.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                color: colorPrimary,
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
                    MyText(AppLocalizations.of(context)!.createAccount,
                        style: TextStyle(
                            color: colorWhite,
                            fontFamily: poppins,
                            fontSize:
                                getProportionateScreenWidth(paddingXXXLarge, context),
                            fontWeight: FontWeight.w900)),
                    FieldSignUp(),
                    FooterPage(signUp: true,)
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image(image: AssetImage(PathImage.signUp),filterQuality: FilterQuality.high,fit: BoxFit.cover,),
          ),
        ],
      ),
    );
  }
}
