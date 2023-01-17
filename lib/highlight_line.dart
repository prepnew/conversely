import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LineHighlighter extends StatefulWidget {
  final String dataToSpeak;
  const LineHighlighter({super.key, required this.dataToSpeak});

  @override
  LineHighlighterState createState() => LineHighlighterState();
}

class LineHighlighterState extends State<LineHighlighter> {
  late FlutterTts flutterTts;
  late String text;
  List<String> lines = [];
  int startIndex = 0;
  int endIndex = 0;
  int currentLineSpoken = 0;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    text = widget.dataToSpeak;
    lines = text.trim().split(RegExp(r'\n\n'));

    flutterTts.setCompletionHandler(() {
      setState(() {
        if (currentLineSpoken < lines.length) {
          currentLineSpoken = currentLineSpoken + 1;
          itemScrollController.scrollTo(
              index: currentLineSpoken,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOutCubic);
          flutterTts.speak(lines[currentLineSpoken]);
        }
      });
    });

    flutterTts.setErrorHandler((error) {});
    flutterTts.speak(lines[currentLineSpoken]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ScrollablePositionedList.builder(
          itemCount: lines.length,
          itemBuilder: (context, index) => LineW(
            doHighlight: index == currentLineSpoken,
            text: lines[index].trim(),
          ),
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
        ),
      )),
    );
  }

  @override
  void dispose() async {
    lines = [];
    currentLineSpoken = 0;
    await flutterTts.stop();
    super.dispose();
  }
}

class LineW extends StatelessWidget {
  final String text;
  final bool doHighlight;
  const LineW({
    super.key,
    required this.text,
    required this.doHighlight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16.00,
          color: doHighlight ? Colors.green : Colors.black,
          fontWeight: doHighlight ? FontWeight.bold : FontWeight.normal),
    );
  }
}
