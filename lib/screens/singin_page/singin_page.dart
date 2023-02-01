import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_firebase/screens/singup_page/singup_page.dart';

import '../../bloc/bloc/auth_bloc.dart';
import '../home_page/home_page.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _authenticateWithEmailAndPassword() {
    BlocProvider.of<AuthBloc>(context).add(
      SignInRequested(_emailController.text, _passwordController.text),
    );
  }

  //
  // void _authenticateWithGoogle(context) {
  //   BlocProvider.of<AuthBloc>(context).add(
  //     GoogleSignInRequested(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SingIn"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(hintText: "Enter Email Adress"),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(hintText: "Enter Password"),
              ),
              const SizedBox(
                height: 15,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  print(state);
                  if (state is Authenticated) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      _authenticateWithEmailAndPassword();
                    },
                    child: const Text("SingIn"),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SingUpPage()));
                },
                child: const Text("Sing Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
