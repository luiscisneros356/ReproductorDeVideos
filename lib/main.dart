// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:verifarma/data/user_loggin_repository.dart';
import 'package:verifarma/data/video_repository.dart';
import 'package:verifarma/domain/providers/user_provider.dart';
import 'package:verifarma/domain/providers/videos_provider.dart';
import 'package:verifarma/domain/video_model.dart';
import 'package:verifarma/presentation/auth_screen.dart';
import 'package:verifarma/presentation/utils/text_style.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'dart:developer' as dev;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideosProvider(VideoRepository())),
        ChangeNotifierProvider(create: (_) => UserProvider(UserLogginRepository()))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ViofarmaApp(),
    );
  }
}

class ViofarmaApp extends StatelessWidget {
  const ViofarmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // initVideos();
    });

    super.initState();
  }

  _listener() {
    final position = _controller.position;
    final maxScrollExtent = position.maxScrollExtent;
    final pixel = position.pixels + 40;
    if (pixel >= maxScrollExtent) {
      dev.log("LLEGOO");
      Provider.of<VideosProvider>(context, listen: false).fetchVideos();
      setState(() {});

      //  initVideos(true);
    }
  }

  // Future<void> initVideos([bool addMore = false]) async {
  //   final provider = Provider.of<VideosProvider>(context, listen: false);

  //   _listVideos = await provider.fetchVideos();
  //   dev.log("${_listVideos.length}");
  //   if (addMore) {
  //     final moreVideos = await provider.fetchVideos();
  //     _listVideos.addAll([...moreVideos]);
  //     setState(() {});

  //     dev.log("${_listVideos.length}");
  //   }

  //   if (mounted) setState(() {});
  // }

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

class SubmitVideo extends StatefulWidget {
  const SubmitVideo({
    super.key,
  });

  @override
  State<SubmitVideo> createState() => _SubmitVideoState();
}

class _SubmitVideoState extends State<SubmitVideo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? title;
  String? description;
  String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Container(
          height: 300,
          width: 500,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTexField(
                  hint: "Nombre",
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      title = value;
                      return null;
                    }
                    return "Campo vacio";
                  },
                ),
                CustomTexField(
                  hint: "Descripción",
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      description = value;
                      return null;
                    }
                    return "Campo vacio";
                  },
                ),
                CustomTexField(
                  hint: "URL",
                  validator: (value) {
                    if (value != null && value.isNotEmpty && value.contains("https://www.youtube.com")) {
                      url = value;
                      return null;
                    }
                    return "URL no válida";
                  },
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.save();

                        if (_formKey.currentState?.validate() ?? false) {
                          Video video = Video.empty();
                          Navigator.pop(context, video.copyWith(title: title, description: description, url: url));
                        }
                      },
                      child: const Text("Subir video")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTexField extends StatelessWidget {
  const CustomTexField(
      {super.key,
      required this.hint,
      required this.validator,
      this.isInLoggin = false,
      this.showIcon = false,
      this.obscureText = false,
      this.onTap});
  final String hint;
  final bool isInLoggin;
  final bool showIcon;
  final bool obscureText;
  final VoidCallback? onTap;

  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: isInLoggin ? hint : "$hint del video",
          contentPadding: const EdgeInsets.all(8),
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: showIcon ? const Icon(Icons.remove_red_eye) : const Icon(Icons.abc, size: 1),
          )),
      validator: validator,
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

        return CustomVideoPlayer(video: video, visible: true);
      },
      itemCount: _listVideos.length,
      separatorBuilder: (context, _) => const SizedBox(height: 50.0),
    );
  }
}

class CustomVideoPlayer extends StatelessWidget {
  const CustomVideoPlayer({super.key, required this.video, required this.visible});

  final Video video;
  final bool visible;

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
        RatingScale(video: video, visible: visible)
      ],
    );
  }
}

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
                            await showCustomDialog(context);
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

Future<void> showCustomDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(
              "Deseas ver mas videos recomendados para a vos",
              style: VioFarmaStyle.title(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("NO"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Scaffold.of(context).openDrawer();
                },
                child: const Text("SI"),
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
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(width: 1)),
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

class StarsRating extends StatelessWidget {
  const StarsRating({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.star, color: Colors.orange);
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
