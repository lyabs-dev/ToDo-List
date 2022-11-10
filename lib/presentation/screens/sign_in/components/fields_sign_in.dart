import '../../../../utils/my_material.dart';

class FieldSignIn extends StatelessWidget {
  FieldSignIn({Key? key}) : super(key: key);
  late TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    textEditingController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppEditText(
          AppLocalizations.of(context)!.email,
          textEditingController,
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
          textEditingController,
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
