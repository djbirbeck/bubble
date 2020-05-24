import 'package:flutter/material.dart';

import '../models/timer_template.dart';

class TemplateListItem extends StatelessWidget {
  final TimerTemplate timerTemplate;
  final int index;

  TemplateListItem({
    this.timerTemplate,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4),
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.lightBlue[100], width: 2),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ],
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 66,
                width: 66,
                margin: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.lightBlue[100],
                    width: 2,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.purple[50]
                          : Colors.indigo[900],
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${timerTemplate.workTime.toString()}m',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily:
                            Theme.of(context).textTheme.headline6.fontFamily,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'work',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  timerTemplate.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        Theme.of(context).textTheme.headline6.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                height: 66,
                width: 66,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.lightBlue[100],
                    width: 2,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.purple[50]
                          : Colors.indigo[900],
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${timerTemplate.restTime.toString()}m',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily:
                            Theme.of(context).textTheme.headline6.fontFamily,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'rest',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
