import '../../../../utils/my_material.dart';

class FieldSignUp extends StatelessWidget {
   FieldSignUp({
     required this.nameEditingController,
     required this.emailEditingController,
     required this.passwordEditingController,
     Key? key}) : super(key: key);
   late TextEditingController nameEditingController;
   late TextEditingController emailEditingController;
   late TextEditingController passwordEditingController;


   @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppEditText(
          AppLocalizations.of(context)!.name,
          nameEditingController,
          cursorColor: colorWhite,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: colorWhite),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: colorWhite),
          ),
          hintStyle: TextStyle(color: colorWhite),
          style: TextStyle(color: colorWhite),
        ),
        SizedBox(
          height: getShortSize(30, context),
        ),
        AppEditText(
          AppLocalizations.of(context)!.email,
          emailEditingController,
          cursorColor: colorWhite,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: colorWhite),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: colorWhite),
          ),
          hintStyle: TextStyle(color: colorWhite),
          style: TextStyle(color: colorWhite),
        ),
        SizedBox(
          height: getShortSize(30, context),
        ),
        AppEditText(
          AppLocalizations.of(context)!.password,
          passwordEditingController,
          cursorColor: colorWhite,
          isPassword: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: colorWhite),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: colorWhite),
          ),
          hintStyle: TextStyle(color: colorWhite),
          style: TextStyle(color: colorWhite),
        )
      ],
    );
  }
}
