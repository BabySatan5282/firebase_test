import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_firebase/screens/singin_page/singin_page.dart';

import '../../bloc/bloc/auth_bloc.dart';
import '../home_page/home_page.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _authenticateWithEmailAndPassword() {
    BlocProvider.of<AuthBloc>(context).add(
      SignUpRequested(_emailController.text, _passwordController.text,
          _nameController.text),
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
        title: const Text("Singup"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: "Enter Name"),
              ),
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
                  if (state is SingUpSuccess) {
                    BlocProvider.of<AuthBloc>(context).add(CreateUserRequested(
                        _emailController.text, _nameController.text));
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
                    child: const Text("SingUp"),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SingInPage()));
                },
                child: const Text("Sing In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
