import 'package:duabook/animations/fadeInAnimationBTT.dart';
import 'package:duabook/animations/fadeInAnimationTTB.dart';
import 'package:duabook/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import '../../models/namazModel.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  HijriCalendar selectedHijriDate = HijriCalendar.now();
  DateTime selectedEnglishDate = DateTime.now();

  List<NamazModel> _namazList=[
    NamazModel(time: "4:35", name: "Fajr", speakerEnabled: true),
    NamazModel(time: "5:56", name: "Sunrise", speakerEnabled: true),
    NamazModel(time: "11:53", name: "Dhuhr", speakerEnabled: true),
    NamazModel(time: "16:09", name: "Asr", speakerEnabled: true),
    NamazModel(time: "17:45", name: "Sunset", speakerEnabled: true),
    NamazModel(time: "17:50", name: "Maghrib", speakerEnabled: true),
    NamazModel(time: "19:11", name: "Ishaa", speakerEnabled: true),
  ];

  void _incrementDate() {
    // Increment the day by 1
    selectedHijriDate.hDay++;
    selectedEnglishDate = selectedEnglishDate.add(Duration(days: 1));

    // Handle month overflow (assuming month has up to 30 days)
    if (selectedHijriDate.hDay > 30) {
      selectedHijriDate.hDay = 1;
      selectedHijriDate.hMonth++;

      // Handle year overflow
      if (selectedHijriDate.hMonth > 12) {
        selectedHijriDate.hMonth = 1;
        selectedHijriDate.hYear++;
      }
    }

    setState(() {
      selectedHijriDate;
    });
    selectedHijriDate.hijriToGregorian(selectedHijriDate.hYear, selectedHijriDate.hMonth, selectedHijriDate.hDay);
    // Print the next Hijri date
    print('Next Hijri Date: ${selectedHijriDate.toFormat("dd MM yyyy")}');
  }

  void _decrementDate() {
    // Decrement the day by 1
    selectedHijriDate.hDay--;
    selectedEnglishDate = selectedEnglishDate.subtract(Duration(days: 1));

    // Handle month underflow (when day is less than 1)
    if (selectedHijriDate.hDay < 1) {
      selectedHijriDate.hMonth--;

      // Handle year underflow
      if (selectedHijriDate.hMonth < 1) {
        selectedHijriDate.hMonth = 12;
        selectedHijriDate.hYear--;
      }

      // Set the day to the last day of the previous Hijri month (assume 30 days for simplicity)
      selectedHijriDate.hDay = 30;
    }

    setState(() {
      selectedHijriDate;
    });
    selectedHijriDate.hijriToGregorian(
      selectedHijriDate.hYear,
      selectedHijriDate.hMonth,
      selectedHijriDate.hDay,
    );
    // Print the previous Hijri date
    print('Previous Hijri Date: ${selectedHijriDate.toFormat("dd MM yyyy")}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/images/prayerBg.png"))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/images/prayerLocation.png",
                      width: 45,
                      height: 50,
                    ).marginOnly(top: 12)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: rwhite,
                      size: 30,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Lahore",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: rwhite),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),

                //calender
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: _decrementDate,
                        tooltip: 'Previous Day',
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: Color(0xff2A158F),
                                ),
                                Text(
                                  "${DateFormat('EEEE').format(selectedEnglishDate)}",
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "${selectedHijriDate.toFormat("dd MMMM yyyy")}",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "${DateFormat('dd MMMM yyy').format(selectedEnglishDate)}",
                              style: TextStyle(color: rhint),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: _incrementDate,
                        tooltip: 'Next Day',
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                //namaz time
                FadeInAnimationTTB(
                  delay: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: rwhite.withOpacity(0.2),
                      border: Border.all(color: rwhite),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _namazList.length,
                        itemBuilder: (context, index) {
                        if(index==_namazList.length-1){
                          return NamazTile(_namazList[index],false);
                        }else{
                          return NamazTile(_namazList[index],true);
                        }

                        }),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                
                FadeInAnimationBTT(
                  delay: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.7,
                      height: 80,
                      decoration: BoxDecoration(
                        color: rwhite.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: rwhite)
                      ),
                      child: Divider(
                        height: 2,
                        color: rwhite,
                      ),
                    ),
                  ),
                )
              ],
            ).marginSymmetric(horizontal: 12),
          ),
        ),
      ),
    );
  }
}

class NamazTile extends StatefulWidget {
  NamazModel _namazModel;
  bool bottomLine;
  NamazTile(this._namazModel,this.bottomLine,{super.key});

  @override
  State<NamazTile> createState() => _NamazTileState();
}

class _NamazTileState extends State<NamazTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 1,
                child: Text("${widget._namazModel.time}",style: TextStyle(fontSize: 20),)),
            Expanded(
                flex: 2,
                child: Text("${widget._namazModel.name}",style: TextStyle(fontSize: 20),)),
            Expanded(
                flex: 1,
                child: Icon(widget._namazModel.speakerEnabled?Icons.volume_up_rounded:Icons.volume_mute,color: rblack,)),
          ],
        ).marginSymmetric(horizontal: 12,vertical: 8),
        if (widget.bottomLine)
        Divider(
          height: 2,
          color: rwhite,
        )
      ],
    );
  }
}

