import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const TimerApp());
}

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int countdown = 120;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (countdown == 0) {
          timer.cancel(); // Stop the timer when countdown reaches zero
        } else {
          countdown--;
        }
      });
    });
  }

  void resend() {
    if (countdown == 0) {
      // Perform resend action here
      // For now, let's reset the countdown to 120 seconds
      setState(() {
        countdown = 120;
      });
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        leading: const Icon(Icons.access_time_rounded),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  children: [
                    const TextSpan(
                      text: "Time remaining: ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    TextSpan(
                      text: "$countdown ",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                    const TextSpan(
                      text: "seconds",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ]),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => resend(),
              // Disable the button when countdown reaches zero
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return countdown == 0 ? Colors.green : Colors.grey;
                  },
                ),
              ),
              child: const Text('Resend',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
