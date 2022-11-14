import 'dart:collection';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component_draft_project/doc_calender/controller_getx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../booking_calender/loading.dart';
import '../utils.dart';


class DocAppointmentCalenderView extends StatefulWidget {
  DocAppointmentCalenderView({
    Key? key,
  }) : super(key: key);

  @override
  State<DocAppointmentCalenderView> createState() => _DocAppointmentCalenderViewState();
}

class _DocAppointmentCalenderViewState extends State<DocAppointmentCalenderView> {

  AppointmentCalenderController _calenderController = Get.put(AppointmentCalenderController());


  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);


  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _finalStoredDates = [DateTime(2022, 11, 20), DateTime(2022, 11, 21),];
    // GetStorage().read('finalDateStored');
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

/*  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }*/

/*
  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }
*/

  ///custom _onDaySelected
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print('CALLED             _onDaySelected                    day');
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_calenderController.selectedDays().contains(selectedDay)) {
        _calenderController.selectedDays().remove(selectedDay);
      } else {
        _calenderController.selectedDays().add(selectedDay);
      }
    });
    // _selectedEvents.value = _getEventsForDays(_selectedDays);

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
    double displayHeight = MediaQuery
        .of(context)
        .size
        .height;
    double displayWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: Obx(() {
        if (_calenderController.isLoading.value) {
          return const CustomLoading();
        } else {
          return Column(
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
                  ignoring: _calenderController.isIgnored.value,
                  child: TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    calendarFormat: CalendarFormat.month,
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
                      return _calenderController.selectedDays().contains(day);
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
                        for (DateTime d in _calenderController.finalStoredDates) {
                          if (day.day == d.day && day.month == d.month && day.year == d.year) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  child: Text('Edit'),
                  onPressed: () {
                    _calenderController.isIgnored(false);
                    _calenderController.finalDates.clear();
                    // _calenderController.finalStoredDates.clear();
                    _calenderController.finalDateStLs.clear();
                    // setState(() {
                    //   // _selectedDays.clear();
                    //   // _selectedEvents.value = [];
                    // });
                  },
                ),
                IgnorePointer(
                  ignoring: _calenderController.isIgnored.value,
                  child: ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      _calenderController.isIgnored(true);
                      _calenderController.finalDates.addAll(_calenderController.selectedDays());
                      _calenderController.finalStoredDates.addAll(_calenderController.finalDates);
                      GetStorage().write("finalDateStored", _calenderController.finalStoredDates);

                      /*
                      for (int i = 0; i < _calenderController.finalDates.length; i++) {
                        final DateTime now = DateTime(
                            _calenderController.finalDates[i].year,
                            _calenderController.finalDates[i].month,
                            _calenderController.finalDates[i].day);
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final String formatted = formatter.format(now);
                        print(formatted); // something like 2013-04-20
                        _calenderController.finalDateStLs.add(formatted);
                      }*/
                      // setState(() {
                      //   // _selectedDays.clear();
                      //   // _selectedEvents.value = [];
                      // });
                      // print('added All final dates list ${_calenderController.finalDateStLs}');
                      print('added All final dates ${_calenderController.finalDates}        ///////////////////////');

                      print('added All final dates ${_calenderController.finalStoredDates}');

                    },
                  ),
                ),
                ///TODO: doing logic for saving date in local store for shwoing date init sate when user set a date
                ElevatedButton(
                  child: Text('Get Stored datee'),
                  onPressed: () {
                    // _calenderController.getStoreData();
                    /*setState(() {
                      _selectedDays.clear();
                    _selectedEvents.value = [];
                    });*/
                  },
                ),
              ],
            );
        }
      }),
    );
  }
}

enum CacheManagerKey { TOKEN }
