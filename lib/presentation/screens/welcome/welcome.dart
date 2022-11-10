import 'package:flutter_structure/utils/my_material.dart';

import 'components/button_welcome.dart';

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
          SizedBox(
            height: getShortSize(50, context),
          ),
          MyText(AppLocalizations.of(context)!.createYour,
              style: TextStyle(
                  color: colorWhite,
                  fontFamily: poppins,
                  fontSize:
                      getProportionateScreenWidth(textSizeXXLarge, context),
                  fontWeight: FontWeight.w900)),
          ButtonWelcome(),
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
