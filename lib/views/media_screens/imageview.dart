import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  ImageView({super.key, required this.path});
  final String path;
  final TextEditingController captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 120,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
            ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 51,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Card(
                              color: const Color(0xFF075454),
                              margin: const EdgeInsets.only(
                                bottom: 8,
                                left: 2,
                                right: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(25),
                              ),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width - 80,
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  onTap: () {},
                                  controller: captionController,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 6,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(5),
                                    hintText: "Add a caption...",
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    prefixIcon: IconButton(
                                      splashRadius: 20,
                                      onPressed: () {},
                                      icon:
                                          const Icon(Icons.add_photo_alternate),
                                    ),
                                    prefixIconColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            const CircleAvatar(
                              radius: 21,
                              backgroundColor: Color(0xFF075454),
                              child: Icon(Icons.done_rounded),
                            )
                          ],
                        ),
                      ),
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
                            color: Color.fromARGB(101, 158, 158, 158),
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
                            color: Color.fromARGB(101, 158, 158, 158),
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
                            color: Color.fromARGB(101, 158, 158, 158),
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
                            color: Color.fromARGB(101, 158, 158, 158),
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
                            color: Color.fromARGB(101, 158, 158, 158),
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
                            color: Color.fromARGB(101, 158, 158, 158),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
