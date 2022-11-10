import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';



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

  final kLastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);

  List<DateTime?> makeAvailableDatesList =[];
  List<DateTime?> dates=[];

  List<DateTime?> confirmAvailableDatesList =[];
  List<String> confirmAvailableDateListString =[];


  DateTime _selectedDay = DateTime.now();

  ///current date
  DateTime _focusedDay = DateTime.now();

  ///custom _onDaySelected
/*
  void _onDaySelected(DateTime selected_Day, DateTime focused_Day) {
    print('CALLED             _onDaySelected                    day');
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

*/


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
            CalendarDatePicker2(
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
            ),
           ElevatedButton(
               onPressed: (){
                 int i=0;
                 int cYear =0;

                 while(i<=makeAvailableDatesList.length){
                   ///TODO: add this list of dateWithTime only date in confirmAvailableDateListString
                   ///
                   /// post request will be only list of String
                   ///
                   // confirmAvailableDatesList.add(makeAvailableDatesList[i]);
                   i++;
                 }
                 confirmAvailableDatesList= makeAvailableDatesList;
                 print('confirmAvailableDatesList => $confirmAvailableDatesList');
               },
               child: Text("Confirm",)
           )
           /* TableCalendar(
                focusedDay: DateTime.now(),
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
                onDaySelected: (DateTime selected_Day, DateTime focused_Day){
                    if (!isSameDay(selected_Day, focused_Day)) {
                      print('CALLED                                  inside isSameDay in daySelected');
                      setState(() {
                        _focusedDay = focused_Day;
                        _selectedDay = selected_Day;
                        // _selectedEvents = _getEventsForDay(_selectedDay);
                      });
                    }
                },

                selectedDayPredicate: (DateTime day) {
                  ///TODO: setting up a logic to set a date dynamically from an array/list
                  ///find a way to set every single doctor have there own appointment date dynamically
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
            )*/
          ],
        ),
    );
  }
}

enum CacheManagerKey { TOKEN }
