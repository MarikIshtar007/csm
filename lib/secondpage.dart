import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  double currValue = 50.0;
  double rotAngle = 50.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF18181A),
        appBar: AppBar(
          backgroundColor: Color(0xFF18181A),
          brightness: Brightness.dark,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              size: 60,
              color: Colors.grey,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.65,
                    top: -MediaQuery.of(context).size.height * 0.1,
                    width: 450,
                    child: Transform.rotate(
                      angle: rotAngle,
                      child: Image.asset(
                        'assets/images/unnamed.png',
                        color: Color(0x99E7253A),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'TEMEPERATURE, °F',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${currValue.toInt()}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Set smart schedule',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE7253A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFE7253A),
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.snowflake,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFE7253A),
                                      ),
                                      child: Icon(
                                        Icons.settings,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFE7253A),
                                      ),
                                      child: Icon(
                                        Icons.menu,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(flex: 1, child: Container()),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Slider(
                  activeColor: Color(0xFFE7253A),
                  inactiveColor: Color(0x66E9273C),
                  min: 50.0,
                  max: 150.0,
                  divisions: 100,
                  value: currValue,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currValue = value;
                      rotAngle = value;
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
