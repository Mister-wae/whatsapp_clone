class ChatModel {
  String name;
  String? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  int? id;

  ChatModel({
    required this.name,
    this.icon,
    this.isGroup,
    this.time,
    this.currentMessage,
    this.id,
  });
}

class ContactModel {
  String name;
  String? normalizedNumber;
  bool? selected = false;

  ContactModel({
    required this.name,
    this.normalizedNumber,
    this.selected,
  });
}

class MessageModel {
  String text;
  String time;
  bool isSelected;
  String messagePath;
  String senderID;
  String receiverId;

  MessageModel({
    required this.isSelected,
    required this.text,
    required this.time,
    required this.messagePath,
    required this.receiverId,
    required this.senderID,
  });
}
