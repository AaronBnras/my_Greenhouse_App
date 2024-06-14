import 'package:flutter/material.dart';

void showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Set Parameters'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              // controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Temperature parameters',
              ),
            ),
            SizedBox(height: 12,),
            TextField(
              // controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Humidity parameters',
              ),
            ),
            SizedBox(height: 12,),
            TextField(
              // controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Soil moisture parameters',
              ),
            ),
            SizedBox(height: 12,),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Set'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
