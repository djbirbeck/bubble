import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.cyan[400],
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Menu'),
            centerTitle: true,
            elevation: 0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.scatter_plot),
                title: Text('My Bubbles'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add a Bubble'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('More Information'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.av_timer),
                title: Text('Statistics'),
                onTap: () {},
              ),
            ],
          ),
        ),
      );
  }
}