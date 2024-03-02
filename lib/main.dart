import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Stopwatch',
      home: StopwatchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _display = '00:00:00';

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _display = _formatStopwatch(_stopwatch.elapsedMilliseconds);
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {
      _display = '00:00:00';
    });
  }

  String _formatStopwatch(int milliseconds) {
    int minutes = (milliseconds / (1000 * 60)).floor();
    int seconds = ((milliseconds / 1000) % 60).floor();
    int ms = (milliseconds % 1000) ~/ 10;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${ms.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Stopwatch',
            style: TextStyle(fontSize: 32),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _display,
              style: const TextStyle(
                fontSize: 72.0,
                color: Colors.white,
                fontFamily: 'Digital',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    if (!_stopwatch.isRunning) {
                      _startTimer();
                      _stopwatch.start();
                    }
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.play_arrow),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    if (_stopwatch.isRunning) {
                      _pauseTimer();
                      _stopwatch.stop();
                    }
                  },
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.pause),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    if (!_stopwatch.isRunning) {
                      _resetTimer();
                    }
                  },
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.stop),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
