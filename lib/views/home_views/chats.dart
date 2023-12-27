import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Models/auth_utils.dart';
import 'package:whatsapp_clone/Models/chat_model.dart';
import 'package:whatsapp_clone/Models/contacts.dart';
import 'package:whatsapp_clone/views/chat_screens/direct_message.dart';
import 'package:whatsapp_clone/views/select_contact.dart';
import 'dart:math' as math;
import 'package:whatsapp_clone/views/widgets.dart';

// ignore: must_be_immutable
class Chats extends StatelessWidget {
  Chats({super.key, required this.chats, required this.phoneNumber});
  List<ChatModel> chats;
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    SecureStorage.storeContacts();
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DirectMessage(
                    name: chats[index].name,
                    phoneNumber: phoneNumber,
                    receiverId: "",
                  ),
                ),
              );
            },
            child: buttonCard(
              const Icon(Icons.person),
              chats[index].name,
              null,
              null,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 15,
          );
        },
        itemCount: chats.length,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: const Color(0xFF075454),
        child: Transform.flip(
          flipY: true,
          child: Transform.rotate(
            angle: 270 * math.pi / 180,
            child: const Icon(
              Icons.message_rounded,
              size: 28,
            ),
          ),
        ),
        onPressed: () async {
          await Contacts.getContacts().then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectContact(phoneNumber: phoneNumber),
              ),
            );
          });
        },
      ),
    );
  }
}
