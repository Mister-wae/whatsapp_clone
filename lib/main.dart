import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp_clone/views/landing_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/Models/message.dart';
import 'package:whatsapp_clone/views/media_screens/camera_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  cameras = await availableCameras();

  runApp(ChangeNotifierProvider(
    create: (context) => Message(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Message>(
      builder: (context, provider, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
            thumbColor: MaterialStateProperty.all(
              Colors.black,
            ),
          ),
          primaryColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
