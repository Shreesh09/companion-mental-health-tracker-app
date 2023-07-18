import 'package:companionapp/assets/colors/app_colors.dart';
import 'package:companionapp/assets/widgets/white_text_widget.dart';
import 'package:companionapp/services/mood_tracker_db/Bloc/mood_bloc.dart';
import 'package:companionapp/services/mood_tracker_db/Bloc/mood_events.dart';
import 'package:companionapp/services/mood_tracker_db/Bloc/mood_states.dart';
import 'package:companionapp/services/mood_tracker_db/cloud_mood.dart';
import 'package:companionapp/services/mood_tracker_db/cloud_storage_mood_exceptions.dart';
import 'package:companionapp/services/mood_tracker_db/firbase_cloud_storage_mood.dart';
import 'package:companionapp/utilities/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/auth/auth_service.dart';

class MoodTracker extends StatefulWidget {
  const MoodTracker({super.key});

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  final String currentUser = AuthService.firebase().currentUser!.id;
  late final FirebaseMoodCloudStorage _provider;

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
            return Scaffold(
              appBar: AppBar(
                title: const WhiteText(
                  "Select Events",
                  fontSize: 24,
                ),
                backgroundColor: appBarColor,
              ),
              body: Column(children: [
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: moodList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            context.read<MoodBloc>().add(
                                MoodEventSetMood(newMood: moodList[index]));
                          },
                          child: Image(image: AssetImage(moodList[index])));
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: activityList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<MoodBloc>().add(MoodEventSetActivity(
                              newActivity: activityList[index]));
                        },
                        child: Image(image: AssetImage(activityList[index])),
                      );
                    },
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      context.read<MoodBloc>().add(const MoodEventLog());
                    },
                    child: const Text("LOG"))
              ]),
            );
          },
        ));
  }
}
