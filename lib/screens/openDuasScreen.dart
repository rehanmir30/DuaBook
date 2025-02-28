import 'package:audioplayers/audioplayers.dart';
import 'package:duabook/constants/colors.dart';
import 'package:duabook/controller/categoryDetailController.dart';
import 'package:duabook/controller/userController.dart';
import 'package:duabook/models/duaModel.dart';
import 'package:duabook/models/subCategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../database/initDb.dart';

class OpenDuasScreen extends StatefulWidget {
  final SubCategoryModel _subCategoryModel;

  const OpenDuasScreen(this._subCategoryModel, {super.key});

  @override
  State<OpenDuasScreen> createState() => _OpenDuasScreenState();
}

class _OpenDuasScreenState extends State<OpenDuasScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // Singleton Audio Player
  String? _currentlyPlayingPath; // Track currently playing audio

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> markDuaAsDone(int duaId,done) async {
    try {
      Database db = await initializeDb();
      await db.update(
        'sentence',
        {'done': "1"},
        where: 'id = ?',
        whereArgs: [duaId],
      );
      if(done==false){
        int availablePoints=Get.find<UserController>().points;
        availablePoints=availablePoints+50;
        Get.find<UserController>().setPoints(availablePoints);
      }


      print("Dua with ID $duaId marked as done.");
    } catch (e) {
      print("Error updating Dua status: $e");
    }
  }


  /// Toggles Play/Stop for Audio and Marks as Done When Completed
  void _toggleAudio(String path, int duaId,bool done) async {
    if (_currentlyPlayingPath == path) {
      await _audioPlayer.stop();
      setState(() {
        _currentlyPlayingPath = null;
      });
    } else {
      await _audioPlayer.stop(); // Stop previous audio
      await _audioPlayer.play(AssetSource(path));

      setState(() {
        _currentlyPlayingPath = path;
      });

      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          _currentlyPlayingPath = null;
        });

        markDuaAsDone(duaId,done);
      });
    }
  }


  @override
  void initState() {
    // getDone();
  }

  getDone()async{
    Database db = await initializeDb();

    List<Map<String, dynamic>> duas = await db.query(
      'sentence',
      where: 'done = ?',
      whereArgs: ["1"],
    );
    List<DuaModel> _list = [];
    for (var item in duas) {
      DuaModel dua=DuaModel.fromJson(item);
      print(dua.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<CategoryDetailController>(builder: (catDetailController) {
          return ListView.builder(
            itemCount: catDetailController.duas.length,
            itemBuilder: (context, index) {
              return DuaTile(
                dua: catDetailController.duas[index],
                currentlyPlayingPath: _currentlyPlayingPath,
                onToggle: _toggleAudio,
              );
            },
          );
        }));
  }
}

class DuaTile extends StatelessWidget {
  final DuaModel dua;
  final String? currentlyPlayingPath;
  final Function(String, int,bool) onToggle;

  const DuaTile({
    required this.dua,
    required this.currentlyPlayingPath,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String audioPath = dua.arabicAudio;
    bool isPlaying = currentlyPlayingPath == audioPath;

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: rpink,
        ),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => onToggle(audioPath, dua.id,dua.done==null?false:true),
                  child: Icon(
                    isPlaying ? Icons.stop_circle : Icons.play_circle,
                    color: dua.done!=null?Colors.grey:Color(0xff2A158F),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${dua.arabicText}",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: rblack, fontSize: 23),
                  ),
                ),
              ],
            ).marginAll(15),
            Divider(height: 2, color: rwhite),
            Text(
              "${dua.tranlitration}",
              textAlign: TextAlign.start,
              style: TextStyle(color: rblack, fontSize: 20),
            ).marginAll(15),
            Divider(height: 2, color: rwhite),
            Text(
              "${dua.getTranslatedText(Get.locale?.languageCode ?? 'english')}",
              textAlign: TextAlign.start,
              style: TextStyle(color: rblack, fontSize: 20),
            ).marginAll(15),
          ],
        ),
      ),
    ).marginSymmetric(horizontal: 12, vertical: 8);
  }
}
