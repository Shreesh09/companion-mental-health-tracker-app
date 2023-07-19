import 'package:companionapp/assets/colors/app_colors.dart';
import 'package:companionapp/assets/gradients/home_page_gradient.dart';
import 'package:companionapp/assets/widgets/white_text_widget.dart';
import 'package:companionapp/services/mood_tracker_db/firbase_cloud_storage_mood.dart';
import 'package:companionapp/views/mood_tracker/line_chart.dart';
import 'package:companionapp/views/mood_tracker/radial_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/routes.dart';
import '../../services/auth/auth_service.dart';
import 'moods_list_view.dart';

class MoodsView extends StatefulWidget {
  const MoodsView({super.key});

  @override
  State<MoodsView> createState() => _MoodsViewState();
}

class _MoodsViewState extends State<MoodsView> {
  late final FirebaseMoodCloudStorage _moodsService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _moodsService = FirebaseMoodCloudStorage();
    super.initState();
  }

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
          backgroundColor: appBarColor,
          title: const Text(
            "Logs",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StreamBuilder(
          stream: _moodsService.allMoods(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allMoods = snapshot.data!.toList();
                  allMoods.sort((a, b) => b.date.compareTo(a.date));
                  //if()
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        children: [
                          Container(
                              color: Colors.black45, child: MoodRadialChart()),
                          Container(
                              color: Colors.black45,
                              child: const MoodLineChart()),
                          SizedBox(
                            height: 80,
                            child: Container(
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          const WhiteText(
                            "Previous Mood Logs",
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          MoodsListView(
                            moods: allMoods,
                            onDeleteMood: (mood) async {
                              await _moodsService.deleteMood(
                                  documentId: mood.documentId);
                            },
                          ),
                        ],
                      )
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
