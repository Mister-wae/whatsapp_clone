import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_clone/Models/auth_utils.dart';
import 'package:whatsapp_clone/Models/chat_model.dart';
import 'package:whatsapp_clone/views/home_views/homepage.dart';
import 'package:whatsapp_clone/views/sign_up.dart';

class Message extends ChangeNotifier {
  bool emojishow = false;
  bool attachshow = false;
  bool typing = false;
  bool underline = false;
  Widget openingPge = const SignUpScreen();
  bool onTapSearch = false;
  bool dailPad = false;
  List<Contact> contactsList = [
    Contact(id: "1"),
    Contact(id: "2"),
    Contact(id: "3"),
  ];
  bool messageColor = false;
  void onTapEmojiIcon() {
    emojishow = !emojishow;
    // typing = false;
    notifyListeners();
  }

  void onTapDailPadIcon() {
    dailPad = !dailPad;
    notifyListeners();
  }

  void onTapSearchIcon() {
    onTapSearch = !onTapSearch;
    notifyListeners();
  }

  void onTapTextField() {
    emojishow = false;
    typing = true;
    notifyListeners();
  }

  void onTapOutsideTextField() {
    typing = false;

    notifyListeners();
  }

  void sendMessage(String receiverId, String phoneNumber, String controller) {
    FirebaseFirestore.instance.collection("DirectMessage").add(
      {
        "messagePath": "$phoneNumber:$receiverId",
        "senderID": phoneNumber,
        "receiverId": receiverId,
        "text": controller,
        "time": DateTime.now().toString().substring(10, 16),
      },
    );
    notifyListeners();
  }

  void receiveMessage(messageList, Set<MessageModel> messages) {
    messages.clear();
    for (var message in messageList!) {
      Set<MessageModel> messageHere = {};
      messageHere.add(
        MessageModel(
            isSelected: false,
            messagePath: message["messagePath"],
            receiverId: message["receiverId"],
            senderID: message["senderID"],
            text: message["text"],
            time: message["time"]),
      );
      messages.addAll(messageHere);
    }
    notifyListeners();
  }

  void onTapUnderlineText() {
    underline = true;
    notifyListeners();
  }

  Future<void> signIn() async {
    String? uId = await SecureStorage.getUid();
    String? phoneNumber = await SecureStorage.getPhoneNumber();

    if (uId != null && phoneNumber != null) {
      openingPge = HomePage(phoneNumber: phoneNumber);
    } else {
      openingPge = const SignUpScreen();
    }
    notifyListeners();
  }

  void messageLongPress(index) {
    messageColor = true;
    notifyListeners();
  }
}
