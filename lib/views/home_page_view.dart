import 'package:companionapp/services/auth/bloc/auth_bloc.dart';
import 'package:companionapp/services/auth/bloc/auth_event.dart';
import 'package:companionapp/utilities/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../assets/colors/app_colors.dart';
import '../assets/gradients/home_page_gradient.dart';
import '../assets/widgets/basic_box_widget.dart';
import '../assets/widgets/white_text_widget.dart';
import '../constants/routes.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final String salutation = "A very Good " +
      (DateTime.now().hour < 12 ? "Morning" : "Afternoon") +
      "!";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: homePageGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const WhiteText('Companion'),
          backgroundColor: appBarColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
          ),
        ),
        drawer: Drawer(
            backgroundColor: widgetColor,
            child: ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(moodTrackerViewRoute);
                    },
                    child: const Text(
                      "Mood Tracker",
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(journalViewRoute);
                    },
                    child: const Text("Journal",
                        style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(meditateViewRoute);
                    },
                    child: const Text("Meditation",
                        style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: () async {
                      bool shouldLogOut = await showLogOutDialog(context);
                      if (shouldLogOut) {
                        context.read<AuthBloc>().add(const AuthEventLogOut());
                      }
                    },
                    child: const Text("Log Out",
                        style: TextStyle(color: Colors.white))),
              ],
            )),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
              child: Center(
                child: WhiteText(
                  salutation,
                  fontSize: 32,
                ),
              ),
            ),
            BasicBox(
              width: MediaQuery.of(context).size.width * .9,
              //height: 200,
              content: const Center(
                  child: Image(
                image: AssetImage(
                  'assets/inspirational.png',
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WhiteText(
                    "how are you feeling?",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(moodTrackerViewRoute);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 100,
                      child: const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: Image(
                              image: AssetImage("assets/happy.png"),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: Image(
                              image: AssetImage("assets/neutral.png"),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: Image(
                              image: AssetImage("assets/sad.png"),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const WhiteText(
                        "Journal",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(journalViewRoute);
                        },
                        child: BasicBox(
                            width: MediaQuery.of(context).size.width * .40,
                            height: MediaQuery.of(context).size.width * .40,
                            content: const Image(
                              image: AssetImage("assets/journal.png"),
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const WhiteText(
                        "Meditate",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(meditateViewRoute);
                        },
                        child: BasicBox(
                            width: MediaQuery.of(context).size.width * .40,
                            height: MediaQuery.of(context).size.width * .40,
                            content: const Image(
                              image: AssetImage("assets/meditation.png"),
                              color: Colors.white,
                            )),
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
