// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verifarma/data/video_repository.dart';
import 'package:verifarma/domain/providers.dart';
import 'package:verifarma/domain/video_model.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'dart:developer' as dev;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideosProvider(VideoRepository()),
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: VideoList(),
      ),
    );
  }
}

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List<Video> _listVideos = [];
  late ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController()..addListener(_listener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initVideos();
    });

    super.initState();
  }

  _listener() {
    final position = _controller.position;
    final maxScrollExtent = position.maxScrollExtent;
    final pixel = position.pixels + 40;
    if (pixel >= maxScrollExtent) {
      dev.log("LLEGOO");

      initVideos(true);
    }
  }

  Future<void> initVideos([bool addMore = false]) async {
    final provider = Provider.of<VideosProvider>(context, listen: false);

    _listVideos = await provider.fetchVideos();
    dev.log("${_listVideos.length}");
    if (addMore) {
      final moreVideos = await provider.fetchVideos();
      _listVideos.addAll([...moreVideos]);
      setState(() {});

      dev.log("${_listVideos.length}");
    }

    _listVideos.forEach((video) {
      video.controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(video.url)!,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ));
    });

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const RecomendedVideos(),
      appBar: AppBar(
        title: const Text('Lista de Videos'),
      ),
      body: ListViewVideos(controller: _controller, listVideos: _listVideos),
    );
  }
}

class ListViewVideos extends StatelessWidget {
  const ListViewVideos({
    super.key,
    required ScrollController controller,
    required List<Video> listVideos,
  })  : _controller = controller,
        _listVideos = listVideos;

  final ScrollController _controller;
  final List<Video> _listVideos;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _controller,
      itemBuilder: (context, index) {
        final video = _listVideos[index];

        return CustomVideoPlayer(video: video);
      },
      itemCount: _listVideos.length,
      separatorBuilder: (context, _) => const SizedBox(height: 50.0),
    );
  }
}

class CustomVideoPlayer extends StatelessWidget {
  const CustomVideoPlayer({
    super.key,
    required this.video,
  });

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YoutubePlayer(
          key: ObjectKey(video.id),
          controller: video.controller!,
          actionsPadding: const EdgeInsets.only(left: 16.0),
          bottomActions: [
            CurrentPosition(),
            const SizedBox(width: 10.0),
            ProgressBar(isExpanded: true),
            const SizedBox(width: 10.0),
            RemainingDuration(),
            FullScreenButton(),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(video.title.toUpperCase()),
            Column(
              children: [
                Row(
                  children: [
                    ...List.generate(video.roundedStarRating, (index) => StarsRating(tapRating: true)),
                  ],
                ),
                RatingScale(video: video)
              ],
            ),
          ],
        )
      ],
    );
  }
}

class RecomendedVideos extends StatelessWidget {
  const RecomendedVideos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final recomendedVideos = Provider.of<VideosProvider>(context).recomendedVideos;
    return Drawer(
      width: 320,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Videos Recomendados"),
            ...recomendedVideos.map((video) => CustomVideoPlayer(video: video))
          ],
        ),
      ),
    );
  }
}

class RatingScale extends StatelessWidget {
  const RatingScale({super.key, required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideosProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomContainer(height: 24, width: 48, text: "${video.currenteRankingPoint}", onTap: () {}),
        const SizedBox(width: 24),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconRating(
              onTap: () {
                provider.setVideo(video);
                provider.incrementRanking();
              },
              icon: Icons.arrow_drop_up_outlined,
            ),
            IconRating(
                onTap: () {
                  provider.setVideo(video);
                  provider.decrementRanking();
                },
                icon: Icons.arrow_drop_down)
          ],
        ),
        const SizedBox(width: 24),
        CustomContainer(
            onTap: () async {
              provider.setVideo(video, true);
              await Future.delayed(const Duration(seconds: 1));
              if (provider.showRecomendation) {
                await showCustomDialog(context);
              }
            },
            height: 24,
            width: 60,
            text: "RATE",
            color: Colors.white,
            backgroundColor: Colors.orange)
      ],
    );
  }
}

Future<void> showCustomDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text("Deseas ver mas videos recomendados para a vos"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("NO"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Scaffold.of(context).openDrawer();
                },
                child: Text("SI"),
              ),
            ],
          ));
}

class CustomContainer extends StatelessWidget {
  CustomContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.onTap,
      this.backgroundColor,
      this.color});

  final double height;
  final double width;
  String text;
  Color? color;
  Color? backgroundColor;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.all(Radius.circular(6)), border: Border.all(width: 1)),
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}

class IconRating extends StatelessWidget {
  const IconRating({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, size: 36),
    );
  }
}

class StarsRating extends StatefulWidget {
  StarsRating({super.key, this.tapRating = false});
  bool tapRating;
  @override
  State<StarsRating> createState() => _StarsRatingState();
}

class _StarsRatingState extends State<StarsRating> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.tapRating = !widget.tapRating;
        setState(() {});
      },
      child: widget.tapRating ? Icon(Icons.star) : Icon(Icons.star_border),
    );
  }
}
