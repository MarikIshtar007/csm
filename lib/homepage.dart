import 'package:csm/secondpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final TextStyle headingStyle = TextStyle(
      fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    var iconSize = MediaQuery.of(context).size.width * 0.14;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.ac_unit,
                  size: iconSize,
                  color: Colors.blue[200],
                ),
                Column(
                  children: [
                    Text('COLD STORAGE', style: headingStyle),
                    Text(
                      'MANAGEMENT',
                      style: headingStyle,
                    ),
                  ],
                ),
                Icon(
                  Icons.ac_unit,
                  size: iconSize,
                  color: Colors.blue[200],
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.arrow_right, size: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
