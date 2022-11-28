import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/logic/cubits/note_cubit.dart';
import 'package:flutter_structure/logic/states/note_state.dart';
import '../../../data/models/note_item.dart';
import '../../../utils/my_material.dart';
import '../../components/response_code_widget.dart';

class DetailNote extends StatefulWidget {

  NoteItem? note;

  DetailNote({Key? key,this.note}) : super(key: key);

  @override
  State<DetailNote> createState() => _DetailNoteState(note:note);
}

class _DetailNoteState extends State<DetailNote> {
  NoteItem? note;
  bool _infoNodeTitle = false;
  bool _infoNodeDescription = false;

  FocusNode _focusTitle = new FocusNode();
  FocusNode _focusDescription = new FocusNode();

  _DetailNoteState({this.note});

  @override
  void initState() {
    super.initState();

    _focusTitle.addListener(_handleFocusChangeUsename);
    _focusDescription.addListener(_handleFocusChangeEmail);
  }

  @override
  void dispose() {
    super.dispose();
    _focusTitle.removeListener(_handleFocusChangeUsename);
    _focusDescription.removeListener(_handleFocusChangeEmail);

    _focusTitle.dispose();
    _focusDescription.dispose();
  }

  void _handleFocusChangeUsename() {
    if (_focusTitle.hasFocus != _infoNodeTitle) {
      setState(() {
        _infoNodeTitle = _focusTitle.hasFocus;
      });
    }
  }

  void _handleFocusChangeEmail() {
    if (_focusDescription.hasFocus != _infoNodeDescription) {
      setState(() {
        _infoNodeDescription = _focusDescription.hasFocus;
      });
    }
  }

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  DateTime _dateTime = DateTime.now();
  bool dateChange = false;
  DateTime _time = DateTime.now();
  bool timeChange = false;

  TimeOfDay time =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<NoteCubit>(
        create: (context) => NoteCubit(NoteState()),
      child: BlocListener<NoteCubit,NoteState>(
        listener: (context,state) {
          if(state.responseCode?.code == NoteCode.Created) {
            ResponseCodeWidget(context: context, item: state.responseCode!).show();
          }

        },
        child: BlocBuilder<NoteCubit,NoteState>(

          builder: (context,state) {
            if(note == null){
              titleController = state.titleEditingController;
              descriptionController = state.descriptionEditingController;
            } else {
              descriptionController = TextEditingController(text: note?.description);
              titleController = TextEditingController(text: note?.title);

            }
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
                              onTap: () {
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
                                        textSizeMedium, context))),
                            (_infoNodeTitle || _infoNodeDescription) ? InkWell(
                              onTap: () {
                                //_focusTitle.unfocus();
                                //_focusDescription.unfocus();
                                context.read<NoteCubit>().createNote();
                              },
                              child: Icon(
                                Icons.check,
                                color: colorPrimary,
                              ),
                            )
                                : PopupMenuButton<MenuItem>(
                                elevation: 1.0,
                                splashRadius: 20.0,
                                position: PopupMenuPosition.over,
                                child: Image(
                                  image: AssetImage(PathIcons.moreCircle),
                                  filterQuality: FilterQuality.high,
                                  height: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: MenuItem.item1,
                                      child: Text(
                                        AppLocalizations.of(context)!.delete,
                                        style: TextStyle(
                                            color: colorPrimary,
                                            fontSize:
                                            getProportionateScreenWidth(
                                                textSizeSMedium, context)),
                                      ))
                                ]),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: getShortSize(30, context),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: AppEditText(
                                  AppLocalizations.of(context)!.title,
                                  titleController ,
                                  focusNode: _focusTitle,
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
                                  onPressed: () async {
                                    if (defaultTargetPlatform == TargetPlatform.iOS) {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) => CupertinoActionSheet(
                                            actions: [
                                              SizedBox(
                                                height: 150,
                                                child: CupertinoDatePicker(
                                                  initialDateTime: _dateTime,
                                                  mode:
                                                  CupertinoDatePickerMode.date,
                                                  onDateTimeChanged: (dateTime) {
                                                    setState(() {
                                                      _dateTime = dateTime;
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                            cancelButton:
                                            CupertinoActionSheetAction(
                                              child: MyText(
                                                AppLocalizations.of(context)!.done,
                                                style: TextStyle(
                                                  color: colorPrimary,
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  dateChange = !dateChange;
                                                });

                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ));
                                    } else {
                                      DateTime? _newDate = await showDatePicker(
                                          context: context,
                                          initialDate: _dateTime,
                                          firstDate: DateTime(1800),
                                          lastDate: DateTime(3000));
                                      if (_newDate != null) {
                                        setState(() {
                                          dateChange = !dateChange;
                                          _dateTime = _newDate;
                                        });
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    Icons.calendar_month,
                                    color: colorPrimary,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    if (defaultTargetPlatform == TargetPlatform.iOS) {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) => CupertinoActionSheet(
                                            actions: [
                                              SizedBox(
                                                height: 150,
                                                child: CupertinoDatePicker(
                                                  initialDateTime: _time,
                                                  mode:
                                                  CupertinoDatePickerMode.time,
                                                  use24hFormat: true,
                                                  onDateTimeChanged: (timePicker) {
                                                    setState(() {
                                                      _time = timePicker;
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                            cancelButton:
                                            CupertinoActionSheetAction(
                                              child: MyText(
                                                AppLocalizations.of(context)!.done,
                                                style: TextStyle(
                                                  color: colorPrimary,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                timeChange = !timeChange;
                                                //platformIOS = true;
                                              },
                                            ),
                                          ));
                                    } else {
                                      TimeOfDay? _newTime = await showTimePicker(
                                        context: context,
                                        initialTime: time,
                                      );
                                      if (_newTime != null) {
                                        setState(() {
                                          // platformIOS = false;
                                          timeChange = !timeChange;
                                          time = _newTime;
                                        });
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    Icons.notifications_none,
                                    color: colorPrimary,
                                  ))
                            ],
                          ),
                          Expanded(
                              child: AppEditText(
                                AppLocalizations.of(context)!.description,
                                descriptionController,
                                focusNode: _focusDescription,
                                style: TextStyle(color: colorPrimary),
                                hintStyle: TextStyle(color: colorPrimary),
                                maxLines: 100,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              dateChange
                                  ? AppButton(
                                "${formatDate(_dateTime,"MMMd")}",
                                    () {},
                                primaryColor: colorPrimary,
                                textColor: colorWhite,
                                fontSize: textSizeSMedium,
                                borderRadius: 15,
                                paddingVertical: 4,
                              )
                                  : SizedBox.shrink(),
                              SizedBox(
                                width: getShortSize(10, context),
                              ),
                              timeChange
                                  ? AppButton(
                                "${time.hour}:${time.minute}",
                                    () {},
                                primaryColor: colorPrimary,
                                textColor: colorWhite,
                                fontSize: textSizeSMedium,
                                borderRadius: 15,
                                paddingVertical: 4,
                              )
                                  : SizedBox.shrink()
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

enum MenuItem { item1 }
