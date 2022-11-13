/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kheyal/brick/accountEdit/AccountModel.dart';
import 'package:kheyal/brick/home/home_screen.dart';
import 'package:kheyal/components/custom_widget.dart';
import 'package:kheyal/nav_screen.dart';
import '../brick/offlineAppointmentHistory/view.dart';
import '../constants.dart';

class AppointmentFormView extends StatefulWidget {
  AppointmentFormView({Key? key, required this.selectedDateTime, required this.timeVal}) : super(key: key);

  DateTime selectedDateTime;
  String timeVal;

  @override
  State<AppointmentFormView> createState() => _AppointmentFormViewState();
}

class _AppointmentFormViewState extends State<AppointmentFormView> {

  ProfileController profileController = Get.find();

  Map<int, String> weekName = {1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday", 5: "Friday", 6: "Saturday", 7: "Sunday"};
  //        '{ "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" }';
  Map<int, String> monthName = {1: "January", 2: "February", 3: "March", 4: "April", 5: "May", 6: "June", 7: "July", 8:"August", 9:"September", 10:"October", 11:"November", 12:"Dismember", 13:"Error"};
  //        '{ "1" : "Jan", "2" : "Feb", "3" : "Mar", "4" : "Apr", "5" : "May",
  late String appointmentTimeDetails =
  '''${weekName[widget.selectedDateTime.weekday]}, ${monthName[widget.selectedDateTime.month]} ${widget.selectedDateTime.day}, ${widget.selectedDateTime.year}''';

  late String appointmentTime = widget.timeVal;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController = TextEditingController(text: profileController.profileModel.value.first_name);
  late TextEditingController ageController = TextEditingController(text: profileController.profileModel.value.first_name);
  late TextEditingController genderController = TextEditingController(text: profileController.profileModel.value.first_name);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ///TODO: make it reusable by putting it into constant.dart file
    double displayHeight = MediaQuery.of(context).size.height;
    double displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text('Appointment Form', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
            SizedBox(height: 15),
            Divider(thickness: 1),
            Row(
              children: [
                Icon(Icons.access_time_filled_sharp),
                SizedBox(width: 10),
                Text(appointmentTime),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 10),
                Flexible(child: Text(appointmentTimeDetails, style: TextStyle())),
              ],
            ),
            SizedBox(height: 10),
            Divider(thickness: 1),
            Container(
              height: displayHeight*.65,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Enter Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    CustomTextField(
                        controller: nameController,
                        titleText: 'Name',
                        hintText: 'Enter you name ',
                    ),
                    CustomTextField(
                        controller: ageController,
                        titleText: 'Age',
                        hintText: 'Enter you age '
                    ),
                    CustomTextField(
                        controller: genderController,
                        titleText: 'Gender',
                        hintText: 'Enter you Gender '
                    ),
                    SizedBox(height: 50),
                    CustomSubmitButton(
                      btnText: ' Submit ',
                      onClick: () {
                        if(_formKey.currentState!.validate()){
                          print('onclicked on appoinment date->time->form----submit');
                          Get.defaultDialog(
                              title: "Submitted",
                              titleStyle: const TextStyle(height: 0),
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/alert_icon/check-mark.png"),
                                  SizedBox(height: 20),
                                  const Text("Submitted", style: TextStyle(fontSize: 25))
                                ],
                              ),
                              backgroundColor: appBarBgColor,
                              barrierDismissible: false,
                              textConfirm: 'Ok',
                              buttonColor: primaryColor,
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                print('  Get.defaultDialog clicked from Submit');
                                Get.offAll(NavScreen());
                              });
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    )
    );
  }
}
*/
