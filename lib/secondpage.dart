import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  var humidity;
  double temperature;
  bool auto_mode = false;
  Timer _timer;
  double min = 5.0;
  double max = 40.0;
  double divisions = 25;
  TextEditingController minTextController = TextEditingController();
  TextEditingController maxTextController = TextEditingController();
  double rotAngle = 10.0;
  final _formKey = GlobalKey<FormState>();

  void apiCall() async {
    var uri =
        Uri.parse("https://node-red-gueqk-2021-05-08.eu-gb.mybluemix.net/CSM");
    var result = await http.get(uri);
    var body = json.decode(result.body);
    setState(() {
      humidity = body['humidity'];
      temperature = body['temperature'].toDouble();
      min = body['min'].toDouble();
      max = body['max'].toDouble();
    });
  }

  void updateTemp(double temp) async {
    var uri = Uri.parse(
        'https://node-red-gueqk-2021-05-08.eu-gb.mybluemix.net/command?command=ctemp-${temp.toInt()}');
    var response = await http.get(uri);
    print(response.statusCode);
  }

  void modeChange() async {
    var uri = Uri.parse(
        "https://node-red-gueqk-2021-05-08.eu-gb.mybluemix.net/status?command=change");
    var res = await http.get(uri);
    print(res.statusCode);
    setState(() {
      auto_mode = !auto_mode;
    });
  }

  @override
  void initState() {
    super.initState();
    apiCall();
    const repeatedCalls = const Duration(seconds: 5);
    _timer = Timer.periodic(repeatedCalls, (Timer t) => apiCall());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
        body: temperature == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                              color: Color(0xCCE7253A),
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
                                      'TEMEPERATURE, °C',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${temperature.toInt()}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 120,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15),
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          auto_mode
                                              ? Icon(
                                                  Icons.thermostat_outlined,
                                                  color: Colors.green[800],
                                                )
                                              : Icon(Icons.thermostat_outlined,
                                                  color: Color(0xFFE7253A)),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          auto_mode
                                              ? Text(
                                                  'Auto Mode ON',
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green[800],
                                                  ),
                                                )
                                              : Text(
                                                  'Auto Mode OFF',
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFE7253A),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                    //The three buttons
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            modeChange();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFE7253A),
                                            ),
                                            child: Icon(
                                                Icons.brightness_auto_outlined,
                                                size: 22),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    margin: EdgeInsets.all(40),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white),
                                                    ),
                                                    padding: EdgeInsets.all(20),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'HUMDITY',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          '${humidity}%',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 80),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFE7253A),
                                            ),
                                            child: Image.asset(
                                                'assets/images/humidity.png',
                                                color: Colors.white,
                                                width: 22),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    margin: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 30,
                                                        left: 10,
                                                        right: 10),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 40),
                                                    child: Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Temperature Range',
                                                            style: TextStyle(
                                                                fontSize: 24),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          TextFormField(
                                                            controller:
                                                                minTextController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  UnderlineInputBorder(),
                                                              labelText:
                                                                  'Min. Temperature',
                                                            ),
                                                          ),
                                                          TextFormField(
                                                            controller:
                                                                maxTextController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  UnderlineInputBorder(),
                                                              labelText:
                                                                  'Max.Temperature',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
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
                                      ],
                                    ),
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
                      min: -20,
                      max: 50,
                      divisions: 70,
                      value: temperature,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          temperature = value;
                          rotAngle = value;
                        });
                      },
                      onChangeEnd: (value) {
                        updateTemp(value);
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
