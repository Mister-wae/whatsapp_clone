import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/Models/chat_model.dart';
import 'package:whatsapp_clone/Models/message.dart';
import 'package:whatsapp_clone/views/widgets.dart';

class Communication extends StatelessWidget {
  Communication({super.key, required this.receiverID, required this.senderID});
  final String senderID;
  final String receiverID;

  Set<MessageModel> messages = {};

  final ScrollController _scrollController = ScrollController();

  Future fetchData() async {
    final collection =
        FirebaseFirestore.instance.collection('DirectMessage').orderBy(
              "time",
              descending: false,
            );
    final QuerySnapshot querySnapshot = await collection.get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot<Object?>>? messageList;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 135,
        child: Consumer<Message>(
          builder: (context, provider, child) => FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot<Object?>>? documents =
                    snapshot.data as List<DocumentSnapshot<Object?>>?;
                messageList = documents;
                Provider.of<Message>(
                  context,
                ).receiveMessage(messageList, messages);
                // WidgetsBinding.instance.addPostFrameCallback(
                //   (_) {
                //     _scrollController.animateTo(
                //       _scrollController.position.maxScrollExtent,
                //       duration: const Duration(milliseconds: 1),
                //       curve: Curves.easeOut,
                //     );
                //   },
                // );
                return Consumer<Message>(
                  builder: (context, provider, child) => ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      if (messages.elementAt(index).messagePath ==
                          "$senderID:$receiverID") {
                        return GestureDetector(
                          child: ownMessage(
                            context,
                            messages.elementAt(index).text,
                            messages.elementAt(index).time,
                          ),
                        );
                      } else if (messages.elementAt(index).messagePath ==
                          "$receiverID:$senderID") {
                        return GestureDetector(
                          child: replyCard(
                            context,
                            messages.elementAt(index).text,
                            messages.elementAt(index).time,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

// return ListView(
              //   shrinkWrap: true,
              //   children: [
              //     const SizedBox(
              //       height: 30,
              //     ),
              //     SizedBox(
              //       child: Center(
              //         child: Container(
              //           height: 60,
              //           width: MediaQuery.of(context).size.width - 70,
              //           decoration: ShapeDecoration(
              //             color: const Color.fromARGB(255, 244, 237, 184),
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(
              //                 10,
              //               ),
              //             ),
              //           ),
              //           child: const Padding(
              //             padding: EdgeInsets.all(8.0),
              //             child: Text(
              //               textAlign: TextAlign.center,
              //               "    Messages and calls are not end-to-end encrypted. The developer, even WhatsApp Clone, can react or listen to them. Tap to learn more.",
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              // const SizedBox(
              //   height: 10,
              // ),