import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackWidget extends StatelessWidget {
  _launchRoadmap() async {
    const url = 'https://8bitbirbeck.co.uk/bubble-roadmap/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _emailSupport() async {
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'If you require support, you can use the Support & Feedback button to send an email.\n\nFeedback and content suggestions are also welcome!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
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
                child: Text(
                  'Support & Feedback',
                  style: Theme.of(context).textTheme.headline6,
                ),
                onPressed: () => _emailSupport(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'You can also check out our development roadmap to see what we have planned for Bubble.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: OutlineButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.cyan[100]
                  : Colors.cyan,
              width: 3,
            ),
            child: Text(
              'Roadmap',
              style: Theme.of(context).textTheme.headline6,
            ),
            onPressed: () => _launchRoadmap(),
          ),
        ),
      ],
    );
  }
}
