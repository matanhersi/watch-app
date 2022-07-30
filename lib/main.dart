import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 4, 39, 59),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int seconds = 0, menuts = 0, hours = 0;
  String digitseconds = '00', digitmenuts = '00', digithours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];
  void stop() {
    timer!.cancel();
    setState(
      () {
        started = false;
      },
    );
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      menuts = 0;
      hours = 0;
      digitseconds = "00";
      digitmenuts = "00";
      digithours = "00";
      started = false;
    });
  }

  void addlaps() {
    String lap = "$digithours:$digitmenuts:$digitseconds";
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localseconds = seconds + 1;
      int localmenuts = menuts;
      int localhours = hours;
      if (localseconds > 59) {
        if (localmenuts > 59) {
          localhours++;
          localmenuts = 0;
        } else {
          localmenuts++;
          localseconds = 0;
        }
      }
      setState(() {
        seconds = localseconds;
        menuts = localmenuts;
        hours = localhours;
        digitseconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitmenuts = (menuts >= 10) ? "$menuts" : "0$menuts";
        digithours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Stop Watch',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              '$digithours:$digitmenuts:$digitseconds',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: 400,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 3, 25, 38),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: laps.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "lap${index + 1}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "${laps[index]}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  );
                })),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RawMaterialButton(
                  onPressed: () {
                    (!started) ? start() : stop();
                  },
                  shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
                  child: Text(
                    (!started) ? "start" : "Pouse",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              IconButton(
                onPressed: () {
                  addlaps();
                },
                icon: Icon(
                  Icons.flag,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: RawMaterialButton(
                  onPressed: () {
                    reset();
                  },
                  shape: StadiumBorder(),
                  fillColor: Colors.blue,
                  child: Text(
                    'reset',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
