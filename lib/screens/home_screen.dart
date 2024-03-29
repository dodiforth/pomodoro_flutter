import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  int _start = 25 * 60; // 25 * 60 25 minutes in seconds
  bool _isRunning = false;
  int _pomodoroCount = 0; // Number of pomodoros completed

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_isRunning) {
          setState(() {
            if (_start < 1) {
              timer.cancel();
              _pomodoroCount += 1; // Increment the pomodoro count
              resetTimer();
            } else {
              _start = _start - 1;
            }
          });
        }
      },
    );
  }

  void resumeAndPauseTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    setState(() {
      _start = 25 * 60;
      _isRunning = false;
    });
    _timer?.cancel();
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Flexible(
                //Time
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 89,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  // child: Text(
                  //   '25:00',
                  //   style: TextStyle(
                  //     color: Theme.of(context).cardColor,
                  //     fontSize: 89,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                ),
              ),
              Flexible(
                //Pomodoro Timer Play Button
                flex: 2,
                child: Center(
                  child: IconButton(
                      icon: _isRunning
                          ? const Icon(Icons.pause_circle_filled_outlined)
                          : const Icon(Icons.play_circle_outlined),
                      iconSize: 110,
                      color: Theme.of(context).cardColor,
                      onPressed: resumeAndPauseTimer),
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pomodoros',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color),
                            ),
                            Text(
                              '$_pomodoroCount',
                              style: TextStyle(
                                  fontSize: 55,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 50.0,
            right: 10.0,
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded),
              color: Theme.of(context).cardColor,
              onPressed: resetTimer,
            ),
          ),
        ],
      ),
    );
  }
}
