import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_clone/Models/message.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  child: SvgPicture.asset(
                    "assets/community.svg",
                    fit: BoxFit.fill,
                    height: 350,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "Stay connected with a community",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "     Communities bring members together in topic-based groups, \n and make it easy to get admin announcements. Any community \n                          you're added to will appear here.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  height: 1.7,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<Message>(
                builder: (context, provider, child) => GestureDetector(
                  onTap: () {
                    provider.onTapUnderlineText();
                    launchURL();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "See example communities",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            decoration: provider.underline
                                ? TextDecoration.underline
                                : TextDecoration.none),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Color(0xFF075454),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 80,
                decoration: ShapeDecoration(
                  color: const Color(0xFF075454),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Start your community",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}

launchURL() async {
  final Uri url = Uri.parse(
      "https://faq.whatsapp.com/cxt?entrypointid=community-examples-article&lg=en&lc=GB&platform=android&anid=8531b002-bb56-4374-aa88-fc2d74b0045b");
  if (await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {}
  throw Exception('Could not launch $url');
}
