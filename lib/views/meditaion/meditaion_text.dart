import 'package:flutter/material.dart';

class MediataionText extends StatelessWidget {
  const MediataionText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Meditation is a habitual process of training your mind to focus and redirect your thoughts, offering numerous benefits such as reducing stress and anxiety, enhancing mood, promoting healthy sleep patterns, and boosting cognitive skills healthline.com. It can also lead to physical changes in the brain, slowing brain aging, and improving cognitive functions.\n\nHere is a simple guideline on how to start meditating:\n\t1) Find a quiet and comfortable place. Sit in a chair or on the floor with your head, neck, and back straight but not stiff.\n\t2) Try to set aside 10 to 15 minutes a day in the beginning. Over time, you can increase this to longer periods.\n\t3) Close your eyes and take deep breaths. Breathe in through the nose, gently, slowly. Pause. Exhale. Try to keep your mind focused on your breath.\n\t4) If your mind wanders, return your focus back to your breath. The goal is not to clear the mind, but to focus your attention, and when it drifts, to bring it back.\n\nRemember, meditation requires practice. It's normal for your mind to wander during meditation, so don't be too hard on yourself. The act of bringing your attention back to your breath when your mind does wander is actually where the magic happens",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}
