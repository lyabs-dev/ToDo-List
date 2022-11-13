import '../../../utils/my_material.dart';

class DetailNote extends StatelessWidget {
  DetailNote({Key? key}) : super(key: key);
  late TextEditingController titleController;
  late TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    textEditingController = TextEditingController();
    titleController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          color: colorWhite,
          padding: EdgeInsets.all(paddingSmall),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: colorPrimary,
                      ),
                    ),
                    MyText(AppLocalizations.of(context)!.note,
                        style: TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: getProportionateScreenWidth(
                                textSizeNormal, context))),
                    Icon(
                      Icons.check,
                      color: colorPrimary,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: getShortSize(30, context),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppEditText(
                          "Title",
                          titleController,
                          autofocus: true,
                          hintStyle: TextStyle(
                              color: colorPrimary,
                              fontSize: getProportionateScreenWidth(
                                  textSizeLarge, context)),
                          maxLines: 2,
                          style: TextStyle(
                              color: colorPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenWidth(
                                  textSizeLarge, context)),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_none,
                            color: colorPrimary,
                          ))
                    ],
                  ),
                  Expanded(
                      child: AppEditText(
                    "Description",
                    textEditingController,
                    style: TextStyle(color: colorPrimary),
                    hintStyle: TextStyle(color: colorPrimary),
                    maxLines: 100,
                  ))
                ],
              ),
             /* Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleButton(
                        Icons.mode_edit_outline_outlined,
                        () {
                          // Navigator.of(context).pushNamed(pageDetailNote);
                        },
                        iconColor: colorWhite,
                        secondReaction: colorPrimary,
                        secondColor: buttonColor,
                      )),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
