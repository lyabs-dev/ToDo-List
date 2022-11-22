import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubits/sign_in_cubit.dart';
import '../../../logic/states/sign_in_state.dart';
import '../../../utils/my_material.dart';
import 'components/fields_sign_in.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<SignInCubit>(
        create: (context) => SignInCubit(SignInState()),
        child: BlocBuilder<SignInCubit,SignInState>(
          builder: (context,state) {
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
                                          paddingXXXLarge, context),
                                      fontWeight: FontWeight.w900)),
                              FieldSignIn(
                                  emailEditingController:state.emailEditingController,
                                  passwordEditingController:state.passwordEditingController),
                              FooterPage(signIn: context.read<SignInCubit>().signIn(),)
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
                )
            );
          },
        ),
    );
  }
}
