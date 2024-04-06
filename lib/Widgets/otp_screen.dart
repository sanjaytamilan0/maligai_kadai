import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_store/routes/routes_name.dart';
import 'package:go_router/go_router.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  OTPScreen({required this.phoneNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Enter the OTP sent to ${widget.phoneNumber}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            _buildOTPTextField(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _verifyOTP();
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPTextField() {
    return Container(
      width: 200,
      child: TextField(
        controller: _otpController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter OTP',
        ),
        maxLength: 6,
        textAlign: TextAlign.center,
      ),
    );
  }

  Future<void> _verifyOTP() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: _otpController.text,
      );
      await _auth.signInWithCredential(credential);

       context.goNamed(RoutesName.homeScreen);
    } catch (e) {

      print('Failed to verify OTP: $e');
    }
  }

  String? verificationId;

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber(widget.phoneNumber);
  }

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);

    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {

      print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      this.verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {

      this.verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
}


