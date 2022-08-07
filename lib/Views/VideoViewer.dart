import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends StatefulWidget {
  String vidlink = "";

  VideoViewer({Key? key, required this.vidlink}) : super(key: key);

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  late VideoPlayerController vidcontroller;
  late ChewieController chewcontroller;

  @override
  void initState() {
    vidcontroller = VideoPlayerController.network(widget.vidlink);
    super.initState();
  }

  @override
  void dispose() {
    vidcontroller.dispose();
    chewcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: vidcontroller.initialize(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if(snapshot.connectionState==ConnectionState.done){
            chewcontroller=ChewieController(videoPlayerController: vidcontroller,autoPlay: true,aspectRatio:MediaQuery.of(context).size.height/MediaQuery.of(context).size.width);
            return Chewie(controller: chewcontroller);
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
