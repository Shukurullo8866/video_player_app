import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'data/model/video_model.dart';
import 'fullVideo_screen.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  int _curendIndex = 0;
  late VideoPlayerController _controller;

  void _playVideo({int index = 0, bool init = false}) {
    if (index > 0 || index >= videos.length) return;

    if (!init) {
      _controller.pause();
    }
    setState(() => _curendIndex = index);

    _controller = VideoPlayerController.network(videos[_curendIndex].url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _videDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(":");
  }

  @override
  void initState() {
    super.initState();
    _playVideo(init: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              height: 300,
              color: Colors.black12,
              child: _controller.value.isInitialized
                  ? Stack(
                      children: [
                        SizedBox(
                          height: 200,
                          child: VideoPlayer(_controller),
                        ),
                        Positioned(
                          bottom: 95,
                          right: 6,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      FullVideoPage(controller: _controller),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.fullscreen,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          child: ValueListenableBuilder(
                              valueListenable: _controller,
                              builder:
                                  (context, VideoPlayerValue value, child) {
                                return Text(
                                  _videDuration(value.position),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                );
                              }),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 20,
                            child: VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          _videDuration(_controller.value.position),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                        Positioned(
                            bottom: 30,
                            right: 60,
                            child: IconButton(
                              onPressed: () => _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play(),
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause_circle_outline
                                    : Icons.play_circle_outline,
                                color: Colors.deepOrangeAccent,
                                size: 40,
                              ),
                            ))
                      ],
                    )
                  : CircularProgressIndicator(
                      color: Colors.white,
                    )),
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _playVideo(index: index),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(videos[index].thumbnail),
                        ),
                        SizedBox(width: 20),
                        Text(
                          videos[index].videoName,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
