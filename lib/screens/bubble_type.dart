import 'package:Bubble/widgets/bubble_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BubbleType extends StatelessWidget {
  final TabController tabController;
  final Function saveBubble;
  final Function updateBubbleType;
  final Function addBubble;
  final Function minusBubble;
  final String bubbleType;
  final double amountOfBubbles;
  final bool editing;

  DateTime _selectedDate;

  BubbleType({
    this.tabController,
    this.saveBubble,
    this.updateBubbleType,
    this.addBubble,
    this.minusBubble,
    this.bubbleType,
    this.amountOfBubbles,
    this.editing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Semantics(
              //       label: 'Small bubble toggle button',
              //       selected: bubbleType == 'small' ? true : false,
              //       child: InkWell(
              //         onTap:
              //             editing ? () {} : () => updateBubbleType('small'),
              //         child: Card(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(24),
              //           ),
              //           elevation: 3,
              //           child: Container(
              //             height: MediaQuery.of(context).size.height * 0.3,
              //             width: MediaQuery.of(context).size.width * 0.4,
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 color: Colors.lightBlue,
              //                 width: 3,
              //               ),
              //               borderRadius: BorderRadius.circular(24),
              //               gradient: LinearGradient(
              //                 begin: Alignment.topLeft,
              //                 end: Alignment.bottomRight,
              //                 colors: [
              //                   Theme.of(context).primaryColor,
              //                   Theme.of(context).accentColor,
              //                 ],
              //               ),
              //             ),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Container(),
              //                 BubbleButton(
              //                   bubbleSizeMin: 50,
              //                   bubbleSizeMax: 80,
              //                   selected:
              //                       bubbleType == 'small' ? true : false,
              //                 ),
              //                 Container(
              //                   padding: EdgeInsets.only(bottom: 12),
              //                   child: Text(
              //                     'Small\nBubbles',
              //                     textAlign: TextAlign.center,
              //                     style:
              //                         Theme.of(context).textTheme.headline6,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Semantics(
              //       label: 'Big buble toggle button',
              //       selected: bubbleType == 'big' ? true : false,
              //       child: InkWell(
              //         onTap: editing ? () {} : () => updateBubbleType('big'),
              //         child: Card(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(24),
              //           ),
              //           elevation: 3,
              //           child: Container(
              //             height: MediaQuery.of(context).size.height * 0.3,
              //             width: MediaQuery.of(context).size.width * 0.4,
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 color: Colors.lightBlue,
              //                 width: 3,
              //               ),
              //               borderRadius: BorderRadius.circular(24),
              //               gradient: LinearGradient(
              //                 begin: Alignment.topLeft,
              //                 end: Alignment.bottomRight,
              //                 colors: [
              //                   Theme.of(context).primaryColor,
              //                   Theme.of(context).accentColor,
              //                 ],
              //               ),
              //             ),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Container(),
              //                 BubbleButton(
              //                   bubbleSizeMin: 80,
              //                   bubbleSizeMax: 100,
              //                   selected: bubbleType == 'big' ? true : false,
              //                 ),
              //                 Container(
              //                   padding: EdgeInsets.only(bottom: 12),
              //                   child: Text(
              //                     'Big\nBubbles',
              //                     textAlign: TextAlign.center,
              //                     style:
              //                         Theme.of(context).textTheme.headline6,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.2,
              //   margin: EdgeInsets.symmetric(vertical: 8),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.lightBlue, width: 3),
              //     borderRadius: BorderRadius.circular(24),
              //     gradient: LinearGradient(
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //       colors: [
              //         Theme.of(context).primaryColor,
              //         Theme.of(context).accentColor,
              //       ],
              //     ),
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Text(
              //         'How many $bubbleType bubbles?',
              //         style: Theme.of(context).textTheme.headline6,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Semantics(
              //             label: 'minus button',
              //             child: FloatingActionButton(
              //               heroTag: 'minusFAB',
              //               backgroundColor: Colors.lightBlueAccent[400],
              //               elevation: 3,
              //               mini: true,
              //               child: Icon(Icons.remove),
              //               onPressed: () => minusBubble(),
              //             ),
              //           ),
              //           Container(
              //             width: 100,
              //             alignment: Alignment.center,
              //             child: Text(
              //               amountOfBubbles.toStringAsFixed(0),
              //               style: TextStyle(
              //                   fontSize: 24,
              //                   fontWeight: FontWeight.bold,
              //                   fontFamily: Theme.of(context)
              //                       .textTheme
              //                       .headline6
              //                       .fontFamily),
              //             ),
              //           ),
              //           Semantics(
              //             label: 'add button',
              //             child: FloatingActionButton(
              //               heroTag: 'addFAB',
              //               backgroundColor: Colors.lightBlueAccent[400],
              //               elevation: 3,
              //               mini: true,
              //               child: Icon(Icons.add),
              //               onPressed: () => addBubble(),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Center(
              //         child: Text(
              //           '${bubbleType == 'small' ? (amountOfBubbles == 0 ? 0.0 : (amountOfBubbles / 2).toStringAsFixed(1)) : amountOfBubbles.toStringAsFixed(0)} hours of bubbling',
              //           style: Theme.of(context).textTheme.headline6,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.lightBlue, width: 3),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                ),
                child: FlatButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Bubble Template',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: 8,
                ),
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
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Semantics(
                          label: 'minus button',
                          child: FloatingActionButton(
                            heroTag: 'minusFAB',
                            backgroundColor: Colors.lightBlueAccent[400],
                            elevation: 3,
                            mini: true,
                            child: Icon(Icons.remove),
                            onPressed: () => minusBubble(),
                          ),
                        ),
                        Container(
                          width: 100,
                          alignment: Alignment.center,
                          child: Text(
                            amountOfBubbles.toStringAsFixed(0),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .fontFamily,
                            ),
                          ),
                        ),
                        Semantics(
                          label: 'add button',
                          child: FloatingActionButton(
                            heroTag: 'addFAB',
                            backgroundColor: Colors.lightBlueAccent[400],
                            elevation: 3,
                            mini: true,
                            child: Icon(Icons.add),
                            onPressed: () => addBubble(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 66,
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.3),
          child: Card(
            margin: EdgeInsets.only(
              bottom: 16,
              right: 0,
            ),
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            elevation: 4,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 600),
                        child: Text(
                          'Save',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      onPressed: () => saveBubble(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
