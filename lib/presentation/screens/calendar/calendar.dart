import 'dart:math';

import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';

import '../../../utils/my_material.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<DateTime> tacks = [];
  List<DateTime> tacksReminder = [];

  void fetchNewEvents(int year, int month) async {
    Random random = Random();
    final tacksItems = List<DateTime>.generate(random.nextInt(30), (i) {
      return DateTime(year, month, random.nextInt(20) + 1);
    });

    final tacksReminderItems = List<DateTime>.generate(random.nextInt(40), (i) {
      return DateTime(year, month, random.nextInt(27) + 3);
    });
    setState(() => tacks.addAll(tacksItems));
    setState(() => tacksReminder.addAll(tacksReminderItems));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(paddingMedium),
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
                  MyText(AppLocalizations.of(context)!.calendar,
                      style: TextStyle(
                          color: colorPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: getProportionateScreenWidth(
                              textSizeMedium, context))),
                  SizedBox.shrink(),
                ],
              ),
            ),
            Expanded(
              child: PagedVerticalCalendar(
                addAutomaticKeepAlives: true,
                onMonthLoaded: fetchNewEvents,
                dayBuilder: (context, date) {
                  final tacksDay = tacks.where((e) => e == date);
                  final tacksReminderDay =
                      tacksReminder.where((e) => e == date);
                  return Column(
                    children: [
                      Text(
                        DateFormat('d').format(date),
                        style: TextStyle(color: colorBlack),
                      ),
                      Wrap(
                        children: tacksDay.map((event) {
                          return Padding(
                            padding: const EdgeInsets.all(1),
                            child: CircleAvatar(
                                radius: 3, backgroundColor: colorPrimary),
                          );
                        }).toList(),
                      ),
                      Wrap(
                        children: tacksReminderDay.map((event) {
                          return Padding(
                            padding: const EdgeInsets.all(1),
                            child: CircleAvatar(
                                radius: 3, backgroundColor: colorSecondary),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
                onDayPressed: (day) {
                  final eventsOvulatoryDay = tacks.where((e) => e == day);
                  print('items this day: $eventsOvulatoryDay');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
