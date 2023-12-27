import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static String? keyUId = "key UID";
  static String? keyPhoneNumber = "phone number";
  static String? keyContacts = "contacts";

  static List<Contact> contacts = [];

  // ignore: prefer_const_constructors
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> storeTokens(credential, String phoneNumber) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    String uId = userCredential.user!.uid;
    await _storage.write(key: keyUId!, value: uId);

    String phoneNumber = userCredential.user!.phoneNumber!;
    await _storage.write(key: keyPhoneNumber!, value: phoneNumber);
  }

  static Future<void> storeContacts() async {
    if (await FlutterContacts.requestPermission() == true) {
      final allContacts =
          await FlutterContacts.getContacts(withProperties: true);
      contacts = allContacts;
      String contactList = jsonEncode(contacts);
      _storage.write(key: keyContacts!, value: contactList);
    }
  }

  static Future<String?> getUid() async {
    return await _storage.read(key: keyUId!);
  }

  static Future<String?> getPhoneNumber() async {
    return await _storage.read(key: keyPhoneNumber!);
  }

  static Future<String?> getContacts() async {
    return await _storage.read(key: keyContacts!);
  }

  static Future<void> clearTokens() async {
    await _storage.delete(key: keyUId!);
    await _storage.delete(key: keyPhoneNumber!);
  }
}
