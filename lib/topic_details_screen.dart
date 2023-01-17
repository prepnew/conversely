import 'package:chatgpt_voice/api_services.dart';
import 'package:chatgpt_voice/highlight_line.dart';
import 'package:flutter/material.dart';

class TopicDetailsScreen extends StatefulWidget {
  final String topic;
  const TopicDetailsScreen({super.key, required this.topic});

  @override
  State<TopicDetailsScreen> createState() => _TopicDetailsScreenState();
}

class _TopicDetailsScreenState extends State<TopicDetailsScreen> {
  late String topic;
  String? response;

  @override
  void initState() {
    super.initState();
    topic = widget.topic;
    fetchTopicData();
  }

  void fetchTopicData() async {
    String search = 'long dialogue about  $topic';
    response = await ApiServices.searchQuery(search);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(topic),
          centerTitle: true,
        ),
        body: response == null
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : LineHighlighter(
                dataToSpeak: response ?? 'Got Nothing to speak',
              ));
  }
}
