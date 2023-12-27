import 'package:flutter/material.dart';
import 'dart:math' as math;

class Calls extends StatelessWidget {
  const Calls({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {},
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFF075454),
                child: Transform.rotate(
                  angle: 135 * math.pi / 180,
                  child: const Icon(
                    Icons.link,
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text("Create call link"),
            )
          ],
        ),
      ),
    );
  }
}
