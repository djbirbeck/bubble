import 'package:flutter/material.dart';

import '../widgets/basic_scaffold.dart';
import '../widgets/help.dart';
import '../widgets/hero_bubbles_help.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      screenTitle: 'About Bubble',
      implyLeading: true,
      childWidget: Column(
        children: [
          HeroBubblesHelp(),
          Container(
            height: MediaQuery.of(context).size.height * 0.72,
            child: ListView(
              children: [
                Help(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
