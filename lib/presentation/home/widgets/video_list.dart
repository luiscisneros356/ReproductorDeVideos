import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:verifarma/data/local_storage.dart';
import 'dart:developer' as dev;

import '../../../domain/models/models.dart';
import '../../../domain/providers/providers.dart';
import '../../utils/utils.dart';
import 'widgets.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController()..addListener(_listener);
    super.initState();
  }

  _listener() {
    final position = _controller.position;
    final maxScrollExtent = position.maxScrollExtent;
    final pixel = position.pixels + 40;
    if (pixel >= maxScrollExtent) {
      Provider.of<VideosProvider>(context, listen: false).fetchVideos();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideosProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      drawer: const RecomendedVideos(),
      appBar: AppBar(
        title: const Text('Videos'),
        actions: [
          Visibility(
            visible: !userProvider.isAnonymousUser,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(userProvider.userNickname()),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Video>>(
          future: provider.fetchVideos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.data != null) {
              final videos = snapshot.data;
              return ListViewVideos(controller: _controller, listVideos: videos!);
            }
            return const SizedBox();
          }),
      floatingActionButton: Visibility(
        visible: !userProvider.isAnonymousUser,
        child: FloatingActionButton.extended(
            icon: const Icon(Icons.video_call),
            label: Text("Subir video", style: VioFarmaStyle.title()),
            onPressed: () async {
              final video = await showDialog<Video>(context: context, builder: (context) => const SubmitVideo());

              if (video != null) {
                provider.setAddNewVideo(video);
                dev.log("${provider.listNewVideos.length} ");
                setState(() {});
              }
            }),
      ),
    );
  }
}
