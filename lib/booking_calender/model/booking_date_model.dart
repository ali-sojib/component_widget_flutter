import 'dart:convert';

// List<String> bookingDataFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));
//
// String bookingDataToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));


///extra

// Map<String, List<String>> bookingdataFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x))));
//
// String bookingdataToJson(Map<String, List<String>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))));

///main
List<BookingDate> bookingDateFromJson(String str) => List<BookingDate>.from(json.decode(str).map((x) => BookingDate.fromJson(x)));

String bookingDateToJson(List<BookingDate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingDate {
  BookingDate({
    required this.date,
    required this.times,
  });

  int date;
  List<String> times;

  factory BookingDate.fromJson(Map<String, dynamic> json) => BookingDate(
    date: json["date"],
    times: List<String>.from(json["times"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "times": List<dynamic>.from(times.map((x) => x)),
  };
}
