import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/media_screens/imageview.dart';
import 'package:whatsapp_clone/views/media_screens/videoview.dart';

List<CameraDescription>? cameras;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 185,
                child: FutureBuilder(
                  future: cameraValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(_cameraController);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Color.fromARGB(20, 158, 158, 158),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.photo,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onLongPress: () async {
                        await _cameraController.startVideoRecording();
                        setState(() {
                          isRecording = true;
                        });
                      },
                      onLongPressUp: () async {
                        final video2 =
                            await _cameraController.stopVideoRecording();
                        final path = video2.path;

                        setState(() {
                          isRecording = false;
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoView(
                              path: path,
                            ),
                          ),
                        );
                      },
                      onTap: () {
                        if (isRecording == false) {
                          takephoto(context);
                        }
                      },
                      child: isRecording
                          ? Container(
                              padding: const EdgeInsets.all(40),
                              width: isRecording ? 120 : 80,
                              height: isRecording ? 120 : 80,
                              decoration: const ShapeDecoration(
                                color: Colors.transparent,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                              ),
                              child: const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 12,
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              width: isRecording ? 120 : 80,
                              height: isRecording ? 120 : 80,
                              decoration: const ShapeDecoration(
                                color: Colors.transparent,
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                              ),
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                              ),
                            ),
                    ),
                    Container(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Color.fromARGB(20, 158, 158, 158),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          setState(() {
                            isCameraFront = !isCameraFront;
                            int cameraPos = isCameraFront ? 0 : 1;
                            transform + pi;
                            _cameraController = CameraController(
                                cameras![cameraPos], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          });
                        },
                        icon: Transform.rotate(
                          angle: transform,
                          child: const Icon(
                            Icons.flip_camera_android,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 170,
              )
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          flash = !flash;
                        });
                        flash
                            ? _cameraController.setFlashMode(FlashMode.torch)
                            : _cameraController.setFlashMode(FlashMode.off);
                      },
                      icon: flash
                          ? const Icon(
                              Icons.flash_on_sharp,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.flash_off_outlined,
                              color: Colors.white,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takephoto(context) async {
    final image = await _cameraController.takePicture();
    final path = image.path;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageView(path: path),
      ),
    );
  }
}
