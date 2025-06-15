import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:duabook/constants/colors.dart';
import 'package:duabook/controller/categoryDetailController.dart';
import 'package:duabook/controller/userController.dart';
import 'package:duabook/models/duaModel.dart';
import 'package:duabook/models/subCategoryModel.dart';
import 'package:ffmpeg_kit_flutter_full/ffmpeg_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<void> markDuaAsDone(int duaId, done) async {
    try {
      Database db = await initializeDb();
      await db.update(
        'sentence',
        {'done': "1"},
        where: 'id = ?',
        whereArgs: [duaId],
      );
      if (done == false) {
        int availablePoints = Get.find<UserController>().points;
        availablePoints = availablePoints + 50;
        Get.find<UserController>().setPoints(availablePoints);
      }

      print("Dua with ID $duaId marked as done.");
    } catch (e) {
      print("Error updating Dua status: $e");
    }
  }

  void _toggleAudio(String path, int duaId, bool done) async {
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

        markDuaAsDone(duaId, done);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<CategoryDetailController>(
        builder: (catDetailController) {
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
        },
      ),
    );
  }
}

class DuaTile extends StatefulWidget {
  final DuaModel dua;
  final String? currentlyPlayingPath;
  final Function(String, int, bool) onToggle;

  const DuaTile({
    required this.dua,
    required this.currentlyPlayingPath,
    required this.onToggle,
    super.key,
  });

  @override
  State<DuaTile> createState() => _DuaTileState();
}

class _DuaTileState extends State<DuaTile> {
  final FlutterSoundRecord _recorder = FlutterSoundRecord();
  bool _isRecording = false;
  String? _recordedPath;

  void _openRecordingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String? apiResponse;
        bool _isLoading = false;

        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> sendToApi() async {
              if (_recordedPath == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please record audio first")),
                );
                return;
              }

              setState(() => _isLoading = true);

              try {
                var uri = Uri.parse('http://3.140.226.122:3400/transcribe/?ARABIC_AYAH=${widget.dua.arabicText}');
                // var uri = Uri.parse('http://3.140.226.122:3400/transcribe/?ARABIC_AYAH=رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِنْ لِسَانِي يَفْقَهُوا قَوْلِي');
                print(widget.dua.arabicText);
                print(_recordedPath);
                var request = http.MultipartRequest('POST', uri);
                request.files.add(
                  await http.MultipartFile.fromPath(
                    'audio_file',
                    _recordedPath!,
                    contentType: MediaType('audio', 'mp3'),
                  ),
                );

                request.headers.addAll({
                  'accept': 'text/html',
                  'Content-Type': 'multipart/form-data',
                });

                var response = await request.send();
                var responseBody = await response.stream.bytesToString();

                setState(() {
                  apiResponse = responseBody;
                  print(apiResponse);
                });
              } catch (e) {
                setState(() {
                  apiResponse = "Error: $e";
                });
              } finally {
                setState(() => _isLoading = false);
              }
            }

            Future<void> toggleRecording() async {
              if (_isRecording) {
                final path = await _recorder.stop();
                setState(() => _isRecording = false);
                if (path != null) {
                  _recordedPath = path;
                  String? mp3Path = await convertAacToMp3(_recordedPath!);
                  print("Recording complete: $mp3Path");
                  _recordedPath = mp3Path; // update to mp3 path
                  await sendToApi();
                }
              } else {
                var status = await Permission.microphone.request();
                if (status.isGranted) {
                  final hasPermission = await _recorder.hasPermission();
                  if (hasPermission) {
                    final dir = await getTemporaryDirectory();
                    final filePath = p.join(dir.path, '${DateTime.now().millisecondsSinceEpoch}.aac');
                    await _recorder.start(path: filePath, encoder: AudioEncoder.AAC);
                    setState(() {
                      _isRecording = true;
                      _recordedPath = filePath;
                    });
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Microphone permission is required.")),
                  );
                }
              }
            }

            return AlertDialog(
              title: const Text("Audio Recorder"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child:
                          // Text("رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِنْ لِسَانِي يَفْقَهُوا قَوْلِي",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                          Text(
                        "${widget.dua.arabicText}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  if (_isLoading) CircularProgressIndicator(),
                  if (apiResponse != null) ...[
                    const SizedBox(height: 16),
                    Text("Response:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Html(data: "${apiResponse}"),
                    ),
                    // Text(apiResponse!, textAlign: TextAlign.start),
                  ],
                  Text(_isRecording ? "Recording..." : "Ready to record"),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: toggleRecording,
                  child: Text(_isRecording ? "Finish Recording" : "Start Recording"),
                ),
                TextButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['mp3'],
                    );
                    if (result != null && result.files.single.path != null) {
                      setState(() {
                        _recordedPath = result.files.single.path!;
                      });
                      await sendToApi();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No file selected")),
                      );
                    }
                  },
                  child: const Text("Upload MP3"),
                ),
                TextButton(
                  onPressed: () async {
                    if (_isRecording) {
                      await _recorder.stop();
                      setState(() => _isRecording = false);
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<String?> convertAacToMp3(String inputPath) async {
    final outputPath = inputPath.replaceAll('.aac', '.mp3');

    final session = await FFmpegKit.execute(
      '-i "$inputPath" -codec:a libmp3lame -qscale:a 2 "$outputPath"',
    );

    final file = File(outputPath);
    if (await file.exists()) {
      return outputPath;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String audioPath = widget.dua.arabicAudio;
    bool isPlaying = widget.currentlyPlayingPath == audioPath;

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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => widget.onToggle(audioPath, widget.dua.id, widget.dua.done == true),
                      child: Icon(
                        isPlaying ? Icons.stop_circle : Icons.play_circle,
                        color: widget.dua.done == true ? Colors.grey : Color(0xff2A158F),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: _openRecordingDialog,
                      child: Icon(
                        Icons.mic,
                        color: Color(0xff2A158F),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    "${widget.dua.arabicText}",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: rblack, fontSize: 23),
                  ),
                ),
              ],
            ).marginAll(15),
            Divider(height: 2, color: rwhite),
            Text(
              "${widget.dua.tranlitration}",
              textAlign: TextAlign.start,
              style: TextStyle(color: rblack, fontSize: 20),
            ).marginAll(15),
            Divider(height: 2, color: rwhite),
            Text(
              "${widget.dua.getTranslatedText(Get.locale?.languageCode ?? 'english')}",
              textAlign: TextAlign.start,
              style: TextStyle(color: rblack, fontSize: 20),
            ).marginAll(15),
          ],
        ),
      ),
    ).marginSymmetric(horizontal: 12, vertical: 8);
  }
}
