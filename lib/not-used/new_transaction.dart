import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/bubble.dart';
import '../models/bubble.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  final AnimationController slideController;
  final BubbleTask bubbleToEdit;

  NewTransaction({this.addTx, this.slideController, this.bubbleToEdit});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction>
    with TickerProviderStateMixin {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final Duration _animationDuration = Duration(milliseconds: 400);
  double _buttonSize = 0;
  DateTime _selectedDate;

  @override
  void initState() {
    Timer(Duration(milliseconds: 800), () {
      setState(() {
        _buttonSize = 100;
      });
    });
    if (widget.bubbleToEdit != null) {
      _titleController.text = widget.bubbleToEdit.title;
      //_amountController.text = widget.bubbleToEdit.amount.toStringAsFixed(0);
    }
    super.initState();
  }

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  Future<bool> _reverseAnimation() {
    return Future(() => true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _reverseAnimation,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[50],
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.cyan[50],
                Colors.lightBlue[400],
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.only(left: 200),
                  child: Hero(
                    tag: 'bubble-2',
                    child: Bubble(size: 60),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: 'logoImage',
                      child: Image.asset('assets/images/logo.png', height: 80, width: 80,),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 60),
                      child: Text(
                        'Add a new\nBubble',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 80,
                  width: 80,
                  margin: EdgeInsets.only(right: 50),
                  child: Hero(
                    tag: 'bubble-1',
                    child: Bubble(size: 100),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: TextField(
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(labelText: 'Task name'),
                    controller: _titleController,
                    onSubmitted: (_) => submitData(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: TextField(
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(labelText: 'Time (minutes)'),
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _amountController,
                    onSubmitted: (_) => submitData(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: FlatButton(
                    onPressed: _presentDatePicker,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _selectedDate == null
                            ? 'Choose date'
                            : '${DateFormat.yMMMEd().format(_selectedDate)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    textColor: Theme.of(context).primaryColorDark,
                  ),
                ),
                Container(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AnimatedContainer(
                        duration: _animationDuration,
                        height: _buttonSize,
                        width: _buttonSize,
                        curve: Curves.bounceOut,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.grey[900],
                              width: _buttonSize == 0 ? 0 : 2),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.pink[100], Colors.red[400]],
                          ),
                        ),
                        child: FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Cancel',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          textColor: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                      ),
                      Center(
                        child: AnimatedContainer(
                          duration: _animationDuration,
                          height: _buttonSize,
                          width: _buttonSize,
                          curve: Curves.bounceOut,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey[900],
                                width: _buttonSize == 0 ? 0 : 2),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.lightGreen[100],
                                Colors.green[400]
                              ],
                            ),
                          ),
                          child: FlatButton(
                            onPressed: submitData,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Add',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            textColor: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
