import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pomo/clock/clock.dart';

enum TimerState { idle, running, paused }

class TimerPage extends StatefulWidget {
  const TimerPage({super.key, required this.title});

  final String title;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _counter = 0;
  Timer? _timer;
  TimerState _state = TimerState.idle;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter > 0 && _counter % ClockCircle.cycleLength == 0) {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _pauseTimer();
  }

  void _runTimer() {
    setState(() {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _incrementCounter();
      });
      _state = TimerState.running;
    });
  }

  void _pauseTimer() {
    setState(() {
      _timer?.cancel();
      _state = TimerState.paused;
    });
  }

  void _resetTimer() {
    setState(() {
      _timer?.cancel();
      _counter = 0;
      _state = TimerState.idle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ClockCircle(counter: _counter),
            const SizedBox(height: 20),
            TimerControls(
              state: _state,
              onRun: _runTimer,
              onPause: _pauseTimer,
              onReset: _resetTimer,
            ),
          ],
        ),
      ),
    );
  }
}

class TimerControls extends StatelessWidget {
  const TimerControls({
    super.key,
    required this.state,
    required this.onRun,
    required this.onPause,
    required this.onReset,
  });

  final TimerState state;
  final VoidCallback onRun;
  final VoidCallback onPause;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    if (state == TimerState.idle) {
      return TimerButton(onPressed: onRun, icon: Icons.play_arrow);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimerButton(
          onPressed: state == TimerState.running ? onPause : onRun,
          icon: state == TimerState.running ? Icons.pause : Icons.play_arrow,
        ),
        const SizedBox(width: 20),
        TimerButton(onPressed: onReset, icon: Icons.stop),
      ],
    );
  }
}

class TimerButton extends StatelessWidget {
  const TimerButton({super.key, required this.onPressed, required this.icon});

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50,
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}
