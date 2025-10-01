import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: FadingTextAnimation(
        toggleTheme: () {
          setState(() {
            _isDark = !_isDark;
          });
        },
        isDark: _isDark,
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDark;

  FadingTextAnimation({required this.toggleTheme, required this.isDark});

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.blue;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void pickColorBuiltIn() {
    final colors = <Color>[
      Colors.black,
      Colors.white,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.brown,
      Colors.pink,
      Colors.amber,
      Colors.indigo,
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: colors.map((c) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _textColor = c;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: c,
                      border: Border.all(width: 1, color: Colors.black12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          IconButton(
            icon: Icon(widget.isDark ? Icons.nights_stay : Icons.wb_sunny),
            onPressed: widget.toggleTheme,
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: pickColorBuiltIn,
          ),
        ],
      ),
      body: PageView(
        children: [
          Center(
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Text(
                'Hello, Flutter!',
                style: TextStyle(fontSize: 24, color: _textColor),
              ),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 3),
              child: Text(
                'Second Screen Fade!',
                style: TextStyle(fontSize: 28, color: _textColor),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
