import 'package:companionapp/assets/colors/app_colors.dart';
import 'package:companionapp/assets/gradients/home_page_gradient.dart';
import 'package:companionapp/assets/widgets/basic_widget_box.dart';
import 'package:companionapp/assets/widgets/white_text_widget.dart';
import 'package:companionapp/constants/routes.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_bloc.dart';
import 'package:companionapp/services/Timer/timer_service.dart';
import 'package:companionapp/views/journal_view.dart';
import 'package:companionapp/views/meditate_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const HomePageView(),
      routes: {
        homePageRoute: (context) => const HomePageView(),
        meditateViewRoute: (context) => const MeditateView(),
      }));
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
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
                    onPressed: () {},
                    child: const Text("Journal",
                        style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(meditateViewRoute);
                    },
                    child: const Text("Meditation",
                        style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: () {},
                    child: const Text("Log Out",
                        style: TextStyle(color: Colors.white))),
              ],
            )),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 15),
            child: Center(
              child: WhiteText(
                "Good Morning, User",
                fontSize: 32,
              ),
            ),
          ),
          BasicWidgetBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 200,
            content: const Center(
                child: WhiteText(
              "Lorem Ipsum",
              fontSize: 30,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 100,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.face_2,
                            size: 70,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.face_4,
                            size: 70,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.face_5,
                            size: 70,
                            color: Colors.white,
                          )),
                    ],
                  )),
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
                    BasicWidgetBox(
                      width: 200,
                      height: 200,
                      content: IconButton(
                          onPressed: () {},
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
                    BasicWidgetBox(
                      width: 200,
                      height: 200,
                      content: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(meditateViewRoute);
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
    );
  }
}
