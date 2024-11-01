import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Preview App',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _textController = TextEditingController();
  double _fontSize = 16.0; // Початковий розмір шрифту
  String? _message;

  Future<void> _navigateToPreview() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          text: _textController.text,
          size: _fontSize,
        ),
      ),
    );

    setState(() {
      if (result == 'ok') {
        _message = 'Cool!';
      } else if (result == 'cancel') {
        _message = 'Let’s try something else';
      } else {
        _message = 'Don\'t know what to say';
      }
    });

    if (_message != null) {
      _showDialog(_message!);
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090',
              width: 50,
              height: 50,
            ),
            SizedBox(height: 10),
            Text(message),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Text size: ${_fontSize.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 16),
            ),
            Slider(
              min: 10.0,
              max: 50.0,
              value: _fontSize,
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToPreview,
              child: Text('Preview'),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final String text;
  final double size;

  const PreviewScreen({required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: size),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'ok');
                  },
                  child: Text('Ok'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'cancel');
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
