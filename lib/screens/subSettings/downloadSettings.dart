import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class DownloadSettings extends StatefulWidget {
  const DownloadSettings({super.key});

  @override
  State<DownloadSettings> createState() => _DownloadSettingsState();
}

class _DownloadSettingsState extends State<DownloadSettings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Downloads",
                style: TextStyle(color: rblack, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.88,
                  decoration:
                      BoxDecoration(color: rpurple, borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Audio files",style: TextStyle(fontSize: 21,color: rblack),).marginOnly(top: 20),
                        SizedBox(height: 40,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          height: 70,
                          decoration: BoxDecoration(
                            color: rpink,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Icon(Icons.file_present_rounded,color: rpurple,)),
                              Expanded(
                                  flex: 2,
                                  child: Text("Young Boy arabic",style: TextStyle(color: rtext),)),
                              Expanded(child: Icon(Icons.download,color: rpurple,)),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          height: 70,
                          decoration: BoxDecoration(
                              color: rgreen,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Icon(Icons.file_present_rounded,color: rpurple,)),
                              Expanded(
                                  flex: 2,
                                  child: Text("Teacher and Kid",style: TextStyle(color: rtext),)),
                              Expanded(child: Icon(Icons.download,color: rpurple,)),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          height: 70,
                          decoration: BoxDecoration(
                              color: rblueshade,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Icon(Icons.file_present_rounded,color: rpurple,)),
                              Expanded(
                                  flex: 2,
                                  child: Text("Urdu",style: TextStyle(color: rtext),)),
                              Expanded(child: Icon(Icons.download,color: rpurple,)),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          height: 70,
                          decoration: BoxDecoration(
                              color: ryellow,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Icon(Icons.file_present_rounded,color: rpurple,)),
                              Expanded(
                                  flex: 2,
                                  child: Text("English",style: TextStyle(color: rtext),)),
                              Expanded(child: Icon(Icons.download,color: rpurple,)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
