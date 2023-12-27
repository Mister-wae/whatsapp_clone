import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, required this.path});
  final String path;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(
      File(
        widget.path,
      ),
    );

    videoPlayerController.addListener(() {
      setState(() {});
    });
    videoPlayerController.setLooping(true);
    videoPlayerController.initialize().then((_) => setState(() {}));
    videoPlayerController.play();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 120,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: videoPlayerController.value.isInitialized == true
                ? AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController),
                  )
                : Container(),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: const Color(0xFF075454),
                          margin: const EdgeInsets.only(
                            bottom: 8,
                            left: 2,
                            right: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(25),
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            onTap: () {},
                            // controller: controller,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            minLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(5),
                              hintText: "Add a caption...",
                              hintStyle: const TextStyle(color: Colors.white),
                              prefixIcon: IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: const Icon(Icons.add_photo_alternate),
                              ),
                              prefixIconColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 40,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.black38,
                          ),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 40,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.black38,
                          ),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(Icons.hd_outlined),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.black38,
                          ),
                          child: IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.crop_rotate_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.black38,
                          ),
                          child: IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.sticky_note_2_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.black38,
                          ),
                          child: IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.title,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.black38,
                          ),
                          child: IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      videoPlayerController.value.isPlaying
                          ? videoPlayerController.pause()
                          : videoPlayerController.play();
                    },
                    child: CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.black38,
                      child: Icon(
                        videoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
