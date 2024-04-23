import 'package:flutter/material.dart';
import 'package:pomo/common/constants/app_colors.dart';

class TimeSlider extends StatefulWidget {
  final Function(int) onTimeSelected;
  final ValueNotifier<int> focusTimeNotifier;

  const TimeSlider(
      {super.key,
      required this.onTimeSelected,
      required this.focusTimeNotifier});

  @override
  State<TimeSlider> createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  double _focusTime = 15; // Initialize with the minimum focus time

  @override
  void initState() {
    super.initState();
    widget.focusTimeNotifier.addListener(updateSlider);
  }

  void updateSlider() {
    setState(() {
      _focusTime = widget.focusTimeNotifier.value.toDouble();
    });
  }

  @override
  void dispose() {
    widget.focusTimeNotifier.removeListener(updateSlider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.red[700],
            inactiveTrackColor: Colors.red[300],
            trackShape: const RoundedRectSliderTrackShape(),
            trackHeight: 10.0,
            thumbColor: Colors.redAccent,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
            overlayColor: Colors.red.withAlpha(32),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
            tickMarkShape: const RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.red[700],
            inactiveTickMarkColor: Colors.red[100],
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.redAccent,
            valueIndicatorTextStyle: const TextStyle(
              color: AppColors.warmWhite1,
            ),
          ),
          child: Slider(
            value: _focusTime,
            min: 15,
            max: 55,
            divisions: 8, // This allows users to select a value every 5 minutes
            label: _focusTime.round().toString(),
            onChanged: (double value) {
              setState(() {
                _focusTime = value;
                widget.onTimeSelected(_focusTime.round());
                widget.focusTimeNotifier.value =
                    _focusTime.round(); // Update the ValueNotifier
              });
            },
          ),
        ),
      ],
    );
  }
}
