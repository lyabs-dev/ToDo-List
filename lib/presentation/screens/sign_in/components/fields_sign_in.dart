import '../../../../utils/my_material.dart';

class FieldSignIn extends StatelessWidget {
  FieldSignIn({required this.emailEditingController,required this.passwordEditingController,Key? key}) : super(key: key);
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppEditText(
          AppLocalizations.of(context)!.email,
          emailEditingController,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: colorPrimary),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: colorPrimary),
          ),
          hintStyle: TextStyle(color: colorPrimary),
          style: TextStyle(color: colorPrimary),
        ),
        SizedBox(
          height: getShortSize(30, context),
        ),
        AppEditText(
          AppLocalizations.of(context)!.password,
          passwordEditingController,
          isPassword: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: colorPrimary),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: colorPrimary),
          ),
          hintStyle: TextStyle(color: colorPrimary),
          style: TextStyle(color: colorPrimary),
        )
      ],
    );
  }
}
