import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/Models/chat_model.dart';
import 'package:whatsapp_clone/Models/message.dart';
import 'package:whatsapp_clone/views/chat_screens/messages_list.dart';
import 'package:whatsapp_clone/views/media_screens/camera_page.dart';
import 'dart:math' as math;
import 'package:whatsapp_clone/views/widgets.dart';

// ignore: must_be_immutable
class DirectMessage extends StatefulWidget {
  DirectMessage(
      {super.key,
      required this.name,
      required this.phoneNumber,
      required this.receiverId});
  String name;
  String phoneNumber;
  String receiverId;

  @override
  State<DirectMessage> createState() => _DirectMessageState();
}

class _DirectMessageState extends State<DirectMessage> {
  FocusNode focusNode = FocusNode();

  TextEditingController controller = TextEditingController();

  Widget child = Container();

  Set<MessageModel> messages = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/background.png",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Consumer<Message>(
          builder: (context, value, child) => Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
              child: Container(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                height: 70,
                color: const Color(0xFF075454),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 60,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(
                                    eccentricity: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.name.length > 9 || widget.name.length == 9
                            ? widget.name
                                .toString()
                                .replaceRange(9, null, "...")
                            : widget.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(13.0),
                              height: 50,
                              child: Image.asset(
                                "assets/video_call.png",
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            // ignore: sized_box_for_whitespace
            body: Consumer<Message>(
              builder: (context, provider, child) => SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: WillPopScope(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 60,
                        ),
                        child: Communication(
                            receiverID: widget.receiverId,
                            senderID: widget.phoneNumber),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 55,
                                child: Card(
                                  margin: const EdgeInsets.only(
                                    bottom: 8,
                                    left: 2,
                                    right: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(25),
                                  ),
                                  child: TextFormField(
                                    onTap: () {
                                      provider.onTapTextField();
                                    },
                                    controller: controller,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(5),
                                      hintText: "Message",
                                      prefixIcon: IconButton(
                                        splashRadius: 20,
                                        onPressed: () {
                                          primaryFocus!.unfocus();
                                          provider.onTapEmojiIcon();
                                        },
                                        icon: const Icon(
                                            Icons.emoji_emotions_outlined),
                                      ),
                                      prefixIconColor: Colors.grey,
                                      suffixIconColor: Colors.grey,
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            splashRadius: 20,
                                            onPressed: () {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) =>
                                                    attachSheet(context),
                                              );
                                            },
                                            icon: Transform.rotate(
                                              angle: 135 * math.pi / 180,
                                              child:
                                                  const Icon(Icons.attach_file),
                                            ),
                                          ),
                                          IconButton(
                                            splashRadius: 20,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CameraPage(),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.camera_alt),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, left: 2.0),
                                child: CircleAvatar(
                                  backgroundColor: const Color(0xFF075454),
                                  radius: 25,
                                  child: IconButton(
                                    color: Colors.white,
                                    splashRadius: 20,
                                    onPressed: () {
                                      if (provider.typing == true) {
                                        provider.sendMessage(
                                          widget.receiverId,
                                          widget.phoneNumber,
                                          controller.text,
                                        );
                                        controller.clear();
                                      }
                                    },
                                    icon: Consumer<Message>(
                                      builder: (context, provider, child) =>
                                          Icon(
                                        provider.typing == true
                                            ? Icons.send
                                            : Icons.mic,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Consumer<Message>(
                            builder: (context, provider, child) =>
                                provider.emojishow == true
                                    ? selectEmoji(context, controller)
                                    : Container(
                                        color: Colors.black,
                                      ),
                          ),
                        ],
                      )
                    ],
                  ),
                  onWillPop: () {
                    if (provider.emojishow == true) {
                      provider.onTapEmojiIcon();
                    } else {
                      Navigator.pop(context);
                    }
                    return Future.value(false);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
