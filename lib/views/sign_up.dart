import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/Models/auth_utils.dart';
import 'package:whatsapp_clone/Models/message.dart';
import 'package:whatsapp_clone/views/home_views/homepage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final List<String> countryList = [
    'Nigeria',
  ];

  final TextEditingController _countryCodeController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Color color = Color(0xFF12BC7E);
  Future<void> verifyPhoneNumber(String phoneNumber, context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (String verificationId, int? resendToken) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Code sent!")));
        showModalBottomSheet(
          context: context,
          builder: (context) => VerifyPhoneScreen(
            phoneNumber: phoneNumber,
            verificationId: verificationId,
          ),
        );
      },
      verificationCompleted: (AuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Verification failed")));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Code auto-retrieval time-out!"),
          action: SnackBarAction(label: "Resend Code", onPressed: () {}),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _countryCodeController.text = "234";

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  const Spacer(),
                  const Center(
                    child: Text(
                      "Verify your phone number",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF075454),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                textAlign: TextAlign.center,
                "WhatsAppClone will send an SMS message to verify your phone number. Enter your country code and phone number:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 400,
              width: 200,
              child: Column(
                children: [
                  Consumer<Message>(
                    builder: (context, provider, child) =>
                        DropdownButtonFormField<String>(
                      alignment: AlignmentDirectional.bottomEnd,
                      value: "Nigeria",
                      onChanged: (value) {},
                      items: countryList.map((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        enabled: false,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Consumer<Message>(
                          builder: (context, provider, child) => TextField(
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            textAlignVertical: TextAlignVertical.bottom,
                            controller: _countryCodeController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixIconConstraints: BoxConstraints(
                                maxHeight: 3,
                                maxWidth: 22,
                              ),
                              prefixIcon: Icon(
                                Icons.add,
                                size: 20,
                              ),
                              prefixIconColor: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 120,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  InkWell(
                    onTap: () {
                      final phoneNumber =
                          "+${_countryCodeController.text}${_phoneController.text}";
                      setState(() {
                        color = Colors.grey;
                      });
                      verifyPhoneNumber(phoneNumber, context);
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                        color: color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      alignment: Alignment.center,
                      height: 35,
                      width: 80,
                      child: const Text(
                        "NEXT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Carrier SMS charges may apply",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen(
      {super.key, required this.verificationId, required this.phoneNumber});
  final String verificationId;
  final String phoneNumber;

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController _controller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text("Input Code here:"),
              TextFormField(
                obscureText: true,
                maxLength: 6,
                controller: _controller,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
                onChanged: (value) {},
                keyboardType: TextInputType.number,
              ),
              InkWell(
                onTap: () async {
                  String smsCode = _controller.text;
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId, smsCode: smsCode);
                  await _auth.signInWithCredential(credential).then((value) {
                    SecureStorage.storeTokens(credential, widget.phoneNumber);
                  }).then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(phoneNumber: widget.phoneNumber),
                        ),
                        (route) => false);
                  });
                },
                child: Container(
                  decoration: ShapeDecoration(
                    color: const Color(0xFF12BC7E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  alignment: Alignment.center,
                  height: 35,
                  width: 80,
                  child: const Text(
                    "NEXT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
