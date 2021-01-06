import 'package:cab_app_ui/components/colored_backgroud.dart';
import 'package:cab_app_ui/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpUI extends StatefulWidget {
  final String mobile;
  OtpUI(this.mobile);

  @override
  _OtpUIState createState() => _OtpUIState();
}

class _OtpUIState extends State<OtpUI> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> _animationValue;
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVerifying = true;
  String phoneNumber;
  String smsCode;
  String _message;
  FirebaseAuth _auth;
  String _verificationId;
  @override
  void initState() {
    super.initState();
    phoneNumber = widget.mobile;
    _auth = FirebaseAuth.instance;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animationValue = Tween<double>(begin: 1.1, end: 0.9).animate(animationController);
    animationController.repeat(reverse: true);
    _verifyPhoneNumber(phoneNumber);
  }

  @override
  void dispose() {
    animationController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber(String mobileNumber) async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential phoneAuthCredential) {
      _signInWithPhoneNumber(credential: phoneAuthCredential);
    };

    final PhoneVerificationFailed verificationFailed = (authException) {
      setState(() {
        isVerifying = false;
        _message = 'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
      Fluttertoast.showToast(msg: _message);
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      Fluttertoast.showToast(msg: "OTP sent");
      //getRemainingTime();
      setState(() {
        isVerifying = false;
      });
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Example code of how to sign in with phone.
  Future<void> _signInWithPhoneNumber({AuthCredential credential, String otp}) async {
    setState(() {});
    AuthCredential authCredential;
    if (credential != null) {
      authCredential = credential;
    } else {
      authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
    }

    Fluttertoast.showToast(msg: "Verification in progress...");

    UserCredential _results = await _auth.signInWithCredential(authCredential).catchError((onError) {
      Fluttertoast.showToast(msg: "Invalid OTP");
      setState(() {});
      return;
    });
    try {
      User user = _results.user;

      setState(() {
        if (user != null) {
          _message = 'Successfully signed in';
        } else {
          _message = 'Sign in failed';
        }
      });
      Fluttertoast.showToast(msg: _message);
      if (user != null) {
        //Fluttertoast.showToast(msg: 'Login ')
      } //to homepage widget.otpInterface.matchOtp(user);
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            ColoredBackground(),
            Positioned(
              top: 15,
              left: -60,
              child: ScaleTransition(
                scale: _animationValue,
                child: Container(
                  width: 162,
                  height: 162,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x26FFFFFF),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 230,
              right: 120,
              child: ScaleTransition(
                scale: _animationValue,
                child: Container(
                  width: 105,
                  height: 105,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x26FFFFFF),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: -50,
              child: ScaleTransition(
                scale: _animationValue,
                child: Container(
                  height: 199,
                  width: 199,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x26FFFFFF),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 45,
              child: ScaleTransition(
                scale: _animationValue,
                child: Container(
                  width: 105,
                  height: 105,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x26FFFFFF),
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: SafeArea(
                child: Column(
                  children: [
                    // Adobe XD layer: 'Oval 3' (shape)
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, MyRoutes.login);
                        },
                        child: Container(
                          width: 55.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0x26ffffff),
                          ),
                          child: Icon(
                            Icons.clear_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                    ),
                    Text(
                      'Verification',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 55,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        height: 1.0363636363636364,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter the 6 digit OTP sent to your \nmobile number',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10, right: 20, bottom: 40),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0x80FFFFFF),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: _otpController,
                            validator: (value) => value.isEmpty || value.length != 6 ? '*Invalid OTP' : null,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 6,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0), borderSide: BorderSide.none),
                              hintText: "6-digit OTP",
                              hintStyle: TextStyle(color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              isDense: true,
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.only(left: 30, right: 20),
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            String otp = _otpController.text;
                            setState(() => isVerifying = true);
                            await _signInWithPhoneNumber(otp: otp);
                            setState(() => isVerifying = false);
                          }
                        },
                        color: Colors.blueAccent,
                        splashColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          child: isVerifying
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  "Verify",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
