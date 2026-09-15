
import 'package:flutter/material.dart';

void main() {
  runApp(const DigitalMixerApp());
}

class DigitalMixerApp extends StatelessWidget {
  const DigitalMixerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Mixer',
      theme: ThemeData.dark(),
      home: const MixerPage(),
    );
  }
}

class MixerPage extends StatefulWidget {
  const MixerPage({super.key});

  @override
  State<MixerPage> createState() => _MixerPageState();
}

class _MixerPageState extends State<MixerPage> {
  final List<double> levels = List.filled(8, 0.7);
  final List<bool> muted = List.filled(8, false);
  final List<bool> solo = List.filled(8, false);
  final List<double> pans = List.filled(8, 0.0);

  double master = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        centerTitle: true,
        title: const Text(
          'DIGITAL MIXER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 45,
            color: const Color(0xFF191919),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('INPUT'),
                Text('8 CHANNEL'),
                Text('MASTER'),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < 8; i++) channel(i),
                  masterChannel(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget channel(int i) {
    return Container(
      width: 110,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF292929),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          Text(
            'CH ${i + 1}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 8),

          const Icon(Icons.mic, size: 22),

          const SizedBox(height: 8),

          const Text(
            'GAIN',
            style: TextStyle(fontSize: 10),
          ),

          Slider(
            value: levels[i],
            onChanged: muted[i]
                ? null
                : (value) {
                    setState(() {
                      levels[i] = value;
                    });
                  },
          ),

          Text(
            '${(levels[i] * 100).round()}%',
            style: const TextStyle(fontSize: 11),
          ),

          const SizedBox(height: 5),

          const Text(
            'PAN',
            style: TextStyle(fontSize: 10),
          ),

          Slider(
            value: pans[i],
            min: -1,
            max: 1,
            onChanged: (value) {
              setState(() {
                pans[i] = value;
              });
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button(
                'M',
                muted[i],
                () {
                  setState(() {
                    muted[i] = !muted[i];
                  });
                },
              ),
              button(
                'S',
                solo[i],
                () {
                  setState(() {
                    solo[i] = !solo[i];
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 8),

          Expanded(
            child: RotatedBox(
              quarterTurns: 3,
              child: Slider(
                value: levels[i],
                min: 0,
                max: 1,
                onChanged: muted[i]
                    ? null
                    : (value) {
                        setState(() {
                          levels[i] = value;
                        });
                      },
              ),
            ),
          ),

          Text(
            '${((levels[i] * 100) - 100).round()} dB',
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget masterChannel() {
    return Container(
      width: 125,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF353535),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white30),
      ),
      child: Column(
        children: [
          const Text(
            'MASTER',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 12),

          const Icon(
            Icons.speaker,
            size: 28,
          ),

          const SizedBox(height: 8),

          const Text(
            'MASTER LEVEL',
            style: TextStyle(fontSize: 11),
          ),

          Expanded(
            child: RotatedBox(
              quarterTurns: 3,
              child: Slider(
                value: master,
                min: 0,
                max: 1,
                onChanged: (value) {
                  setState(() {
                    master = value;
                  });
                },
              ),
            ),
          ),

          Text(
            '${((master * 100) - 100).round()} dB',
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              setState(() {
                master = 0.8;
              });
            },
            child: const Text('RESET'),
          ),
        ],
      ),
    );
  }

  Widget button(
    String text,
    bool active,
    VoidCallback action,
  ) {
    return SizedBox(
      width: 40,
      height: 32,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor:
              active ? Colors.red : const Color(0xFF444444),
        ),
        child: Text(text),
      ),
    );
  }
}
