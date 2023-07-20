import 'package:companionapp/assets/colors/app_colors.dart';
import 'package:companionapp/assets/gradients/home_page_gradient.dart';
import 'package:companionapp/assets/widgets/white_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:companionapp/services/auth/auth_exceptions.dart';
import 'package:companionapp/services/auth/bloc/auth_bloc.dart';
import 'package:companionapp/services/auth/bloc/auth_event.dart';
import 'package:companionapp/services/auth/bloc/auth_state.dart';

import '../../utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordException) {
            await showErrorDialog(context, 'Weak passoword');
          } else if (state.exception is EmailAlreadyInUseException) {
            await showErrorDialog(context, 'Email is already in use');
          } else if (state.exception is InvalidEmailException) {
            await showErrorDialog(context, 'Invalid Exception');
          }
        }
      },
      child: Container(
        decoration: const BoxDecoration(gradient: homePageGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: appBarColor,
              iconTheme: const IconThemeData(color: Colors.white),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.black,
              ),
              title: const WhiteText('Companion')),
          body: SizedBox(
            height: 400,
            width: 700,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Center(
                      child: WhiteText(
                    "Register",
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    controller: _email,
                    obscureText: false,
                    enableSuggestions: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Enter your e-mail here',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: true,
                    decoration: const InputDecoration(
                        hintText: 'Enter your password here',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;
                            context.read<AuthBloc>().add(AuthEventRegister(
                                  email,
                                  password,
                                ));
                          },
                          child: const WhiteText("Register")),
                      TextButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthEventLogOut());
                          },
                          child: const WhiteText('Login here!')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
