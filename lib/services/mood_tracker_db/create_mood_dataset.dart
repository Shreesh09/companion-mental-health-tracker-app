import 'package:companionapp/helpers/extract_name_asset.dart';
import 'package:companionapp/services/mood_tracker_db/cloud_mood.dart';
import 'package:companionapp/util/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../views/mood_tracker/radial_chart.dart';

class CreateMoodDataset {
  late List<CloudMood> moods;

  static final CreateMoodDataset _shared = CreateMoodDataset._sharedInstance();
  CreateMoodDataset._sharedInstance();

  factory CreateMoodDataset() => _shared;

  void setMoods(moods) {
    this.moods = moods;
  }

  List<FlSpot> getMoodData() {
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;

    List<int> today = [year, month, day];

    Iterable<FlSpot> moodData = moods.where((mood) {
      int year = int.parse(mood.date.substring(0, 4));
      int month = int.parse(mood.date.substring(5, 7));
      int day = int.parse(mood.date.substring(8, 10));

      if (year == today[0] && month == today[1] && day == today[2]) {
        return true;
      }
      return false;
    }).map((mood) {
      double pos;
      int minutes = int.parse(mood.date.substring(11, 13)) * 3600 +
          int.parse(mood.date.substring(14, 16)) * 60 +
          int.parse(mood.date.substring(17));
      pos = minutes * 1.0 * (0.5 / (60.0 * 60.0));
      switch (extractName(mood.mood)) {
        case 'happy':
          return FlSpot(pos, 7.0);
        case 'neutral':
          return FlSpot(pos, 5.0);
        case 'angry':
          return FlSpot(pos, 3.0);
        case 'sad':
          return FlSpot(pos, 1.0);
        default:
          return FlSpot(pos, 0.0);
      }
    });

    List<FlSpot> mood = moodData.toList();
    mood.add(const FlSpot(0.0, 0.0));
    mood.add(const FlSpot(12.0, 0.0));
    mood.sort(
      (a, b) {
        if (a.x < b.x) {
          return 1;
        }
        if (a.x > b.x) {
          return -1;
        }
        return 0;
      },
    );
    //print(mood);
    moodData.toList().add(const FlSpot(10.0, 1.0));
    return mood;
  }

  List<RawDataSet> getActivityData() {
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    List<int> end = [year, month, day];

    if (day <= 7) {
      if (month == 1) {
        year--;
        month = 12;
        day = 31 - day - 7;
      } else {
        month--;
        if (month == 5 ||
            month == 7 ||
            month == 8 ||
            month == 10 ||
            month == 12) {
          day = 31 - day - 7;
        } else if (month == 3) {
          if (year % 4 == 0) {
            day = 29 - day - 7;
          } else {
            day = 28 - day - 7;
          }
        } else {
          day = 30 - day - 7;
        }
      }
    } else {
      day = day - 7;
    }

    List<int> start = [year, month, day];

    Map<String, List<double>> m = {};
    for (int i = 0; i < activityList.length; i++) {
      m[extractName(activityList[i])] = [0, 0, 0];
    }

    final moodsList = moods.where((mood) {
      int year = int.parse(mood.date.substring(0, 4));
      int month = int.parse(mood.date.substring(5, 7));
      int day = int.parse(mood.date.substring(8, 10));

      if (year < start[0] || year > end[0]) {
        return false;
      }
      if ((month < start[1] || month > end[1]) && start[0] == end[0]) {
        return false;
      }
      if ((day < start[2] || day > end[2]) && start[1] == end[1]) {
        return false;
      }
      return true;
    }).toList();

    for (int i = 0; i < moodsList.length; i++) {
      CloudMood mood = moodsList[i];
      int val = -1;
      switch (extractName(mood.mood)) {
        case 'happy':
          val = 0;
          break;
        case 'sad':
          val = 2;
          break;
        case 'angry':
          val = 1;
          break;
      }
      if (val != -1) {
        m[extractName(mood.activity)]![val] =
            m[extractName(mood.activity)]![val] + 1;
      }
    }

    for (int i = 0; i < activityList.length; i++) {
      //print(m[extractName(activityList[i])]);
    }

    List<RawDataSet> actData = [];
    for (int i = 0; i < activityList.length; i++) {
      if (m[extractName(activityList[i])] == []) {
        continue;
      }
      actData.add(RawDataSet(
          title: extractName(activityList[i]),
          color: Colors.white,
          values: m[extractName(activityList[i])]!));
    }

    actData.sort(
      (a, b) {
        double sumA = a.values[0] + a.values[1] + a.values[2];
        double sumB = b.values[0] + b.values[1] + b.values[2];
        if (sumA < sumB) {
          return 1;
        } else if (sumA > sumB) {
          return -1;
        } else {
          return 0;
        }
      },
    );

    if (actData.length > 5) {
      actData.removeRange(5, actData.length);
    }

    final fashionColor = AppColors.contentColorRed;
    final artColor = AppColors.contentColorCyan;
    final boxingColor = AppColors.contentColorGreen;
    final entertainmentColor = AppColors.contentColorWhite;
    final offRoadColor = AppColors.contentColorYellow;

    actData[0] = RawDataSet(
        title: actData[0].title,
        color: fashionColor,
        values: actData[0].values);
    actData[1] = RawDataSet(
        title: actData[1].title, color: artColor, values: actData[1].values);
    actData[2] = RawDataSet(
        title: actData[2].title,
        color: entertainmentColor,
        values: actData[2].values);
    actData[3] = RawDataSet(
        title: actData[3].title,
        color: offRoadColor,
        values: actData[3].values);
    actData[4] = RawDataSet(
        title: actData[4].title, color: boxingColor, values: actData[4].values);

    return actData;
  }
}
