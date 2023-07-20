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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, 'User Not Found');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong Password');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Invalid Email or Password');
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(gradient: homePageGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: appBarColor,
            iconTheme: const IconThemeData(color: Colors.white),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.black,
            ),
            title: const WhiteText('Companion'),
          ),
          body: SizedBox(
            height: 400,
            width: 700,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                      child: WhiteText(
                    "Login",
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
                            context.read<AuthBloc>().add(AuthEventLogIn(
                                  email,
                                  password,
                                ));
                          },
                          child: const WhiteText("Login")),
                      TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  const AuthEventShouldRegister(),
                                );
                          },
                          child: const WhiteText("Register here!")),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              const AuthEventForgotPassword(),
                            );
                      },
                      child: const WhiteText("Forgot Password?")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
