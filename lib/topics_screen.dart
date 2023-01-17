import 'package:chatgpt_voice/topic_details_screen.dart';
import 'package:flutter/material.dart';

class TopicsListScreen extends StatelessWidget {
  const TopicsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> topics = [
      'Hobbies and interests',
      'Travel and vacation plans',
      'Current events and news',
      'Weather and climate',
      'Movies and TV shows',
      'Food and cooking',
      'Sports and fitness',
      'Work and career',
      'Technology and gadgets',
      'Family and relationships'
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversely'),
        centerTitle: true,
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                height: 4.00,
              ),
          itemCount: topics.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => TopicDetailsScreen(
                                topic: topics[index],
                              ))));
                },
                title: Text(
                  topics[index],
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            );
          }),
    );
  }
}
