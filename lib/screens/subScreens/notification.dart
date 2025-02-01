import 'package:duabook/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool soundSwitch = false;
  bool vibrationSwitch = false;
  bool notificationSwitch = false;
  bool emailSwitch = false;
  bool morningSwitch = false;
  bool eveningSwitch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: rpurple.withOpacity(0.5),
        body: Column(
          children: [
            // Header
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              color: rwhite,
              alignment: Alignment.center,
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: rtext,
                ),
              ),
            ),
            // Centered Content
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: rwhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.volume_up_rounded, color: Color(0xff2A158F)),
                              Expanded(
                                child: Text(
                                  "Sound",
                                  style: TextStyle(fontSize: 17),
                                ).marginSymmetric(horizontal: 12),
                              ),
                              Switch(
                                value: soundSwitch,
                                onChanged: (value) {
                                  setState(() {
                                    soundSwitch = value;
                                  });
                                },
                                activeTrackColor: rpurpleShade,
                                activeColor: rwhite,
                                inactiveThumbColor: rwhite,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ],
                          ).marginSymmetric(horizontal: 20),
                          Divider(height: 2, color: rhint),
                          Row(
                            children: [
                              Icon(Icons.vibration, color: Color(0xff2A158F)),
                              Expanded(
                                child: Text(
                                  "Vibration",
                                  style: TextStyle(fontSize: 17),
                                ).marginSymmetric(horizontal: 12),
                              ),
                              Switch(
                                value: vibrationSwitch,
                                onChanged: (value) {
                                  setState(() {
                                    vibrationSwitch = value;
                                  });
                                },
                                activeTrackColor: rpurpleShade,
                                activeColor: rwhite,
                                inactiveThumbColor: rwhite,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ],
                          ).marginSymmetric(horizontal: 20),
                          Divider(height: 2, color: rhint),
                          Row(
                            children: [
                              Icon(Icons.notifications, color: Color(0xff2A158F)),
                              Expanded(
                                child: Text(
                                  "Push Notifications",
                                  style: TextStyle(fontSize: 17),
                                ).marginSymmetric(horizontal: 12),
                              ),
                              Switch(
                                value: notificationSwitch,
                                onChanged: (value) {
                                  setState(() {
                                    notificationSwitch = value;
                                  });
                                },
                                activeTrackColor: rpurpleShade,
                                activeColor: rwhite,
                                inactiveThumbColor: rwhite,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ],
                          ).marginSymmetric(horizontal: 20),
                          Divider(height: 2, color: rhint),
                          Row(
                            children: [
                              Icon(Icons.mail, color: Color(0xff2A158F)),
                              Expanded(
                                child: Text(
                                  "Email Notification",
                                  style: TextStyle(fontSize: 17),
                                ).marginSymmetric(horizontal: 12),
                              ),
                              Switch(
                                value: emailSwitch,
                                onChanged: (value) {
                                  setState(() {
                                    emailSwitch = value;
                                  });
                                },
                                activeTrackColor: rpurpleShade,
                                activeColor: rwhite,
                                inactiveThumbColor: rwhite,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ],
                          ).marginSymmetric(horizontal: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 20), // Spacer between sections
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: rpurple,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Morning Duas Reminder",style: TextStyle(color: rwhite,fontSize: 17),),
                              Switch(
                                value: morningSwitch,
                                onChanged: (value) {
                                  setState(() {
                                    morningSwitch = value;
                                  });
                                },
                                activeTrackColor: rpurpleShade,
                                activeColor: rwhite,
                                inactiveThumbColor: rwhite,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ],
                          ).marginSymmetric(horizontal: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Evening Duas Reminder",style: TextStyle(color: rwhite,fontSize: 17),),
                              Switch(
                                value: eveningSwitch,
                                onChanged: (value) {
                                  setState(() {
                                    eveningSwitch = value;
                                  });
                                },
                                activeTrackColor: rpurpleShade,
                                activeColor: rwhite,
                                inactiveThumbColor: rwhite,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ],
                          ).marginSymmetric(horizontal: 20)
                        ],
                      )
                    ),
                  ],
                ).marginSymmetric(horizontal: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
