import 'package:companionapp/services/auth/bloc/auth_bloc.dart';
import 'package:companionapp/services/auth/bloc/auth_event.dart';
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
  final String salutation = "Good " +
      (DateTime.now().hour < 12 ? "Morning" : "Afternoon") +
      ", User!";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: homePageGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
          ),
          title: const Text(
            'Companion',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: appBarColor, //Color.fromARGB(94, 79, 78, 93),
        ),
        drawer: Drawer(
            backgroundColor: widgetColor,
            child: ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                    onPressed: () {},
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
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
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
              width: MediaQuery.of(context).size.width * 0.9,
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
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(moodTrackerViewRoute);
                              },
                              icon: const Icon(
                                Icons.face_2,
                                size: 70,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(moodTrackerViewRoute);
                              },
                              icon: const Icon(
                                Icons.face_4,
                                size: 70,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(moodTrackerViewRoute);
                              },
                              icon: const Icon(
                                Icons.face_5,
                                size: 70,
                                color: Colors.white,
                              )),
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
                      BasicBox(
                        width: 200,
                        height: 200,
                        content: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(journalViewRoute);
                            },
                            icon: const Icon(
                              Icons.book_outlined,
                              size: 100,
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
                      BasicBox(
                        width: 200,
                        height: 200,
                        content: IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(meditateViewRoute);
                            },
                            icon: const Icon(
                              Icons.bed_rounded,
                              size: 100,
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
