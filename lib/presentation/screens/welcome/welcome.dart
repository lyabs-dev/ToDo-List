import 'package:flutter_structure/utils/my_material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  WelcomePageState createState() {
    return WelcomePageState();
  }
}

class WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldColor(
        child: Container(
      padding: EdgeInsets.all(paddingLargeMedium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getShortSize(50, context) ,),
          MyText(AppLocalizations.of(context)!.createYour,
              style: TextStyle(
                  color: colorWhite,
                  fontFamily: poppins,
                  fontSize:
                      getProportionateScreenWidth(textSizeXXLarge, context),
                  fontWeight: FontWeight.w900)),
          AppButton(
            AppLocalizations.of(context)!.getStarted,
            () {
              Navigator.of(context).pushNamed(pageSignIn);
            },
            whitIcons: true,
            primaryColor: colorSecondary,
            borderRadius: 30,
            paddingVertical: 10,
            fontSize: textSizeNormal,
            icon: Container(
              height: 35,
              width: 35,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: colorWhite,shape: BoxShape.circle
              ),
              child: Icon(Icons.arrow_forward, color: colorSecondary,size: 20,),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image(
              image: AssetImage(PathImage.logo),
              filterQuality: FilterQuality.high,
              height: getProportionateScreenHeight(200, context),
            ),
          )
        ],
      ),
    ));
  }
}
