import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/data/models/note_item.dart';
import 'package:flutter_structure/data/models/user_item.dart';
import 'package:flutter_structure/logic/cubits/home_cubit.dart';
import 'package:flutter_structure/logic/states/home_state.dart';
import 'package:flutter_structure/presentation/components/response_code_widget.dart';
import 'package:flutter_structure/presentation/screens/home/components/notes.dart';
import '../../../utils/my_material.dart';

class Home extends StatelessWidget {
  UserItem user;
   Home(this.user,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  //   List<Note> listNotes = [
  //   Note(true, "", "Pay credit card bills amount \$450", "23 juil"),
  //   Note(false, "Grocery list", "Milk\nBread\nVeggies\nEgg\nFruits\nShakes", "25 dec"),
  //   Note(false, "Figma", "Deliver files export save in drive Egg Fruits Shakes Deliver files export save in drive Egg Fruits Shakes Deliver files export save in drive Egg Fruits Shakes Deliver files export save in drive Egg Fruits Shakes Deliver files export save in drive Egg Fruits Shakes Deliver files export save in drive Egg Fruits Shakes", "2 sept"),
  //   Note(false, "Reply mails", "Mails \nFruits \nShakes", "25 dec"),
  //   Note(false, "", "Pay credit card bills amount \$450", "23 juil"),
  //   Note(false, "Grocery list", "Milk\nBread\nVeggies\nEgg\nFruits\nShakes", "25 dec"),
  //   Note(true, "Figma", "Deliver files export save in drive Egg Fruits Shakes Deliver files export save in drive Egg Fruits Shakes Deliver files export save in drive Egg Fruits Shakes Deliver files export save in drive Egg Fruits Shakes Deliver files export save in drive Egg Fruits Shakes Deliver files export save in drive Egg Fruits Shakes", "2 sept"),
  //   Note(false, "Reply mails", "Mails \nFruits \nShakes", "25 dec"),
  // ];

    List<NoteItem?> listNotes;

  DateTime dateTime = DateTime.now();

  return BlocListener<HomeCubit,HomeState>(
    listener: (context,state){
      if(state.responseCode?.code != null && state.responseCode?.code == HomeCode.WantDeleted){
        ResponseCodeWidget(context: context,item: state.responseCode!).show();
      }
      state.responseCode = null;
    },
    child: BlocBuilder<HomeCubit,HomeState>(
      builder: (context,state){
        listNotes = state.notes;
        return Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: Container(
                  color: colorWhite,

                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(textSizeLargeMedium),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(AppLocalizations.of(context)!.goodMorning + '\n${user.name}',
                                style: TextStyle(
                                    color: buttonColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: getProportionateScreenWidth(
                                        textSizeLarge, context))),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(PathImage.user),
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(textSizeLargeMedium),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image(
                                  image: AssetImage(PathIcons.calendar),
                                  filterQuality: FilterQuality.high,
                                  height: 25,
                                ),
                                SizedBox(
                                  width: getShortSize(10, context),
                                ),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: AppButton(
                                    "${formatDate(dateTime,"MMMd")}",
                                        () {
                                      Navigator.of(context).pushNamed(pageCalendar);
                                    },
                                    primaryColor: colorWhite,
                                    textColor: colorPrimary,
                                    borderRadius: 20,
                                    paddingVertical: 5,
                                  ),
                                ),
                              ],
                            ),
                            AppButton(
                              "${state.noteNumber} Notes",
                                  () {},
                              whitIcons: true,
                              paddingVertical: 7,
                              borderRadius: 20,
                              fontSize: textSizeSMedium,
                              icon: Image(
                                image: AssetImage(PathIcons.graph),
                                height: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getShortSize(10, context),
                      ),
                      if(state.loadingState)
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      else
                        Expanded(
                          child: CustomScrollView(
                            //if(state.notes){}
                            slivers: [
                              SliverList(
                                delegate: SliverChildListDelegate([]),
                              ),
                              SliverGrid.count(
                                childAspectRatio:
                                getProportionateScreenWidth(5.2, context) /
                                    getProportionateScreenWidth(7, context),
                                children: List.generate(
                                  state.notes.length,
                                      (index) => Notes(
                                    note: listNotes[index],
                                    reminder: listNotes[index]!.remind,
                                    title:listNotes[index]?.title ,
                                    tacks:listNotes[index]?.description ,
                                    date:formatDate(listNotes[index]!.creationDate, "d MMM"),
                                    //onLongPress: context.read<HomeCubit>().deleteNote(listNotes[index]!),
                                  ),
                                ),
                                crossAxisCount: 2,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Image(
                  image: AssetImage(PathImage.home),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleButton(Icons.add, () {
                      Navigator.of(context).pushNamed(pageDetailNote);
                    }, iconColor: colorPrimary,)),
              )
            ],
          ),
        );
      },
    ),
  );
  }
}

class Note{
   bool reminder;
   String title, tacks, date;

   Note(this.reminder, this.title, this.tacks, this.date);
}