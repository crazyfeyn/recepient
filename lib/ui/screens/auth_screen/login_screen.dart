import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter_application/logic/bloc/auth/auth_event.dart';
import 'package:flutter_application/logic/bloc/auth/auth_state.dart';
import 'package:flutter_application/ui/screens/auth_screen/register_screen.dart';
import 'package:flutter_application/ui/screens/navigationbar_screen/all_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();

  final passcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isObscure = true;

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context
          .read<AuthBloc>()
          .add(LoginEvent(emailcontroller.text, passcontroller.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllNavigationBar(),
                ),
              );
            }
            if (state is AuthError) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("ok"),
                      ),
                    ],
                    title: Text(state.errorMessage),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Lottie.asset('assets/images/loading.json'),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/login.png'),
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/login.png',
                    height: 450,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    color: Colors.orange,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 40,
                            color: Colors.orange,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 2,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: emailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Input email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            label: const Text('email'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: passcontroller,
                          obscureText: isObscure,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Input password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                icon: Icon(isObscure
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash)),
                            prefixIcon: Icon(CupertinoIcons.lock),
                            label: const Text('password'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  ResetPasswordEvent(
                                    email: emailcontroller.text,
                                  ),
                                );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ZoomTapAnimation(
                          onTap: () => submit(context),
                          child: Card(
                            elevation: 6,
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an Account? ",
                                style: TextStyle(
                                  color: AdaptiveTheme.of(context).mode ==
                                              AdaptiveThemeMode.light ||
                                          AdaptiveTheme.of(context).mode ==
                                              AdaptiveThemeMode.system
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 15,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(
                                      color: Colors.red.shade300,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
