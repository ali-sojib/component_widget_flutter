import 'package:http/http.dart' as http;

import '../model/booking_date_model.dart';

class AppointmentRemoteService {
  static var client = http.Client();

  //https://banana.hackules.com/hiar/ali/?doc_id=3&date=30-10-2022
  // https://banana.hackules.com/hiar/ali/?doc_id=3&date=30-10-2022
  //https://banana.hackules.com/hiar/md/?doc_id=3&month=10&year=2022.


  ///TODO: problem with api
  ///is the date's will increase or decrease then HOWW will model class handle it
  ///coz once the model PODO class created based on api it will be constant
  ///it can be dynamic using fixed like 24 dates available now some date are null and some dates are available
  ///
  static Future<List<BookingDate>?> fetchApiDate(int doc_id, int month_id, year_id) async {
    var response = await client.get(
      Uri.parse('https://banana.hackules.com/hiar/md/?doc_id=$doc_id&month=$month_id&year=$year_id')
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;

      print('getting api data : +++++++++------ $jsonString');
      // List<String> responsee = jsonString as List<String>;

      return bookingDateFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
