import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/providers/providers.dart';
import '../../utils/text_style.dart';
import 'widgets.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                height: 50,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text("Videos Recomendados", style: VioFarmaStyle.title(color: Colors.white))),
            ...recomendedVideos.map(
              (video) => Column(
                children: [
                  CustomVideoPlayer(video: video, visible: false),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Visibility(
                visible: recomendedVideos.isEmpty,
                child: Column(
                  children: const [
                    SizedBox(height: 84),
                    Center(
                      child: Text(
                          "Lo sentimos, en este momento no encontramos recomendaciones para los videos que votaste"),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
