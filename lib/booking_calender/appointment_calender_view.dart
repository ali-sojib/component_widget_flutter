import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'appointment_time_picker.dart';
import 'controller/booking_controller_demo.dart';
import 'loading.dart';

class AppointmentCalenderView extends StatefulWidget {
  AppointmentCalenderView({
    Key? key,
  }) : super(key: key);

  @override
  State<AppointmentCalenderView> createState() => _AppointmentCalenderViewState();
}

///adding data form api to calender with obx
///https://stackoverflow.com/questions/67866071/how-to-show-event-on-table-calendar-using-my-api-on-flutter

class _AppointmentCalenderViewState extends State<AppointmentCalenderView> {

  AppointmentBookingDateController appointmentController = Get.put(AppointmentBookingDateController());

  ///TODO: helpful for requesting an appointment to api
  Future<String?> postAppointmentOnApi(doc, date, time) async {
    final box = GetStorage();
    final token = box.read(CacheManagerKey.TOKEN.toString());
    var response = await http.post(Uri.parse("https://banana.hackules.com/kheyal/tele/appointment/"),
        body: {"doc_id": doc, "date": date, "time": time}, headers: {"Authorization": "Token $token"});
    // List<DateTime> d= [];
    // for(int i=0;i<bookingDateController.dateFormApi.length;i++){
    //   d.add(DateTime(2022,10,bookingDateController.dateFormApi[i]));
    // }
    // late List<DateTime> toHighlightDate;
    // toHighlightDates.add(DateTime(DateTime.now().year,DateTime.now().month, bookingDateController.dateFormApi.forEach((element) { })))

    // late List<DateTime> toHighlightDa =
    //       bookingDateController.dateFormApi.forEach(
    //               (element) {
    //                 DateTime(2022,10,element);
    //                 },
    //       );.
    return response.reasonPhrase;
  }


  // late Map<DateTime, List<Event>> _selectedEvents;
  final kLastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);

  late List<DateTime> toHighlightDate;

  DateTime _selectedDay = DateTime.now();

  ///current date
  DateTime _focusedDay = DateTime.now();
  // DateTime(2022,12,10);

  // TextEditingController _eventController = TextEditingController();

  ///custom _onDaySelected
  void _onDaySelected(DateTime selected_Day, DateTime focused_Day) {
    print('CALLED             _onDaySelected                    day');
    for (DateTime d in appointmentController.d) {

      if (selected_Day.day == d.day
          && selected_Day.month == d.month
          && selected_Day.year == d.year) {

        ///LATER USAGE
        ///Added to GetStorage KEY - appointment_date_id_store  (for LATER USAGE)
        GetStorage().write("appointment_date_id_store", selected_Day);
        // Get.to(AppointmentTimePickerView(selectedDate: selected_Day));

        setState(() {
          _selectedDay = selected_Day;
          _focusedDay = focused_Day;
        });
      }

    }
    if (!isSameDay(selected_Day, focused_Day)) {
      print('CALLED                                  inside isSameDay in daySelected');
      setState(() {
        _focusedDay = focused_Day;
        _selectedDay = selected_Day;
        // _selectedEvents = _getEventsForDay(_selectedDay);
      });
    }
  }

  /// Function deciding whether given day should be enabled or not.
  /// If `false` is returned, this day will be disabled.
  /* bool _isDayAvailable(DateTime day) {
    // int i =0;
    // print('CALLED               _isDayAvailable $i from getting date $day');
    // i++;
    ///////setting up a logic to set a date dynamically from an array/list
    ///find a way to set every single doctor have there own appointment date dynamically
    ///not possible to set an array of date time its just a true false value can be passed
    ///NONONONONONONOONONONNO      NONONO              NONONONONONO
    // int ch = day.compareTo(DateTime.now());
    // if(ch==1){
    //   print('CALLED inside logic _isDayAvailable');
    //   return true;
    // }
    print('CALLED form before true _isDayAvailable ---');
    return true;
  }*/

  @override
  void initState() {
    // _selectedEvents = {};
    super.initState();
  }

/*  List<Event> _getEventsfromDay(DateTime date) {
    ///TODO: getting event form specific date
    return _selectedEvents[date] ?? [];
  }*/

  @override
  void dispose() {
    // _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///TODO: make it reusable by putting it into constant.dart file
    double displayHeight = MediaQuery.of(context).size.height;
    double displayWidth = MediaQuery.of(context).size.width;

    // for(int i=0;i<bookingDateController.availableDateList.length;i++){
    //   toHighlightDate.add(DateTime(2022,3,int.parse(bookingDateController.availableDateList[i])));
    // }
    // print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh          $toHighlightDates');
    ///these are making problem for red screen
    // print('got the time-------view-----${bookingDateController.availableDate[0].times[0]}');

    // List<DateTime> d= [];
    // for(int i=0;i<bookingDateController.dateFormApi.length;i++){
    //   d.add(DateTime(2022,10,bookingDateController.dateFormApi[i]));
    // }
    // print('date :--------- $d');
    ///these are making problem for red screen
    // print('date :--- view------ ${bookingDateController.d}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white12,
        title: Container(
            height: displayHeight*.08,
            alignment: Alignment.centerLeft,
            child:const Text('Book Appointment ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black12
              ),
            )
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            "Book Your Appointment",
            style: TextStyle(fontSize: 30),
          ),

          // Text('Date : ${bookingDateController.availableDate[1].date} '),
          // SingleChildScrollView(
          //   scrollDirection: Axis.vertical,
          //   child: Column(
          //     children: List.generate(
          //       bookingDateController.availableDate[0].times.length,
          //           (index) =>
          //           Padding(
          //             padding: const EdgeInsets.symmetric(vertical: 5),
          //             child: Text('Time:  ${bookingDateController.availableDate[0].times[index]}'),
          //           ),
          //     ),
          //   ),
          // ),
