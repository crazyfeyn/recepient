import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter_application/ui/screens/auth_screen/login_screen.dart';
import 'package:flutter_application/ui/views/screens/add_new_retsept/widgets/category_widget.dart';
import 'package:flutter_application/ui/views/screens/home_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final passconfirmcontroller = TextEditingController();
  final namecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthBloc>().add(
            RegisterUserEvent(
                name: namecontroller.text,
                email: emailcontroller.text,
                password: passcontroller.text),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            print(state);
            if (state is AuthenticatedState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomeScreen();                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAuthState) {
              return Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Lottie.asset(
                    'assets/images/loading.json',
                  ),
                ),
              );
            }
            if (state is ErrorAuthState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/login.png',
                      height: 450,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      color: Colors.orange),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 40,
                              color: Colors.orange),
                        ),
                        Container(
                          width: 100,
                          height: 2,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.orange),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: namecontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Input name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            label: const Text('name'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.orange),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.orange),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Input pass';
                            }
                            return null;
                          },
                          controller: passcontroller,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(CupertinoIcons.eye_slash),
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            label: const Text('password'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Confirm Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.orange),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Input pass';
                            }
                            if (passcontroller.text !=
                                passconfirmcontroller.text) {
                              return 'BIr hil emas';
                            }
                            return null;
                          },
                          controller: passconfirmcontroller,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(CupertinoIcons.eye_slash),
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            label: const Text('password'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                "Create an Account",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LoginScreen();
                                  },
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an Account ! ",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                                children: [
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      color: Colors.red.shade300,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
