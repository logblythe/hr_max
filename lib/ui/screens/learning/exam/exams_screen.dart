import 'dart:isolate';
import 'dart:ui';

import 'package:hrmax/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hrmax/network/models/learning_tracker_res.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/learning/exam/exams_view_model.dart';
import 'package:hrmax/ui/screens/learning/exam/widgets/exam_card.dart';

class ExamsScreen extends StatefulWidget {
  @override
  _ExamsScreenState createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  ExamsViewModel _model;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      if (debug) {
        print('UI Isolate Callback: $data');
      }
      //for reference
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status == DownloadTaskStatus.complete) {
        _model.onDownloadComplete();
        FlutterDownloader.open(taskId: id);
      } else if (status == DownloadTaskStatus.failed) {
        _model.onDownloadFailed();
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exams')),
      body: BaseWidget<ExamsViewModel>(
        model: ExamsViewModel(),
        onModelReady: (model) {
          _model = model;
          model.getLearningTrackers();
        },
        builder: (context, model, child) {
          if (model.loading) {
            return Center(child: CircularProgressIndicator());
          }
          List<LearningTrackerRes> learningTrackers = model.learningTrackers;
          return learningTrackers.length > 0
              ? Container(
                  color: Colors.grey.withAlpha(25),
                  child: ListView.builder(
                    itemCount: learningTrackers.length,
                    itemBuilder: (context, index) {
                      return ExamCard(
                        downloading: learningTrackers[index].downloading,
                        tracker: learningTrackers[index],
                        onProcess: () =>
                            model.handleProceed(learningTrackers[index]),
                        onInstructions: () =>
                            model.handleInstructions(learningTrackers[index]),
                        onViewMaterials: () =>
                            model.handleViewMaterials(learningTrackers[index]),
                        onDownloadCertificate: () => model
                            .handleDownloadCertificate(learningTrackers[index]),
                      );
                    },
                  ),
                )
              : Container();
        },
      ),
    );
  }
}
