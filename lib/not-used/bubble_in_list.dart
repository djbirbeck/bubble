import 'package:flutter/material.dart';
import '../widgets/bubble.dart';

class BubbleInList extends StatelessWidget {
  // final BubbleTask bubble;
  // final Function addFunction;
  // final Function deleteFunction;
  // final Function animateTransition;
  // final int index;

  //BubbleInList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        children: [
          Positioned(
            height: 50,
            width: 50,
            left: 20,
            top: 20,
            child: Bubble(size: 50),
          ),
          Card(
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            color: Colors.transparent,
            elevation: 0,
            child: Bubble(
              size: 200,
              childWidget: Container(
                height: 100, width: 100,
                padding: EdgeInsets.only(left: 4, top: 0, right: 4, bottom: 8),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0',
                        ),
                        Text(' hours')
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'title',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                    Text(
                      'date',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(300),
              ),
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.redAccent[700], width: 2),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.pink[50],
                      Colors.red[200],
                    ],
                  ),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.grey[800],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 30,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(300),
              ),
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.tealAccent[700], width: 2),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.cyan[50],
                      Colors.teal[200],
                    ],
                  ),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.grey[800],
                  ),
                  onPressed: () => {
                  //   animateTransition(
                  //   screen: NewTransaction(
                  //     bubbleToEdit: bubble,
                  //     addTx: addFunction,
                  //   ),
                  // );
                  }
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            bottom: 2,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(300),
              ),
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Colors.lightGreenAccent[700], width: 2),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.cyan[50],
                      Colors.lightGreen[200],
                    ],
                  ),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.grey[800],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
