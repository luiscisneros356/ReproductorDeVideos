import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/models.dart';
import '../../../domain/providers/providers.dart';
import '../../utils/utils.dart';
import 'dialogs.dart';
import 'widgets.dart';

class RatingScale extends StatefulWidget {
  const RatingScale({super.key, required this.video, required this.visible});

  final Video video;
  final bool visible;

  @override
  State<RatingScale> createState() => _RatingScaleState();
}

class _RatingScaleState extends State<RatingScale> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideosProvider>(context);

    return Container(
      color: Colors.greenAccent,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.video.title.toUpperCase(),
            style: VioFarmaStyle.title(color: Colors.black, isBold: true),
          ),
          const SizedBox(height: 12),
          Text(widget.video.description, style: VioFarmaStyle.subTitle()),
          const SizedBox(height: 12),
          Column(
            children: [
              Row(
                children: [
                  ...List.generate(widget.video.roundedStarRating, (index) => const StarsRating()),
                ],
              ),
              Visibility(
                visible: widget.visible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomContainer(height: 24, width: 48, text: "${widget.video.currenteRankingPoint}", onTap: () {}),
                    const SizedBox(width: 24),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconRating(
                          onTap: () {
                            provider.setVideo(widget.video);
                            provider.incrementRanking();
                          },
                          icon: Icons.arrow_drop_up_outlined,
                        ),
                        IconRating(
                            onTap: () {
                              provider.setVideo(widget.video);
                              provider.decrementRanking();
                            },
                            icon: Icons.arrow_drop_down)
                      ],
                    ),
                    const SizedBox(width: 24),
                    CustomContainer(
                        onTap: () async {
                          provider.setVideo(widget.video, true);

                          if (provider.showRecomendation) {
                            await showCustomDialog(
                              context,
                              text: "Deseas ver más videos recomendados para a vos",
                              onPressedNo: () => Navigator.pop(context),
                              onPressedSI: () {
                                Navigator.pop(context);
                                Scaffold.of(context).openDrawer();
                              },
                            );
                          }
                          widget.video.currenteRankingPoint = 0;
                          setState(() {});
                        },
                        height: 24,
                        width: 60,
                        text: "RATE",
                        color: Colors.white,
                        backgroundColor: Colors.orange)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
