import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store/Widgets/Login.dart';
import 'package:flutter_store/routes/routes_name.dart';
import 'package:go_router/go_router.dart';



class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> forgetForm = GlobalKey<FormState>();
  TextEditingController forgetPassword =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Form(
      key: forgetForm,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Maligai kadai',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 40,
                      left: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Reset password',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                          ],
                          obscureText: false,
                          controller: forgetPassword,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                          validator: (password) {
                            if (password!.isEmpty) {
                              return 'enter valid mail';
                            }
                          },
                        ),

                      ],
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 80,
                          height: 30,
                          color: Colors.red,
                          child: GestureDetector(
                            onTap: () async {
                              if (forgetForm.currentState!.validate()) {
                               await forget();
                              }
                            },
                            child: const Center(
                              child: Text(
                                'Reset',
                                style: TextStyle(
                                  color: Colors.white,
                                  backgroundColor: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Try Another Way?'),
                          Container(
                            height: 30,
                            width: 45,
                            color: Colors.red,
                            child: GestureDetector(
                              onTap: () {
                                context.pop(context);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => Login(),
                                //   ),
                                // );
                              },
                              child: const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
  Future<void> forget() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      // Send password reset email
      await auth.sendPasswordResetEmail(email: forgetPassword.text);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('verify your email'),
            content: Text('Password reset email sent to ${forgetPassword.text}.'),
            actions: <Widget>[
              TextButton(
                onPressed: ()async {
                 // await myUrl(forgetPassword.text);
                  Navigator.of(context).pop();
                },
                child: Text('verify'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Show an error message if there's an issue sending the password reset email
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send password reset email. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

  }






}
