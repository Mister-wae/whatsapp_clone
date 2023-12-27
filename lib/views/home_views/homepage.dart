import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/Models/chat_model.dart';
import 'package:whatsapp_clone/views/home_views/calls.dart';
import 'package:whatsapp_clone/views/media_screens/camera_page.dart';
import 'package:whatsapp_clone/views/home_views/chats.dart';
import 'package:whatsapp_clone/views/home_views/community.dart';
import 'package:whatsapp_clone/views/home_views/updates.dart';
import 'package:whatsapp_clone/views/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    List<ChatModel> chats = [];
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          backgroundColor: const Color(0xFF075454),
          title: const Text("WhatsApp Clone"),
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
            ),
            IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            PopupMenuButton(
              iconColor: Colors.white,
              onSelected: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => value,
                  ),
                );
              },
              position: PopupMenuPosition.under,
              color: Colors.white,
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text(
                      "New group",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const PopupMenuItem(
                    value: NewBroadCast(),
                    child: Text(
                      "New broadcast",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const PopupMenuItem(
                    value: LinkedDevices(),
                    child: Text(
                      "Linked devices",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const PopupMenuItem(
                    value: StarredMessages(),
                    child: Text(
                      "Starred messages",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const PopupMenuItem(
                    value: Settings(),
                    child: Text(
                      "Settings",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ];
              },
            ),
          ],
          bottom: const TabBar(
            unselectedLabelColor: Color.fromARGB(79, 255, 253, 253),
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: Icon(Icons.groups),
              ),
              Tab(
                text: "Chats",
              ),
              Tab(
                text: "Updates",
              ),
              Tab(
                text: "Calls",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Community(),
            Chats(
              chats: chats,
              phoneNumber: phoneNumber,
            ),
            const Updates(),
            const Calls(),
          ],
        ),
      ),
    );
  }
}
