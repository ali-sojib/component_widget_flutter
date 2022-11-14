import 'dart:collection';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import '../booking_calender/model/booking_date_model.dart';
import '../utils.dart';

class AppointmentCalenderController extends GetxController{

  ///CONTROLLER DATA
  // List<DateTime> days=[];
  RxBool isIgnored = true.obs;

  List<DateTime> _finalDates = List<DateTime>.empty(growable: true).obs;
  List<DateTime> get finalDates => _finalDates;

  List<DateTime> _finalStoredDates = [DateTime(2022, 11, 29), DateTime(2022, 11, 30),];
  List<DateTime> get finalStoredDates => _finalStoredDates;

  ///NOT IN USAGE
  List<DateTime> _finalStoredDatesE =List<DateTime>.empty(growable: true).obs;
  List<DateTime> get finalStoredDatesE => _finalStoredDatesE;

  List<String> _finalDateStLs = List<String>.empty(growable: true).obs;
  List<String> get finalDateStLs => _finalDateStLs;

  ///TODO: make it dynamic latter with fatch data
  var isLoading = false.obs;

  /// Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  Set<DateTime> selectedDays() => _selectedDays;


  void storeData(data){
    GetStorage().write('finalDateStored', data);
  }


  ///TODO: doing logic for saving date in local store for shwoing date init sate when user set a date
  void getStoreData(){
    _finalStoredDates.clear();

    List<DateTime> readVal =[];
    readVal.addAll(GetStorage().read('finalDateStored'));

    _finalStoredDates.addAll(readVal);
    print('form get on ----val--- data is  $readVal');
    print('form get on length is  ${readVal.length}');

    /*for(int i=0; i<readVal.length; i++){
      _finalStoredDates.add(DateTime(readVal[i].year,readVal[i].month,readVal[i].day,));
      print('form get on data is  $_finalStoredDates');

    }*/
    print('form get on data is  $_finalStoredDates');

  }

  @override
  void onInit() {
    // getStoreData();
    print('ontinti iiiiiiiiiiiiiiiiiiiiiiiiio');
    // fetchData();
    super.onInit();
  }


// var availableDate = List<BookingDate>.empty(growable: true).obs;
/*  List<int> dateFormApi = List<int>.empty(growable: true).obs;
  List<DateTime> d = List<DateTime>.empty(growable: true).obs;

  List<String> availableTime = List<String>.empty(growable: true).obs;

  int month_id = DateTime.now().month;
  int year_id = DateTime.now().year;
  int doc_id = GetStorage().read("doc_id_store");



  void tableCalenderUpdate(int monthID, int yearID) async {
    dateFormApi.clear();
    month_id = monthID;
    year_id =yearID;
    update();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading(true);
      // var listDate = await AppointmentRemoteService.fetchApiDate(doc_id, month_id, year_id);
      List<String> listDate = ['2022-11-25','2022-11-26','2022-11-27','2022-11-28',];
      if (listDate != null) {
        print('call from fetch Data $listDate');
        *//*
        availableDate.value = listDate;
        // print('availableDateList.value list ----- value  -----controller----------------  ${availableDate}');

        //TODO make it more optimize way
        ///getting date value as int from availableDate by looping
        for (int i = 0; i < availableDate.length; i++) {
          dateFormApi.add(availableDate[i].date);
        }
        ///now adding those int value date's into DateTime format
        for (int i = 0; i < dateFormApi.length; i++) {
          d.add(DateTime(year_id, month_id, dateFormApi[i]));
        }
        // print('date :-----controller ---- $d');

        print('availableDateList.value list --------- Date ---------controller-------------  ${dateFormApi}');
        *//*
      }
    } finally {
      isLoading(false);
    }
  }*/
}