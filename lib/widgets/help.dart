import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './bubble.dart';

class Help extends StatelessWidget {
  _launchRoadmap() async {
    const url = 'https://8bitbirbeck.co.uk/bubble-roadmap/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _emailSupport()  async {
    const email = 'mailto:support@8bitbirbeck.co.uk?subject=Bubble Feedback';
    const emailWebpage = 'https://8bitbirbeck.co.uk/contact/';
    if (await canLaunch(email)) {
      await launch(email);
    } else if (await canLaunch(emailWebpage)) {
      await launch(emailWebpage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
          child: Text(
            'Bubble is a focus timer and planner that aims to help you organise your time and be as productive as you feel you need to be.',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                child: Bubble(
                  size: 60,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'What\'s it all about?',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                'The idea is simple: you set yourself a task, choose the intervals of work and rest from templates, and press play!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  'Bubble comes preset with two time templates; 25 minutes work with a 5 minute break, or 50 minutes work with a 10 minute break. If either of these don’t suit, create your own time template in the My Templates screen.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  'Bubble on The Go',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                height: 40,
                width: 40,
                child: Bubble(
                  size: 60,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'This allows you to use any time template without planning your tasks ahead, just in case you need to do some Bubblin’ out of the blue.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                child: Bubble(
                  size: 50,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'To-do Bubbles',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Otherwise you can plan ahead by setting a goal, with a due date, description, time template, and amount of Bubbles. Once set up, you can edit it whenever you want, to add or remove Bubbles, or work away and get Bubblin\'.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'A Word of Warning...',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                child: Bubble(
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'To help you concentrate, Bubble has been made so that if you move off the timer screens, the Bubble timer gets reset!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 35,
                width: 35,
                child: Bubble(
                  size: 45,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Privacy Policy',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'We do not store or collect any of your data.\n\nAt all.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 45,
                width: 45,
                child: Bubble(
                  size: 45,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Further Development',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                height: 45,
                width: 45,
                child: Bubble(
                  size: 45,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Check out our development roadmap to see what we have planned for Bubble.\n\nFeedback and content suggestions are also welcome!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.cyan[100]
                      : Colors.cyan,
                  width: 3,
                ),
                child: Text('Roadmap',
                    style: Theme.of(context).textTheme.headline6),
                onPressed: () => _launchRoadmap(),
              ),
              OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.cyan[100]
                      : Colors.cyan,
                  width: 3,
                ),
                child: Text('Feedback',
                    style: Theme.of(context).textTheme.headline6),
                onPressed: () => _emailSupport(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
