import 'package:flutter/material.dart';

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
  double borderRadius = 12.0;
  Color buttonColor = Colors.red;
  Color buttonTextColor = Colors.white;

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
    return MouseRegion(
      onHover: (_) => setState(() => borderRadius = 24.0),
      onExit: (_) => setState(() => borderRadius = 12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
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
              MouseRegion(
                onHover: (_) => setState(() {
                  buttonColor = Colors.white;
                  buttonTextColor = Colors.black;
                }),
                onExit: (_) => setState(() {
                  buttonColor = Colors.red;
                  buttonTextColor = Colors.white;
                }),
                child: RaisedButton(
                  color: buttonColor,
                  onPressed: () {
                    // TODO
                  },
                  child: Text(
                    'Learn More',
                    style: TextStyle(color: buttonTextColor),
                  ),
                ),
              )
            ],
          ),
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
Over the years, Flutter has evolved from being a cross-platform mobile framework to a fully-fledged portable UI toolkit available on multiple operating systems and platforms.

For businesses, this is great since they can ship applications on multiple platforms and reach more users, but for us developers, it leaves us asking the question, How do I handle and respond to interaction on different platforms?

Join us as we explore Flutter's Material State properties and look at how it can help us respond to user interaction on multiple platforms.
                  ''',
        ),
      ];
}
