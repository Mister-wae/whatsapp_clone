import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/Models/contacts.dart';
import 'package:whatsapp_clone/Models/message.dart';
import 'package:whatsapp_clone/views/chat_screens/direct_message.dart';
import 'package:whatsapp_clone/views/widgets.dart';

// ignore: must_be_immutable
class SelectContact extends StatefulWidget {
  SelectContact({super.key, required this.phoneNumber});
  String phoneNumber;

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  final ScrollController contactListController = ScrollController();
  final ScrollController searchListController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  List filteredContacts = [];
  double _avatarSize = 100.0;

  void _animateAvatar() {
    setState(() {
      _avatarSize =
          _avatarSize == 100.0 ? 150.0 : 100.0; // Toggle between two sizes
    });
  }

  @override
  void initState() {
    super.initState();
    filteredContacts = Contacts.contactList.sublist(3);
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredContacts = Contacts.contactList
          .sublist(3)
          .where(
              (contact) => contact["displayName"].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Message>(
      builder: (context, provider, child) => Scaffold(
        appBar: provider.onTapSearch
            ? PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 100),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 2,
                    left: 10,
                    right: 10,
                    top: 25,
                  ),
                  child: Container(
                    height: 50,
                    decoration: ShapeDecoration(
                        color: const Color.fromARGB(193, 227, 227, 227),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              Provider.of<Message>(context, listen: false)
                                  .onTapSearchIcon();
                            },
                            splashRadius: 20,
                            icon: const Icon(Icons.arrow_back_outlined),
                          ),
                        ),
                        Flexible(
                          flex: 7,
                          child: Consumer<Message>(
                            builder: (context, provider, child) => TextField(
                              cursorColor: Colors.green,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              controller: searchController,
                              keyboardType:
                                  Provider.of<Message>(context).dailPad
                                      ? TextInputType.text
                                      : TextInputType.phone,
                              autofocus: true,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: provider.dailPad
                              ? IconButton(
                                  splashRadius: 20,
                                  onPressed: () async {
                                    Provider.of<Message>(context, listen: false)
                                        .onTapDailPadIcon();
                                  },
                                  icon: const Icon(Icons.dialpad_rounded),
                                )
                              : IconButton(
                                  splashRadius: 20,
                                  onPressed: () async {
                                    Provider.of<Message>(context, listen: false)
                                        .onTapDailPadIcon();
                                    Future.delayed(
                                      const Duration(seconds: 1),
                                    ).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  icon: const Icon(Icons.keyboard_alt_outlined),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : AppBar(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF075454),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select contact",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${Contacts.contactList.length.toString()} contacts",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      Provider.of<Message>(context, listen: false)
                          .onTapSearchIcon();
                    },
                    icon: const Icon(Icons.search),
                  ),
                  PopupMenuButton(
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
                          // value: NewGroup(),
                          child: Text(
                            "Invite a friend",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const PopupMenuItem(
                          // value: NewBroadCast(),
                          child: Text(
                            "Contacts",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const PopupMenuItem(
                          // value: LinkedDevices(),
                          child: Text(
                            "Refresh",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const PopupMenuItem(
                          // value: StarredMessages(),
                          child: Text(
                            "Help",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            setState(() {
              Contacts.getContacts();
            });
          },
          child: Scrollbar(
            interactive: true,
            thumbVisibility: true,
            thickness: 5,
            controller: provider.onTapSearch
                ? searchListController
                : contactListController,
            child: provider.onTapSearch == false
                ? ListView.separated(
                    controller: contactListController,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return GestureDetector(
                          onTap: () {},
                          child: buttonCard(
                            const Icon(
                              Icons.people,
                              color: Colors.white,
                            ),
                            "New group",
                            null,
                            null,
                          ),
                        );
                      } else if (index == 1) {
                        return buttonCard(
                          Transform.flip(
                            flipX: true,
                            child: const Icon(
                              Icons.person_add_alt_1_sharp,
                              color: Colors.white,
                            ),
                          ),
                          "New contact",
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.qr_code),
                          ),
                          null,
                        );
                      } else if (index == 2) {
                        return buttonCard(
                          Transform.flip(
                            flipX: true,
                            child: SvgPicture.asset(
                                "assets/groups_white_36dp.svg"),
                          ),
                          "New community",
                          null,
                          null,
                        );
                      } else {
                        return ListTile(
                          title:
                              Text(Contacts.contactList[index]["displayName"]),
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFF075454),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            var receiverId = Contacts.contactList[index]
                                ["phones"][0]["normalizedNumber"];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DirectMessage(
                                  name: Contacts.contactList[index]
                                      ["displayName"],
                                  phoneNumber: widget.phoneNumber,
                                  receiverId: receiverId!,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemCount: Contacts.contactList.length,
                  )
                : ListView.separated(
                    controller: searchListController,
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            _animateAvatar();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.bounceIn,
                            child: const CircleAvatar(
                              backgroundColor: Color(0xFF075454),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        title: Text(filteredContacts[index]["displayName"]),
                        onTap: () {
                          var receiverId = filteredContacts[index]["phones"][0]
                              ["normalizedNumber"];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DirectMessage(
                                name: filteredContacts[index]["displayName"],
                                phoneNumber: widget.phoneNumber,
                                receiverId: receiverId!,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
