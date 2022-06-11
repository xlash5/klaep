import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../widgets/myScreen.dart';
import '../data/dummy_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController(initialPage: 0);
  late VideoPlayerController? _controller;
  late VideoPlayerController? _controller2;

  void _initController(String link) {
    _controller = VideoPlayerController.asset(link,
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
        ))
      ..initialize().then((_) {
        setState(() {});
        _controller!.setLooping(true);
        _controller!.setVolume(1.0);
        _controller!.play();
      });
  }

  void _initController2(String link) {
    _controller2 = VideoPlayerController.asset(link,
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
        ))
      ..initialize().then((_) {
        setState(() {});
        _controller2!.setLooping(true);
        _controller2!.setVolume(1.0);
        _controller2!.play();
      });
  }

  Future<void> _startVideoPlayer(String link) async {
    if (_controller == null) {
      _initController(link);
    } else {
      final oldController = _controller;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController?.dispose();
        _initController(link);
      });
      setState(() {
        _controller = null;
      });
    }
  }

  Future<void> _startVideoPlayer2(String link) async {
    if (_controller2 == null) {
      _initController2(link);
    } else {
      final oldController2 = _controller2;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController2?.dispose();
        _initController2(link);
      });
      setState(() {
        _controller2 = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initController('assets/drums.mp4');
    _initController2('assets/drums.mp4');
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      myScreen(context, _controller, _controller2, Colors.red),
      myScreen(context, _controller, _controller2, Colors.blue),
      myScreen(context, _controller, _controller2, Colors.green),
    ];

    return Scaffold(
        body: SafeArea(
      child: PageView(
        scrollDirection: Axis.vertical,
        controller: controller,
        onPageChanged: (index) {
          _startVideoPlayer(dummyMap[index]['video1']);
          _startVideoPlayer2(dummyMap[index]['video2']);
        },
        children: pages,
      ),
    ));
  }
}
