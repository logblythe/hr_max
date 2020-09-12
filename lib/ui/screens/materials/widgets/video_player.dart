import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/materials/learning_material_viewmodel.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<LearningMaterialViewModel>(
      model: LearningMaterialViewModel(),
      builder: (context, model, child) {
        // LearningMaterial material = model.selectedMaterial;
        return VideoWidget();
      },
    );
  }
}

class VideoWidget extends StatefulWidget {
  final String url;

  VideoWidget({Key key, this.url}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url ??
          "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/rio_from_above_compressed.mp4?raw=true"),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlickVideoPlayer(flickManager: flickManager),
    );
  }
}
