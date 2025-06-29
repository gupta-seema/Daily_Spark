import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String quote;

  CustomDialog({required this.quote});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.teal.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Motivational Quote',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
      ),
      content: Text(
        quote,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ),
      ],
    );
  }
}
