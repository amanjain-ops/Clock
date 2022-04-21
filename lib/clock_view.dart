import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({required this.size, required this.hSize, Key? key})
      : super(key: key);
  final double size;
  final double hSize;
  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  late Timer timer;
  @override
  void initState() {
   timer =  Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
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
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        // width: MediaQuery.of(context).size.width * 0.7 ,
        // height: MediaQuery.of(context).size.height / 2,
        width: widget.size,
        height: widget.hSize,
        // color: Colors.green,
    
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var innerCircleBrush = Paint()
      // ..color = const Color(0xff444974)
      // ..color = Colors.grey.withOpacity(0.15);
      ..color = Colors.black26.withOpacity(0.7);

    var outLineBrush = Paint()
      // ..color = const Color(0xffeaecff)
      ..color = Colors.lightBlue.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20;

    var centerBrush = Paint()..color = const Color(0xffeaecff);

    var secHandBrush = Paint()
      ..color = Colors.orange.shade300
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 150;

    var minHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xff748ef6), Color(0xff77ddff)])
              .createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 75;

    var hourHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xffea74ab), Color(0xffc279fb)])
              .createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 70;

    var dashBrush = Paint()
      ..color = const Color(0xffeaecff)
      ..strokeWidth = 1;


//  inner circle 
    canvas.drawCircle(center, radius * 0.75, innerCircleBrush);

// outter circle
    
    canvas.drawCircle(center, radius * 0.75, outLineBrush);

//  

    var outerCircleRadius = radius * 0.6;
    // var innerCircleRadius = radius - 75;

    for (double i = 0; i < 360; i += 90) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerY + outerCircleRadius * sin(i * pi / 180);

      // var x2 = centerX + innerCircleRadius * cos(i* pi / 180);
      // var y2 = centerY + innerCircleRadius * sin(i * pi / 180);

      canvas.drawCircle(Offset(x1, y1), 3, dashBrush);

// Hour hand 
      var hourHandX = centerX +
          radius *
              0.36 *
              cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
      var hourHandY = centerY +
          radius *
              0.36 *
              sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
      canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

// min Hand 
      var minHandX =
          centerX + radius * 0.48 * cos(dateTime.minute * 6 * pi / 180);
      var minHandY =
          centerY + radius * 0.48 * sin(dateTime.minute * 6 * pi / 180);
      canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);


//  sec Hand
      var secHandX =
          centerX + radius * 0.54 * cos(dateTime.second * 6 * pi / 180);
      var secHandY =
          centerY + radius * 0.54 * sin(dateTime.second * 6 * pi / 180);

      canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);
      
// center circle
      canvas.drawCircle(center, radius * 0.07, centerBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
