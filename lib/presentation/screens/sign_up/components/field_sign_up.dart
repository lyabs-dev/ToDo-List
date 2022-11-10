import '../../../../utils/my_material.dart';

class FieldSignUp extends StatelessWidget {
   FieldSignUp({Key? key}) : super(key: key);
   late TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    textEditingController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppEditText(
          AppLocalizations.of(context)!.name,
          textEditingController,
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
          textEditingController,
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
          textEditingController,
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
