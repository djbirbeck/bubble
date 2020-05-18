import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('What does Bubble do?'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
              'Bubble is a focus timer and planner that aims to help you organise your time and be as productive as you feel you need to be.'),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('How does it do it?'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            Text(
              'The idea is simple: you set yourself a task, choose the intervals of work and rest, and press play!',
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'The intervals have been set to either 25 minutes with a 5 minute break, or 50 minutes with a 10 minute break. Many people have found that working in 25 minute blocks improves their productivity. For some, this is ideal, however others find that 25 minutes is just not long enough to get into a bubble of concentration, so we doubled it!',
                textAlign: TextAlign.justify,
              ),
            ),
            Text(
              'Bubble on The Go allows you to get going without planning. This can be ideal if you haven\'t had time to plan out your task before hand.',
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Otherwise you can plan ahead by setting a goal, with a due date, description, pre-chosen Bubble size and amount of Bubbles. Once set up, you can edit it whenever you want, to add or remove Bubbles, or work away and get bubblin\'.',
                textAlign: TextAlign.justify,
              ),
            ),
            Text(
              'One word of warning, to help you concentrate we made it so that if you move off the timer screens, the Bubble gets reset!',
              textAlign: TextAlign.justify,
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('Is my data safe?'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'We intentionally designed Bubble so that your data is kept on your device and no data is collected, not even statistical usage information.',
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
