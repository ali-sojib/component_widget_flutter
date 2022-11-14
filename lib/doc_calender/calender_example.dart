import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {

  DateTime? startDate;
  DateTime? endDate;

  Event({this.startDate,this.endDate});

}



class AddEvent2 extends StatefulWidget {
  AddEventState2 createState() {return new AddEventState2();}
}

class AddEventState2 extends State<AddEvent2> {

  Event event = Event();
  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.enforced;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  List<DateTimeRange> dateTimeRanges = [];
  CalendarStyle style = const CalendarStyle();

  @override
  void initState() {
    super.initState();
  }



  bool isSameDay(DateTime a, DateTime b) {
    if (a == null || b == null) {
      return false;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  //checks if the list of DateTimeRanges (variable name dateTimeRanges) contains a DateTimeRange in which the day lies
  DateTimeRange? dayInRange(DateTime day) {
    List<DateTimeRange> list = dateTimeRanges.where(
            (element) =>
            element.start.isBefore(day) && element.end.isAfter(day)
                || element.start.year == day.year
                    && element.start.day == day.day
                    && element.start.month == day.month
                || element.end.year == day.year
                    && element.end.day == day.day
                    && element.end.month == day.month
    ).toList();
    return list.length > 0 ? list[0] : null;
  }

  //checks if a day is between two days
  bool isInRange(DateTime? day, DateTime? start, DateTime? end) {
    if (isSameDay(day!, start!) || isSameDay(day, end!)) {
      return true;
    }

    if (day.isAfter(start) && day.isBefore(end!)) {
      return true;
    }

    return false;
  }

  Widget getCalendar() {
    return TableCalendar(
      availableCalendarFormats: {CalendarFormat.month: 'Month'},
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(Duration(days: 365)),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) =>
          isSameDay(selectedDay!, day),
      rangeStartDay: event.startDate,
      rangeEndDay: event.endDate,
      calendarFormat: calendarFormat,
      rangeSelectionMode: rangeSelectionMode,
      calendarBuilders: CalendarBuilders(prioritizedBuilder: (context, day, focusedMonth) {
        DateTimeRange? dateTimeRange = dayInRange(day);
        //if day is in any saved DateTimeRange -> show a highlighted cell
        if(dateTimeRange != null) {
          return LayoutBuilder(
              builder: (context, constraints) {
                final shorterSide = constraints.maxHeight > constraints.maxWidth
                    ? constraints.maxWidth
                    : constraints.maxHeight;

                final children = <Widget>[];

                final isWithinRange = dateTimeRange.start != null &&
                    dateTimeRange.end != null &&
                    isInRange(day, dateTimeRange.start, dateTimeRange.end);

                final isRangeStart = isSameDay(day, dateTimeRange.start);
                final isRangeEnd = isSameDay(day, dateTimeRange.end);

                if (isWithinRange) {
                  Widget rangeHighlight = Center(
                    child: Container(
                      margin: EdgeInsetsDirectional.only(
                        start: isRangeStart ? constraints.maxWidth * 0.5 : 0.0,
                        end: isRangeEnd ? constraints.maxWidth * 0.5 : 0.0,
                      ),
                      height:
                      (shorterSide - style.cellMargin.vertical) *
                          style.rangeHighlightScale,
                      color: style.rangeHighlightColor,
                    ),
                  );
                  children.add(rangeHighlight);
                }

                Widget content=SizedBox(child: Text('Co'),);

                if (isRangeStart) {
                  content = AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    margin: style.cellMargin,
                    decoration: style.rangeStartDecoration,
                    alignment: Alignment.center,
                    child: Text('${day.day}', style: style.rangeStartTextStyle),
                  );
                } else if (isRangeEnd) {
                  content = AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      margin: style.cellMargin,
                      decoration: style.rangeEndDecoration,
                      alignment: Alignment.center,
                      child: Text('${day.day}', style: style.rangeEndTextStyle)
                  );
                } else if (isWithinRange) {
                  content = AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      margin: style.cellMargin,
                      decoration: style.withinRangeDecoration,
                      alignment: Alignment.center,
                      child: Text(
                          '${day.day}', style: style.withinRangeTextStyle)
                  );
                }

                children.add(content);


                return Stack(
                  alignment: style.markersAlignment,
                  children: children,
                  clipBehavior: style.canMarkersOverflow
                      ? Clip.none
                      : Clip.hardEdge,
                );
              });
        }
        return null;
      },),
      onDaySelected: (selDay, focDay) {
        if (!isSameDay(selectedDay!, selDay)) {
          setState(() {
            selectedDay = selectedDay;
            focusedDay = focDay;
            event.startDate =
            null; // Important to clean those
            event.endDate = null;
            rangeSelectionMode =
                RangeSelectionMode.toggledOff;
          });
        }
      },
      onRangeSelected: (start, end, focDay) {
        setState(() {
          // selectedDay =null;
          focusedDay = focDay;
          event.startDate = start;
          event.endDate = end;

          bool startDateInRange = false;
          bool endDateInRange = false;

          DateTimeRange? range = dayInRange(event.startDate!);
          if(range == null && event.endDate != null) {
            range = dayInRange(event.endDate!);
            if(range != null)
              endDateInRange = true;
          } else if(range != null) {
            startDateInRange = true;
            if(event.endDate != null && dayInRange(event.endDate!) != null)
              endDateInRange = true;
          }

          bool insertNewRange = true;

          if(startDateInRange) {
            if(isInRange(event.startDate!, range?.start, range?.end)) {
              int index = dateTimeRanges.indexOf(range!);
              if(!endDateInRange && event.endDate != null)
                dateTimeRanges[index] = DateTimeRange(start: event.startDate!, end: event.endDate!);
              else
                dateTimeRanges[index] = DateTimeRange(start: event.startDate!, end: range.end);
              insertNewRange = false;
            }
          }

          if(endDateInRange) {
            if(isInRange(event.endDate!, range?.start, range?.end)) {
              print("enddate is not null and is in range");
              int index = dateTimeRanges.indexOf(range!);
              dateTimeRanges[index] = DateTimeRange(start: event.startDate!, end: event.endDate!);
              insertNewRange = false;
            }
          }

          if(event.startDate != null && event.endDate != null && insertNewRange) {
            dateTimeRanges.add(
                DateTimeRange(start: event.startDate!, end: event.endDate!));
          }

        });
      },
      onPageChanged: (focDay) {
        focusedDay = focDay;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calendar",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    height: 400,
                    child:
                    getCalendar()
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
