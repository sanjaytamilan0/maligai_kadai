import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/User/login_cubit.dart';
import 'package:flutter_store/User/login_state.dart';
import 'package:flutter_store/Widgets/Register.dart';
import 'package:flutter_store/Widgets/forget_password.dart';
import 'package:flutter_store/routes/routes_name.dart';
import 'package:flutter_store/ui/HomeScreen.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Set your preferred height here
        child: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(child: Text('welcome To')),
              Text('maligai Kadai')
            ],
          ),
        ),
      ),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoginSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Center(
                  child: Text(
                    'Welcome User',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 13,
                margin: EdgeInsets.all(30),
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.goNamed(RoutesName.homeScreen);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomeScreen()),
            // );
          });} else if (state is LoginFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 13,
                margin: EdgeInsets.all(30),
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          });
          }
          return Form(
            key: loginForm,
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
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Email',
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
                                controller: email,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                validator: (email) {
                                  if (email!.isEmpty) {
                                    return 'enter valid email';
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'password',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                obscureText: true,
                                controller: password,
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  hintText: 'Enter your password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                validator: (password) {
                                  if (password!.isEmpty) {
                                    return 'enter valid password';
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left:250
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    context.goNamed(RoutesName.forget);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPassword()));

                                  },
                                  child: const Text(
                                    'Forget Password',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold

                                    ),
                                  ),
                                ),
                              )
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
                                    if (loginForm.currentState!.validate()) {
                                      context
                                          .read<LoginCubit>()
                                          .oldLogIn(email.text, password.text);
                                    }
                                  },
                                  child: const Center(
                                    child: Text(
                                      'LOGIN',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Create a new Account?'),
                                Container(
                                  height: 30,
                                  width: 45,
                                  color: Colors.red,
                                  child: GestureDetector(
                                    onTap: () {
                                     context.goNamed(RoutesName.initial);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => Register(),
                                      //   ),
                                      // );
                                    },
                                    child: const Center(
                                      child: Text(
                                        'Create',
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
          );
        },
      ),
    );
  }
}
