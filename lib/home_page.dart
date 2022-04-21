import 'dart:async';

import 'package:custom_paint/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        
      });
    });
    super.initState();
  }
 @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var formattedTime = DateFormat('HH:mm').format(DateTime.now());
    var formattedDate = DateFormat('EEE, d MMM').format(DateTime.now());


    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          // color: const Color(0xff2d2f41),
          color: Colors.lightBlue.withOpacity(0.5),

          child: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
          
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Clock",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                DateWid(formattedString: formattedTime, size: 64,),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateWid(formattedString: formattedDate, size: 20,),
                ),

                const SizedBox(
                  height: 50,
                ),
                
                ClockView(
                  size: MediaQuery.of(context).size.height / 4,
                  hSize: MediaQuery.of(context).size.height / 4,
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateWid extends StatefulWidget {
  const DateWid({
    Key? key,
    required this.formattedString,
    required this.size
  }) : super(key: key);

  final String formattedString;
  final double size;

  @override
  State<DateWid> createState() => _DateWidState();
}

class _DateWidState extends State<DateWid> {
  
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.formattedString,
      style:  TextStyle(
        color: Colors.black,
        fontSize: widget.size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
