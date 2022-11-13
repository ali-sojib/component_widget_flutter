/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kheyal/booking_calender/appointment_from.dart';
import 'package:kheyal/booking_calender/controller/booking_controller_demo.dart';

import '../constants.dart';

class AppointmentTimePickerView extends StatelessWidget {
  AppointmentTimePickerView({Key? key, required this.selectedDate,}) : super(key: key);

  ///TODO: Error But till now working as accepted
  ///E/flutter (16275): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception:
  /// Converting object to an encodable object failed: Instance of 'DateTime'
  AppointmentBookingDateController controller = Get.find();

  DateTime? selectedDate;

  Map<int, String> weekName = {1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday", 5: "Friday", 6: "Saturday", 7: "Sunday"};
  //        '{ "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" }';
  Map<int, String> monthName = {1: "January", 2: "February", 3: "March", 4: "April", 5: "May", 6: "June", 7: "July", 8:"August", 9:"September", 10:"October", 11:"November", 12:"Dismember", 13:"Error"};
  //        '{ "1" : "Jan", "2" : "Feb", "3" : "Mar", "4" : "Apr", "5" : "May",


  @override
  Widget build(BuildContext context) {

    int i = 0;
    while(controller.dateFormApi.length>i){
        if(selectedDate!.day== controller.dateFormApi[i]){
          ///TODO: Error But till now working as accepted
          ///E/flutter (16275): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception:
          /// Converting object to an encodable object failed: Instance of 'DateTime'
          /// CAN BE FIXED HERE DON'T KNOW
          controller.availableTime = controller.availableDate[i].times;
          print('-------------------------- TIME--------------------------------------------------------'
              '-----------------${controller.availableDate[i].times}');
        }
        i++;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Text('${DateFormat('       EEEE,\n MMM d , yyyy').format(widget.selectedDate!)}',style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 50,),
            Text('${weekName[selectedDate!.weekday]}',style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${monthName[selectedDate!.month]}  '),
                Text('${selectedDate!.day} '),
                Text('${selectedDate!.year}'),
              ],
            ),
            Divider(thickness: 1),
            Text('Select Time',style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(
                  controller.availableTime.length,
                      (index) =>  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: backgroundColor,
                            side: BorderSide(width:1, color:primaryColor),
                            elevation: .5,
                          ),
                          onPressed: (){
                            print('CALLED  time button at ${controller.availableTime[index].toString()}');

                            ///LATER USAGE
                            ///Added to GetStorage KEY - appointment_time_id_store  (for LATER USAGE)
                            GetStorage().write("appointment_time_id_store", controller.availableTime[index].toString());
                            Get.to(AppointmentFormView(selectedDateTime: selectedDate!, timeVal: controller.availableTime[index]));
                          },
                          child: Text(
                              controller.availableTime[index],
                              style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                ),
              ),
            )
          ],
        ),
      )
      // Center(child: Text(widget.dateTime.toString())),
    );
  }
}



*/
