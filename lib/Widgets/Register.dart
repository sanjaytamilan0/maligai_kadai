import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/User/register_cubit.dart';
import 'package:flutter_store/User/register_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store/routes/routes_name.dart';
import 'package:go_router/go_router.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  GlobalKey<FormState> registerForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          if(state is RegistrationSuccess){
            context.goNamed(RoutesName.login);
            // Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const Login()),
            //         );
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(
                    child: Text(
                      'Registration Successfully',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  backgroundColor: Colors.red,
                  elevation: 13,
                  margin: EdgeInsets.all(30),
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            });
          }
          else if (state is RegistrationFailure) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(
                    child: Text(
                      'Registration failed',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  backgroundColor: Colors.red,
                  elevation: 13,
                  margin: EdgeInsets.all(30),
                  duration: Duration(seconds: 5),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            });
          }
        },
            builder: (context, state) {
              if (state is RegistrationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Form(
                key: registerForm,
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
                          SizedBox(
                            height: 300,
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
                                  const SizedBox(height: 2,),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
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
                                        return 'Please enter an email address';
                                      }
                                      if (!EmailValidator.validate(email)) {
                                        return 'Invalid email address';
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 5,),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Phone Number',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2,),
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    controller: phoneNo,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your phone number',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 10,
                                          style: BorderStyle.solid,
                                          strokeAlign: BorderSide
                                              .strokeAlignCenter,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                    validator: (phoneNo) {
                                      if (phoneNo == null || phoneNo.isEmpty) {
                                        return 'Enter your phone number';
                                      } else if (phoneNo.length < 10) {
                                        return 'Enter a valid phone number';
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 5,),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Password',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2,),
                                  TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    obscureText:BlocProvider.of<RegistrationCubit>(context).isObscure,
                                    controller: password,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: 'Enter your password',
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: (){
                                          BlocProvider.of<RegistrationCubit>(context).isObscure = !BlocProvider.of<RegistrationCubit>(context).isObscure;
                                        },
                                        icon: Icon(BlocProvider.of<RegistrationCubit>(context).isObscure? Icons.password: Icons.password),
                                      )
                                      // suffixIcon: Icon(BlocProvider.of<RegistrationCubit>(context).isObscure ?
                                      // Icons.password_rounded
                                      //     :Icons.password
                                      // )
                                    ),
                                    validator: (password) {
                                      if (password == null ||
                                          password.isEmpty) {
                                        return 'Enter your password';
                                      } else if (password.length < 9) {
                                        return 'Enter a strong password ';
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    width: 80,
                                    height: 30,
                                    color: Colors.red,
                                    child: GestureDetector(
                                      onTap: () {
                                        print('click');
                                        if (registerForm.currentState!
                                            .validate()) {

                                          context.read<RegistrationCubit>()
                                              .registerNew(
                                              email.text,
                                              password.text);
                                          FirebaseFirestore.instance.collection('users').add(
                                              {
                                                'email' : email.text,
                                                'phoneNo' : phoneNo.text,
                                                'password' : password.text
                                              });
                                        }
                                      },
                                      child: const Center(
                                        child: Text(
                                          'REGISTER',
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
                                    const Text('Already have an account?'),
                                    Container(
                                      height: 30,
                                      width: 40,
                                      color: Colors.red,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.go(RoutesName.login);
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
              );
            },

      ),
    );
  }
}
