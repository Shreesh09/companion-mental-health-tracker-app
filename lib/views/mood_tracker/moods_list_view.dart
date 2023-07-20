import 'package:companionapp/assets/widgets/basic_box_widget.dart';
import 'package:flutter/material.dart';
import '../../services/mood_tracker_db/cloud_mood.dart';
import '../../utilities/dialogs/delete_dialog.dart';

typedef MoodCallback = void Function(CloudMood Mood);

class MoodsListView extends StatelessWidget {
  final List<CloudMood> moods;
  final MoodCallback onDeleteMood;
  const MoodsListView({
    super.key,
    required this.moods,
    required this.onDeleteMood,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: moods.length,
        itemBuilder: (context, index) {
          final mood = moods.elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: BasicBox(
              height: 100,
              content: Column(
                children: [
                  Text(mood.date,
                      style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 60,
                              child: Image(image: AssetImage(mood.mood))),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                              height: 60,
                              child: Image(image: AssetImage(mood.activity))),
                        ],
                      ),
                      IconButton(
                        onPressed: () async {
                          final shouldDelete = await showDeleteDialog(context);
                          if (shouldDelete == true) {
                            onDeleteMood(mood);
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
