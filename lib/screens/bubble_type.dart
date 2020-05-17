import 'package:Bubble/widgets/bubble_button.dart';
import 'package:flutter/material.dart';

class BubbleType extends StatelessWidget {
  final TabController tabController;
  final Function saveBubble;
  final Function updateBubbleType;
  final Function addBubble;
  final Function minusBubble;
  final String bubbleType;
  final double amountOfBubbles;
  final bool editing;

  BubbleType(
      {this.tabController,
      this.saveBubble,
      this.updateBubbleType,
      this.addBubble,
      this.minusBubble,
      this.bubbleType,
      this.amountOfBubbles,
      this.editing});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: editing ? () {} : () => updateBubbleType('small'),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 3,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).accentColor,
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              BubbleButton(
                                bubbleSizeMin: 50,
                                bubbleSizeMax: 80,
                                selected: bubbleType == 'small' ? true : false,
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'Small\nBubbles',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: editing ? () {} : () => updateBubbleType('big'),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 3,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).accentColor,
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              BubbleButton(
                                bubbleSizeMin: 80,
                                bubbleSizeMax: 100,
                                selected: bubbleType == 'big' ? true : false,
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'Big\nBubbles',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlue, width: 3),
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'How many bubbles?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.headline6.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            heroTag: 'minusFAB',
                            backgroundColor: Colors.lightBlueAccent[400],
                            elevation: 3,
                            mini: true,
                            child: Icon(Icons.remove),
                            onPressed: () => minusBubble(),
                          ),
                          Container(
                            width: 100,
                            alignment: Alignment.center,
                            child: Text(
                              amountOfBubbles.toStringAsFixed(0),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          FloatingActionButton(
                            heroTag: 'addFAB',
                            backgroundColor: Colors.lightBlueAccent[400],
                            elevation: 3,
                            mini: true,
                            child: Icon(Icons.add),
                            onPressed: () => addBubble(),
                          ),
                        ],
                      ),
                      Center(
                        child: Text(
                          '${bubbleType == 'small' ? (amountOfBubbles == 0 ? 0.0 : (amountOfBubbles / 2).toStringAsFixed(1)) : amountOfBubbles.toStringAsFixed(0)} hours of bubbling',
                          style: TextStyle(
                              fontSize: 18,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
