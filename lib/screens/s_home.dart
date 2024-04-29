import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pomo/common/widgets/w_time_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  bool _isRunning = false;
  int _pomodoroCount = 0; // Number of pomodoros completed
  int _focusTimeInSecond = 15 * 60; // Default focus time is 15 minutes
  final ValueNotifier<int> focusTimeNotifier = ValueNotifier<int>(15);
  int _userSelectedTimeInSecond = 15 * 60; // Default value is 15 minutes

  void startTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_isRunning) {
          setState(() {
            if (_focusTimeInSecond < 1) {
              timer.cancel();
              _pomodoroCount += 1; // Increment the pomodoro count
              resetTimer();
            } else if (_isRunning) {
              _focusTimeInSecond -= 1;
            }
          });
        }
      },
    );
  }

  void updateTime(int minutes) {
    setState(() {
      _focusTimeInSecond = minutes * 60; // Convert minutes to seconds
      _userSelectedTimeInSecond =
          _focusTimeInSecond; // Store the user's selected time
    });
    startTimer();
  }

  void resumeAndPauseTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    setState(() {
      _focusTimeInSecond = _userSelectedTimeInSecond;
      _isRunning = false;
    });
    _timer?.cancel();
    focusTimeNotifier.value =
        _userSelectedTimeInSecond ~/ 60; // Reset the slider
    startTimer(); // Start the timer after cancelling the previous one
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
                    '${_focusTimeInSecond ~/ 60}:${(_focusTimeInSecond % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 110,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ),
              ),
              TimeSlider(
                onTimeSelected: updateTime,
                focusTimeNotifier: focusTimeNotifier,
              ),
              Flexible(
                //Pomodoro Timer Play Button
                flex: 1,
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
