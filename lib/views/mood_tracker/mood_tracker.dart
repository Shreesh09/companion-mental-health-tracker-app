import 'package:companionapp/assets/colors/app_colors.dart';
import 'package:companionapp/assets/widgets/basic_box_widget.dart';
import 'package:companionapp/assets/widgets/white_text_widget.dart';
import 'package:companionapp/constants/routes.dart';
import 'package:companionapp/services/mood_tracker_db/Bloc/mood_bloc.dart';
import 'package:companionapp/services/mood_tracker_db/Bloc/mood_events.dart';
import 'package:companionapp/services/mood_tracker_db/Bloc/mood_states.dart';
import 'package:companionapp/services/mood_tracker_db/cloud_mood.dart';
import 'package:companionapp/services/mood_tracker_db/cloud_storage_mood_exceptions.dart';
import 'package:companionapp/services/mood_tracker_db/firbase_cloud_storage_mood.dart';
import 'package:companionapp/utilities/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../assets/gradients/home_page_gradient.dart';
import '../../helpers/extract_name_asset.dart';
import '../../services/auth/auth_service.dart';

enum MenuAction { viewLogs }

class MoodTracker extends StatefulWidget {
  const MoodTracker({super.key});

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  final String currentUser = AuthService.firebase().currentUser!.id;
  late final FirebaseMoodCloudStorage _provider;
  String? selectedMood, selectedActivity;
  Color moodColor = Colors.transparent, activityColor = Colors.transparent;

  @override
  void initState() {
    _provider = FirebaseMoodCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoodBloc>(
        create: (context) =>
            MoodBloc(provider: _provider, ownerUserId: currentUser),
        child: BlocConsumer<MoodBloc, MoodState>(
          listener: (context, state) {
            if (state is MoodStateNotSet) {
              if (state.exception != null) {
                if (state.exception is InvalidActivityException) {
                  showErrorDialog(context, "Invalid Activity Selected");
                } else if (state.exception is InvalidMoodException) {
                  showErrorDialog(context, "Invalid Mood Selected");
                } else {
                  showErrorDialog(context, "Invalid Mood or Activity");
                }
              }
            }
          },
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(gradient: homePageGradient),
              child: Scaffold(
                backgroundColor: Colors.black45,
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                  ),
                  title: const WhiteText(
                    "Track your Mood",
                    fontSize: 24,
                  ),
                  backgroundColor: appBarColor,
                  actions: [
                    PopupMenuButton<MenuAction>(
                      onSelected: (value) async {
                        switch (value) {
                          case MenuAction.viewLogs:
                            Navigator.of(context).pushNamed(moodsViewRoute);
                        }
                      },
                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            value: MenuAction.viewLogs,
                            child: Text('View Logs'),
                          )
                        ];
                      },
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const WhiteText(
                      "How Are You Feeling?",
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: moodList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (selectedMood == moodList[index]) {
                            moodColor = Colors.white38;
                          } else {
                            moodColor = Colors.transparent;
                          }
                          return InkWell(
                              onTap: () {
                                context.read<MoodBloc>().add(
                                    MoodEventSetMood(newMood: moodList[index]));
                                setState(() {
                                  selectedMood = moodList[index];
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                child: Column(
                                  children: [
                                    Container(
                                        height: 110,
                                        color: moodColor,
                                        child: Image(
                                            image:
                                                AssetImage(moodList[index]))),
                                    WhiteText(
                                      extractName(moodList[index]),
                                      fontSize: 20,
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    const WhiteText(
                      "How did you spend your time?",
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: activityList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (selectedActivity == activityList[index]) {
                            activityColor = Colors.white38;
                          } else {
                            activityColor = Colors.transparent;
                          }
                          return InkWell(
                              onTap: () {
                                context.read<MoodBloc>().add(
                                    MoodEventSetActivity(
                                        newActivity: activityList[index]));
                                selectedActivity = activityList[index];
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  children: [
                                    Container(
                                        height: 120,
                                        color: activityColor,
                                        child: Image(
                                            image: AssetImage(
                                                activityList[index]))),
                                    WhiteText(
                                      extractName(activityList[index]),
                                      fontSize: 20,
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<MoodBloc>().add(const MoodEventLog());
                      },
                      child: const BasicBox(
                          width: 250,
                          height: 60,
                          content: WhiteText(
                            "Log your Mood",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 100,
                      child: GestureDetector(
                        child: const Center(
                            child: Text(
                          "^\nSwipe up to view Logs",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54, fontSize: 18),
                        )),
                        onVerticalDragUpdate: (dragUpdateDetails) {
                          Navigator.of(context).pushNamed(moodsViewRoute);
                        },
                      ),
                    )
                  ]),
                ),
              ),
            );
          },
        ));
  }
}
