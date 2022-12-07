import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/logic/cubits/sign_up_cubit.dart';
import 'package:flutter_structure/logic/states/sign_up_state.dart';

import '../../../utils/my_material.dart';
import 'components/field_sign_up.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(SignUpState()),
      child: BlocListener<SignUpCubit,SignUpState>(
        listener: (context,state){
          if(state.responseCode != null) {
            if(state.responseCode != null) {
              if(state.user !=null && state.responseCode?.code == SignUpCode.Connected) {
                context.read<AppCubit>().setUser(state.user!);
                Navigator.of(context).pushNamed(pageHome);
              }
            }
          }
        },
        child: BlocBuilder<SignUpCubit,SignUpState>(
            builder: (context,state) {
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
                                      fontSize: getProportionateScreenWidth(
                                          paddingXXLarge, context),
                                      fontWeight: FontWeight.w900)),
                              FieldSignUp(
                                nameEditingController: state.usernameEditingController,
                                emailEditingController: state.emailEditingController,
                                passwordEditingController: state.passwordEditingController,
                              ),
                              FooterPage(sign: context.read<SignUpCubit>().signUp,
                                signUp: true,
                              ),
                              if (state.isLoading)
                                Center(
                                  child: CircularProgressIndicator(),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image(
                        image: AssetImage(PathImage.signUp),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
