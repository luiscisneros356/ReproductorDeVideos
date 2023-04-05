// ignore: file_names
import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import 'widgets.dart';

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

        return CustomVideoPlayer(video: video, visible: true);
      },
      itemCount: _listVideos.length,
      separatorBuilder: (context, _) => const SizedBox(height: 50.0),
    );
  }
}
