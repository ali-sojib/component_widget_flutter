import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/booking_date_model.dart';
import '../services/api_service.dart';

class AppointmentBookingDateController extends GetxController {
  var isLoading = true.obs;
  var availableDate = List<BookingDate>.empty(growable: true).obs;
  List<int> dateFormApi = List<int>.empty(growable: true).obs;
  List<DateTime> d = List<DateTime>.empty(growable: true).obs;
  List<String> availableTime = List<String>.empty(growable: true).obs;


  int month_id = DateTime.now().month;
  int year_id = DateTime.now().year;
  int doc_id = GetStorage().read("doc_id_store");

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

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
      var listDate = await AppointmentRemoteService.fetchApiDate(doc_id, month_id, year_id);
      if (listDate != null) {
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
      }
    } finally {
      isLoading(false);
    }
  }
}
