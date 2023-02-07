import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullVideoPage extends StatefulWidget {
  const FullVideoPage({Key? key, required this.controller}) : super(key: key);
  final VideoPlayerController controller;
  @override
  State<FullVideoPage> createState() => _FullVideoPageState();
}

class _FullVideoPageState extends State<FullVideoPage> {
  Future _landscupeMode() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  Future _setAllOrantation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState() {
    super.initState();
    _landscupeMode();
  }

  @override
  void dispose() {
    super.dispose();
    _setAllOrantation();
  }

  @override
  Widget build(BuildContext context) => VideoPlayer(widget.controller);
}