/*          GetBuilder<AppointmentBookingDateController>(builder: (_){
            if (appointmentController.isLoading.value) {
              return const CustomLoading();
            } else {
              return TableCalendar(
                /// Function deciding whether given day should be enabled or not.
                /// If `false` is returned, this day will be disabled.
                // enabledDayPredicate:  _isDayAvailable,
                focusedDay: _focusedDay,
                firstDay: DateTime.now(),
                lastDay: kLastDay,
                onHeaderTapped: (headerTapped) {
                  print('header tapped = $headerTapped');
                },
                calendarFormat: CalendarFormat.month,
                // holidayPredicate: (day) {
                //   // Every 20th day of the month will be treated as a holiday
                //   return day.day == 20;
                // },
                startingDayOfWeek: StartingDayOfWeek.saturday,
                daysOfWeekHeight: 50,
                daysOfWeekStyle: DaysOfWeekStyle(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.redAccent),
                ),

                ///Day Changed
                onDaySelected: _onDaySelected,

                selectedDayPredicate: (DateTime day) {
                  ///TODO: setting up a logic to set a date dynamically from an array/list
                  ///find a way to set every single doctor have there own appointment date dynamically
                  ///
                  ///
                  ///
                  ///
                  ///
                  ///
                  print('CALLED From selectedDayPredicate $day');
                  return isSameDay(_focusedDay, day);
                },

                // eventLoader: _getEventsfromDay,

                //To style the Calendar
                weekendDays: [DateTime.friday],
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  cellMargin:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                onPageChanged: (pageChangedVal){
                  appointmentController.month_id= pageChangedVal.month;
                  print('get data from onPagedChanged ------------'
                      '----------------------${appointmentController.month_id}');

                  // appointmentBookingDateController.update();
                  CustomLoading();

                  appointmentController.tableCalenderUpdate(pageChangedVal.month, pageChangedVal.year);

                  // _onCalenderPageChanged(pageChangedVal.month, pageChangedVal.year);
                },

                ///for Custom UI with CalendarBuilders
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    for (DateTime d in appointmentController.d) {
                      if (day.day == d.day &&
                          day.month == d.month &&
                          day.year == d.year) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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


                ),

              );
            }
          })*/
          ///TODO: problem is getting the specific date date by controller but
          ///DONE
          Obx(() {
            if (appointmentController.isLoading.value) {
              return const CustomLoading();
            } else {
              return TableCalendar(
                /// Function deciding whether given day should be enabled or not.
                /// If `false` is returned, this day will be disabled.
                // enabledDayPredicate:  _isDayAvailable,
                focusedDay: _focusedDay,
                firstDay: DateTime.now(),
                lastDay: kLastDay,
                onHeaderTapped: (headerTapped) {
                  print('header tapped = $headerTapped');
                },
                calendarFormat: CalendarFormat.month,
                // holidayPredicate: (day) {
                //   // Every 20th day of the month will be treated as a holiday
                //   return day.day == 20;
                // },
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
                ///Day Changed
                onDaySelected: _onDaySelected,

                selectedDayPredicate: (DateTime day) {
                  ///TODO: setting up a logic to set a date dynamically from an array/list
                  ///find a way to set every single doctor have there own appointment date dynamically
                  ///
                  ///
                  ///
                  ///
                  ///
                  ///
                  // print('CALLED From selectedDayPredicate $day');
                  return isSameDay(_focusedDay, day);
                },

                // eventLoader: _getEventsfromDay,

                //To style the Calendar
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
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),

                onPageChanged: (pageChangedVal) {
                  _focusedDay = pageChangedVal;
                  appointmentController.month_id = pageChangedVal.month;
                  print('get data from onPagedChanged ------------'
                      '----------------------${appointmentController.month_id}');
                  // appointmentBookingDateController.update();
                  CustomLoading();
                  appointmentController.tableCalenderUpdate(pageChangedVal.month, pageChangedVal.year);
                  // _onCalenderPageChanged(pageChangedVal.month, pageChangedVal.year);
                },

                ///for Custom UI with CalendarBuilders
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    for (DateTime d in appointmentController.d) {
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
                          color: Theme.of(context).primaryColor,
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
              );
            }
          }),
        ],
      ),
    );
  }
}

enum CacheManagerKey { TOKEN }
