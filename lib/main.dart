import 'package:companionapp/constants/routes.dart';
import 'package:companionapp/services/auth/bloc/auth_bloc.dart';
import 'package:companionapp/services/auth/bloc/auth_event.dart';
import 'package:companionapp/services/auth/bloc/auth_state.dart';
import 'package:companionapp/services/auth/firebase_auth_provider.dart';
import 'package:companionapp/views/auth/forgot_password_view.dart';
import 'package:companionapp/views/home_page_view.dart';
import 'package:companionapp/views/journal/create_update_note_view.dart';
import 'package:companionapp/views/journal/journal_view.dart';
import 'package:companionapp/views/auth/login_view.dart';
import 'package:companionapp/views/meditaion/meditate_view.dart';
import 'package:companionapp/views/auth/register_view.dart';
import 'package:companionapp/views/auth/verify_email_view.dart';
import 'package:companionapp/views/mood_tracker/mood_tracker.dart';
import 'package:companionapp/views/mood_tracker/moods_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helpers/loading/loading_screen.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const AppOpenView(),
      ),
      routes: {
        homePageRoute: (context) => const HomePageView(),
        meditateViewRoute: (context) => const MeditateView(),
        journalViewRoute: (context) => const JournalView(),
        createUpdateNoteRoute: (context) => const NewNoteView(),
        moodTrackerViewRoute: (context) => const MoodTracker(),
        moodsViewRoute: (context) => const MoodsView(),
      }));
}

class AppOpenView extends StatelessWidget {
  const AppOpenView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen()
              .show(context: context, text: state.loadingText ?? 'Loading');
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const HomePageView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
