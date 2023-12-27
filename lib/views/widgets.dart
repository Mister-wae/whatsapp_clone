import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class NewBroadCast extends StatelessWidget {
  const NewBroadCast({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New broadcast"),
      ),
    );
  }
}

class LinkedDevices extends StatelessWidget {
  const LinkedDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linked devices"),
      ),
    );
  }
}

class StarredMessages extends StatelessWidget {
  const StarredMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Starred messages"),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
    );
  }
}

Widget selectEmoji(context, TextEditingController controller) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 250,
    child: EmojiPicker(
      config: const Config(
        bgColor: Color(0xFF075454),
        columns: 7,
      ),
      onEmojiSelected: (category, emoji) {
        controller.text = controller.text + emoji.emoji;
      },
    ),
  );
}

Widget attachSheet(context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 380,
    child: Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Column(
                  children: [
                    attachButton(
                      const Icon(
                        Icons.insert_drive_file,
                        size: 30,
                      ),
                      const Color.fromARGB(255, 84, 1, 99),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Center(
                      child: Text("Document"),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    attachButton(
                      const Icon(
                        Icons.camera_alt,
                        size: 30,
                      ),
                      const Color.fromARGB(255, 233, 14, 73),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Center(
                      child: Text("Camera"),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    attachButton(
                      const Icon(
                        Icons.insert_photo,
                        size: 30,
                      ),
                      const Color.fromARGB(255, 186, 6, 218),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Center(
                      child: Text("Gallery"),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Column(
                  children: [
                    attachButton(
                      const Icon(
                        Icons.headphones_rounded,
                        size: 30,
                      ),
                      const Color.fromARGB(255, 229, 83, 15),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Center(
                      child: Text("Audio"),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    attachButton(
                      const Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                      const Color.fromARGB(255, 1, 99, 6),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Center(
                      child: Text("Location"),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    attachButton(
                      const Icon(
                        Icons.person,
                        size: 32,
                      ),
                      const Color.fromARGB(255, 8, 96, 147),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Center(
                      child: Text("Contact"),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Column(
                  children: [
                    attachButton(
                      Transform.flip(
                        flipX: true,
                        child: const Icon(
                          Icons.bar_chart,
                          size: 30,
                        ),
                      ),
                      const Color.fromARGB(255, 2, 120, 81),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Center(
                      child: Text("Poll"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget attachButton(icon, color) {
  return CircleAvatar(
    radius: 30,
    foregroundColor: Colors.white,
    backgroundColor: color,
    child: icon,
  );
}

Widget buttonCard(child, title, trailing, subtitle) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: const Color(0xFF075454),
      child: child,
    ),
    title: Text(title),
    subtitle: subtitle,
    trailing: trailing,
  );
}

Widget ownMessage(
  context,
  String text,
  String time,
) {
  return Align(
    alignment: Alignment.centerRight,
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 45,
      ),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: const Color(0xffdcf8c6),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 10,
                right: 30,
                top: 5,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 10,
              child: Row(
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.done_all,
                    size: 19,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget replyCard(context, String text, String time) {
  return Align(
    alignment: Alignment.centerLeft,
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 45,
      ),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 50,
                top: 5,
                bottom: 10,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 10,
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
