import 'package:flutter/material.dart';
import 'package:material_state_demo/interactive_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Vancouver 👋',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Flutter Vancouver 👋'),
      ),
      body: Center(
          child: SpeakerCard(
        speaker: Speaker.mockSpeakers.first,
      )),
    );
  }
}

class SpeakerCard extends StatefulWidget {
  const SpeakerCard({
    Key? key,
    required this.speaker,
  }) : super(key: key);

  final Speaker speaker;

  @override
  _SpeakerCardState createState() => _SpeakerCardState();
}

class _SpeakerCardState extends State<SpeakerCard> {
  Widget _buildCardHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 44.0,
            backgroundImage: NetworkImage(
              widget.speaker.imageUrl,
            ),
          ),
          const SizedBox(width: 24.0),
          Flexible(
            child: Text(
              widget.speaker.name,
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCardContent() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          widget.speaker.talkDescription,
          style: TextStyle(
            color: Colors.black87,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const vSpacing = SizedBox(height: 24.0);
    return InteractiveCard(
      shape: CardBorder(),
      margin: const EdgeInsets.all(24.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCardHeader(),
            vSpacing,
            _buildCardContent(),
            vSpacing,
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: CardButtonColor(),
              ),
              onPressed: () {
                // TODO
              },
              child: Text(
                'Learn More',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}

@immutable
class Speaker {
  Speaker({
    required this.name,
    required this.imageUrl,
    required this.talkDescription,
  });

  final String name;
  final String imageUrl;
  final String talkDescription;

  static get mockSpeakers => [
        Speaker(
          name: 'Neevash Ramdial',
          imageUrl: 'https://neevash.dev/assets/images/image01.jpg?v=61be2a2b',
          talkDescription: ''' 
Something interesting...
                  ''',
        ),
      ];
}
