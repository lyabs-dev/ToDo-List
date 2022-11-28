import 'package:flutter_structure/data/models/note_item.dart';

import '../../../../utils/my_material.dart';

class Notes extends StatelessWidget {
  final NoteItem? note;
  final bool reminder;
  final String? title, tacks, date;
  const Notes(
      {Key? key,this.note, this.reminder = false, this.title, this.date, this.tacks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: paddingSmall, vertical: paddingSmall),
        child: InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onTap: () {
            Navigator.of(context).pushNamed(pageDetailNote,arguments: {ARGUMENT_NOTE: note});
          },
          highlightColor: colorPrimaryLight,
          hoverColor: colorWhite,
          child: Ink(
            padding: EdgeInsets.all(paddingSmall),
            decoration: BoxDecoration(
              border: reminder
                  ? Border()
                  : Border.all(color: Color(0XFFEBEBEB), width: 1.5),
              color: reminder ? colorPrimary : colorWhite,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(title!,
                    style: TextStyle(
                        color: reminder ? colorWhite : colorBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: getProportionateScreenWidth(
                            textSizeLargeMedium, context))),
                MyText(tacks!,
                    maxLines: 5,
                    style: TextStyle(
                        color: reminder ? colorWhite : colorBlack,
                        fontWeight: FontWeight.w100,
                        overflow: TextOverflow.ellipsis,
                        fontSize: getProportionateScreenWidth(
                            textSizeSmall, context))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(date!,
                        style: TextStyle(
                            color: colorSecondary,
                            fontWeight: FontWeight.w100,
                            fontSize: getProportionateScreenWidth(
                                textSizeSmall, context))),
                    reminder
                        ? Container(
                            height: getProportionateScreenWidth(8, context),
                            width: getProportionateScreenWidth(8, context),
                            decoration: BoxDecoration(
                                color: colorSecondary, shape: BoxShape.circle),
                          )
                        : SizedBox.shrink()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
