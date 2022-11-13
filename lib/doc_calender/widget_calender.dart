import 'dart:collection';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils.dart';



class DocAppointmentCalenderView extends StatefulWidget {
  DocAppointmentCalenderView({
    Key? key,
  }) : super(key: key);

  @override
  State<DocAppointmentCalenderView> createState() => _DocAppointmentCalenderViewState();
}

///adding data form api to calender with obx
///https://stackoverflow.com/questions/67866071/how-to-show-event-on-table-calendar-using-my-api-on-flutter

class _DocAppointmentCalenderViewState extends State<DocAppointmentCalenderView> {

  ///CONTROLLER DATA
  List<DateTime> d=[];
  bool isIgnored = true;

  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );


  final List<DateTime> _finalDates = [];
  List<DateTime> _finalStoredDates = [DateTime(2022,11,29),DateTime(2022,11,30),];
  List<String> _finalDateStLs=[];

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _finalStoredDates= [DateTime(2022,11,20),DateTime(2022,11,21),];
        // GetStorage().read('finalDateStored');
  }
  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  ///custom _onDaySelected
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print('CALLED             _onDaySelected                    day');
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });
    _selectedEvents.value = _getEventsForDays(_selectedDays);

    // for (DateTime d in appointmentController.d) {
    //   if (selected_Day.day == d.day && selected_Day.month == d.month && selected_Day.year == d.year) {
    //
    //     ///LATER USAGE
    //     ///Added to GetStorage KEY - appointment_date_id_store  (for LATER USAGE)
    //     GetStorage().write("appointment_date_id_store", selected_Day);
    //     Get.to(AppointmentTimePickerView(selectedDate: selected_Day));
    //
    //     setState(() {
    //       _selectedDay = selected_Day;
    //       _focusedDay = focused_Day;
    //     });
    //   }
    // }
    // if (!isSameDay(selected_Day, focused_Day)) {
    //   print('CALLED                                  inside isSameDay in daySelected');
    //   setState(() {
    //     _focusedDay = focused_Day;
    //     _selectedDay = selected_Day;
    //     // _selectedEvents = _getEventsForDay(_selectedDay);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    ///TODO: make it reusable by putting it into constant.dart file
    double displayHeight = MediaQuery.of(context).size.height;
    double displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Set Your Available Date",
              style: TextStyle(fontSize: 30),
            ),
            /*CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.multi,
                firstDate: DateTime.now(),
                lastDate: kLastDay,
                ///style
              ),
              initialValue: [],
              onValueChanged: (days){
                makeAvailableDatesList = days;
                print('makeAvailableDatesList -=> $makeAvailableDatesList');
                print('onValueChanged days - $days');
              },
            ),*/
            IgnorePointer(
              ignoring: isIgnored,
              child: TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  calendarFormat: _calendarFormat,
                  startingDayOfWeek: StartingDayOfWeek.saturday,
                  daysOfWeekHeight: 50,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                    weekendStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                  selectedDayPredicate: (day) {
                    return _selectedDays.contains(day);
                  },
                  // eventLoader: _getEventsfromDay,
                  onDaySelected: _onDaySelected,
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  weekendDays: [DateTime.friday],
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    cellMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    outsideDaysVisible: false,
                    selectedDecoration: BoxDecoration(
                      color: Colors.amberAccent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    selectedTextStyle: TextStyle(color: Colors.black),
                    todayDecoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    defaultDecoration: BoxDecoration(
                      // color: Colors.green,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    weekendDecoration: BoxDecoration(
                      // color: Colors.green,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  calendarBuilders: CalendarBuilders(
                   /* prioritizedBuilder: (context, day, focusedDay) {
                    },*/
                    defaultBuilder: (context, day, focusedDay) {
                    for (DateTime d in _finalStoredDates) {
                      if (day.day == d.day && day.month == d.month && day.year == d.year) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    }
                    return null;
                  },
                    /* selectedBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                      todayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),*/
                ),
              ),

            ),
            ElevatedButton(
              child: Text('Clear'),
              onPressed: () {
                setState(() {
                  /*_selectedDays.clear();
                  _selectedEvents.value = [];*/
                });
              },
            ),
            ElevatedButton(
              child: Text('Edit'),
              onPressed: () {
                isIgnored = false;
                _finalDates.clear();
                _finalStoredDates.clear();
                setState(() {
                  // _selectedDays.clear();
                  // _selectedEvents.value = [];
                });
              },
            ),
            IgnorePointer(
              ignoring: isIgnored,
              child: ElevatedButton (
                child: Text('Submit'),
                onPressed: () {
                  isIgnored= true;
                  _finalDates.addAll(_selectedDays);
                  _finalStoredDates.addAll(_finalDates);
                  GetStorage().write("finalDateStored", _finalStoredDates);
                  for(int i=0;i<_finalDates.length;i++){
                    final DateTime now = DateTime(_finalDates[i].year,_finalDates[i].month,_finalDates[i].day);
                    final DateFormat formatter = DateFormat('yyyy-MM-dd');
                    final String formatted = formatter.format(now);
                    print(formatted); // something like 2013-04-20
                    _finalDateStLs.add(formatted);
                  }
                  setState(() {
                    // _selectedDays.clear();
                    // _selectedEvents.value = [];
                  });
                  print('added All final dates list $_finalDateStLs');
                  print('added All final dates $_finalDates');
                },
              ),
            ),
          ],
        ),
    );
  }
}

enum CacheManagerKey { TOKEN }
