import 'dart:convert';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_clone/Models/auth_utils.dart';

class Contacts {
  static List<dynamic> contactList = [];

  static Future<void> getContacts() async {
    String? contacts = await SecureStorage.getContacts();

    List contactsList = jsonDecode(contacts!);

    contactsList.insertAll(0, [
      Contact(id: "1"),
      Contact(id: "2"),
      Contact(id: "3"),
    ]);

    contactList = contactsList;
  }
}
// ContactModel(
//   name: contact["displayName"],
//   normalizedNumber: contact["phones"][0]["normalizedNumber"],
//   selected: false,
// )
