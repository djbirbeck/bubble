import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../screens/new_bubble_tabs.dart';
import './bubble_in_list.dart';
import '../widgets/hero_bubbles.dart';
import '../widgets/bubble.dart';
import '../widgets/basic_scaffold.dart';
import '../transitions/slide_right.dart';
import '../models/bubble.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _slideController;
  AnimationController _gridSlideController;

  //Box _bubbleBox = Hive.box<BubbleTask>('bubbles');

  // List<BubbleTask> get _recentTransactions {
  //   return _bubbleBox.values.where((element) {
  //     return element.dueDate.isAfter(
  //       DateTime.now().subtract(
  //         Duration(days: 7),
  //       ),
  //     );
  //   }).toList();
  // }

  void _addBubble(BuildContext ctx) {
    setState(() {
      _slideController.reverse();
      _gridSlideController.reverse();
    });
    Timer(Duration(milliseconds: 300), () async {
      await Navigator.push(
        context,
        SlideRightRoute(
          page: NewBubbleTabs(),
        ),
      );
      Timer(Duration(milliseconds: 600), () {
        setState(() {
          _slideController.forward();
          _gridSlideController.forward();
        });
      });
    });
  }

  // void _animateToInfo({Widget screen}) {
  //   setState(() {
  //     _slideController.reverse();
  //     _gridSlideController.reverse();
  //   });
  //   Timer(Duration(milliseconds: 300), () async {
  //     await Navigator.push(
  //       context,
  //       SlideRightRoute(
  //         page: screen,
  //       ),
  //     );
  //     Timer(Duration(milliseconds: 600), () {
  //       setState(() {
  //         _slideController.forward();
  //         _gridSlideController.forward();
  //       });
  //     });
  //   });
  // }

  // void _deleteTransaction(int id) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(32),
  //         ),
  //         title: Text('Delete this bubble?'),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text(
  //               "Delete",
  //               style: TextStyle(color: Colors.red),
  //             ),
  //             onPressed: () {
  //               _bubbleBox.deleteAt(id);
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           FlatButton(
  //             child: Text(
  //               "Keep",
  //               style: TextStyle(color: Colors.green),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    _slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _gridSlideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    Timer(Duration(seconds: 1), () {
      setState(() {
        _slideController.forward();
        _gridSlideController.forward();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      childWidget: Stack(
        children: [
          Transform.translate(
            offset: Offset(-200.0, 700.0),
            child: Hero(
              tag: 'bubble-3',
              child: Container(
                height: 90,
                width: 90,
                child: Bubble(
                  size: 90,
                  childWidget: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(''),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 600),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey[700],
                                  width: 2,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.cyan[50],
                                    Colors.lightGreen[400]
                                  ],
                                ),
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(Icons.play_arrow),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(400, 500),
            child: Hero(
              tag: 'amount-bubble',
              child: Bubble(
                size: 80,
                childWidget: Center(
                  child: Text(
                    '',
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              // Container(
              //   height: 160,
              //   child: Stack(
              //     children: [
              //       SlideTransition(
              //         position: Tween(
              //           begin: const Offset(-1.0, 0.0),
              //           end: const Offset(0.0, 0.0),
              //         ).animate(CurvedAnimation(
              //           parent: _slideController,
              //           curve: Curves.ease,
              //         )),
              //         child: TodaysBubble(
              //           todaysTransaction: _recentTransactions,
              //         ),
              //       ),
              //       HeroBubbles(),
              //     ],
              //   ),
              // ),
              // Container(
              //   height: 80,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Container(
              //         width: MediaQuery.of(context).size.width * 0.4,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(30),
              //           border: Border.all(color: Colors.purple[50], width: 2),
              //           gradient: LinearGradient(
              //             begin: Alignment.topCenter,
              //             end: Alignment.bottomCenter,
              //             colors: [
              //               Colors.purple[50],
              //               Colors.lightBlue[200],
              //             ],
              //           ),
              //         ),
              //         child: FlatButton(
              //           onPressed: () {},
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(32)),
              //           padding:
              //               EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              //           child: FittedBox(
              //             fit: BoxFit.scaleDown,
              //             child: Text(
              //               'Sort',
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         width: MediaQuery.of(context).size.width * 0.4,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(30),
              //           border: Border.all(color: Colors.purple[50], width: 2),
              //           gradient: LinearGradient(
              //             begin: Alignment.topCenter,
              //             end: Alignment.bottomCenter,
              //             colors: [
              //               Colors.purple[50],
              //               Colors.lightBlue[200],
              //             ],
              //           ),
              //         ),
              //         child: FlatButton(
              //           onPressed: () {},
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(32)),
              //           padding:
              //               EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              //           child: FittedBox(
              //             fit: BoxFit.scaleDown,
              //             child: Text(
              //               'Filter',
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(0.0, 1.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(
                    parent: _gridSlideController,
                    curve: Curves.ease,
                  )),
                  child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<BubbleTask>('bubbles').listenable(),
                    builder: (context, Box<BubbleTask> box, _) {
                      if (box.values.isEmpty) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black, width: 2),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.cyan[50],
                                  Colors.blue[200],
                                ],
                              ),
                            ),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 24),
                              onPressed: () => _addBubble(context),
                              child: Text('Add a Bubble?'),
                            ),
                          ),
                        );
                      }
                      // return ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: box.values.length,
                      //   itemBuilder: (BuildContext context, index) {
                      //     BubbleTask currentBubble = box.getAt(index);
                      //     return ListBubble(
                      //       bubble: currentBubble,
                      //       index: index,
                      //       addFunction: _addBubble,
                      //       deleteFunction: _deleteTransaction,
                      //       animateTransition: _animateToInfo,
                      //     );
                      //   },
                      // );
                      return CustomScrollView(
                        slivers: <Widget>[
                          SliverAppBar(
                            pinned: true,
                            expandedHeight: 220.0,
                            backgroundColor: Colors.cyan[50],
                            elevation: 0,
                            bottom: AppBar(
                              backgroundColor: Colors.cyan[50],
                              title: Text('My Bubbles'),
                              elevation: 3,
                              actions: <Widget>[
                              IconButton(
                                  onPressed: () {},
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 24),
                                  icon: Icon(Icons.sort)),
                              IconButton(
                                  onPressed: () {},
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 24),
                                  icon: Icon(Icons.filter_list)),
                            ],
                            ),
                            flexibleSpace: FlexibleSpaceBar(
                              // stretchModes: <StretchMode>[
                              //   StretchMode.zoomBackground,
                              //   StretchMode.blurBackground,
                              //   StretchMode.fadeTitle,
                              // ],
                              collapseMode: CollapseMode.pin,
                              centerTitle: false,
                              title: Text('My Bubbles'),
                              background: Stack(
                                children: [
                                  // TodaysBubble(
                                  //   todaysTransaction: _recentTransactions,
                                  // ),
                                  HeroBubbles(),
                                ],
                              ),
                            ),
                          ),
                          SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                //BubbleTask currentBubble = box.getAt(index);
                                return BubbleInList(
                                  // bubble: currentBubble,
                                  // index: index,
                                  // addFunction: _addBubble,
                                  // deleteFunction: _deleteTransaction,
                                  // animateTransition: _animateToInfo,
                                );
                              },
                              childCount: box.values.length,
                            ),
                          ),
                        ],
                      );
                      // return GridView.builder(
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 2),
                      //   itemCount: box.values.length,
                      //   itemBuilder: (BuildContext context, index) {
                      //     BubbleTask currentBubble = box.getAt(index);
                      //     return BubbleInList(
                      //       bubble: currentBubble,
                      //       index: index,
                      //       addFunction: _addBubble,
                      //       deleteFunction: _deleteTransaction,
                      //       animateTransition: _animateToInfo,
                      //     );
                      //   },
                      // );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomWidget: SlideTransition(
        position: Tween(
          begin: const Offset(0.0, 1.0),
          end: const Offset(0.0, 0.0),
        ).animate(CurvedAnimation(
          parent: _slideController,
          curve: Curves.ease,
        )),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Card(
            margin: EdgeInsets.only(left: 16, bottom: 16, right: 16),
            color: Colors.lightBlue[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            elevation: 4,
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          bottomLeft: Radius.circular(32),
                        ),
                      ),
                      child: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: (){},
                      // onPressed: () {
                      //   _animateToInfo(
                      //     screen: ListAllScreen(),
                      //   );
                      // },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () => _addBubble(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
