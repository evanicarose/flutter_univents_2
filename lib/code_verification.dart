import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_univents_2/dashboard.dart';
import 'dart:async';

class CodeVerification extends StatefulWidget {
  final String email;
  final EmailOTP myAuth;
  const CodeVerification({
    super.key,
    required this.email,
    required this.myAuth,
  });

  @override
  State<CodeVerification> createState() => _CodeVerificationState();
}

String pin1 = '', pin2 = '', pin3 = '', pin4 = '';
int start = 20;
Timer? timer;

class _CodeVerificationState extends State<CodeVerification> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (start == 0) {
        timer?.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appbar placeholder'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verification',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'We have sent a verification code to \n${widget.email}',
                        // PLACEHOLDER
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 34),
              child: Form(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 64,
                    width: 64,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          setState(() {
                            pin1 = value;
                          });
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 44, 80),
                              width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 44, 80),
                              width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    width: 64,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          setState(() {
                            pin2 = value;
                          });
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 44, 80),
                              width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 44, 80),
                              width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    width: 64,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          setState(() {
                            pin3 = value;
                          });
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 44, 80),
                              width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 44, 80),
                              width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    width: 64,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          setState(() {
                            pin4 = value;
                          });
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 44, 80),
                              width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 44, 80),
                              width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                    ),
                  ),
                ],
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              width: 250,
              child: FilledButton(
                onPressed: () async {
                  String userOTP = pin1 + pin2 + pin3 + pin4;

                  bool isVerified = await widget.myAuth.verifyOTP(otp: userOTP);

                  if (isVerified) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('OTP Verified Successfully!')),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Invalid OTP! Please try again. ')),
                    );
                  }
                },
                style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: const Color.fromARGB(255, 8, 18, 153)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 18),
                    Text(
                      "CONTINUE",
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 56, 69, 255)),
                        child: Icon(Icons.arrow_forward)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Re-send code in ',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                Text(
                  '0:${start.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 70, 128),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
