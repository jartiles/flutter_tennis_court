import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tennis_court/models/court.dart';

class CourtsScreen extends StatelessWidget {
  const CourtsScreen({Key? key}) : super(key: key);

  static List<Court> courts = [
    Court('A', 'Grama (A)', 'assets/grass.jpg'),
    Court('B', 'Arcilla (B)', 'assets/clay.jpg'),
    Court('C', 'Dura (C)', 'assets/hard.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: courts.length,
              itemBuilder: (context, index) {
                final isLast = index == courts.length - 1;
                return _CourtCard(
                  court: courts[index],
                  index: index,
                  lastElement: isLast,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CourtCard extends StatelessWidget {
  const _CourtCard({
    Key? key,
    required this.court,
    required this.index,
    required this.lastElement,
  }) : super(key: key);

  final Court court;
  final int index;
  final bool lastElement;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: index * 200),
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, '/court-detail', arguments: court),
        child: Column(
          children: [
            _CourtImage(court: court),
            const SizedBox(height: 5),
            Text(
              court.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: lastElement ? 80 : 20,
            )
          ],
        ),
      ),
    );
  }
}

class _CourtImage extends StatelessWidget {
  const _CourtImage({Key? key, required this.court}) : super(key: key);

  final Court court;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Hero(
        tag: court.id,
        child: Image(
          image: AssetImage(court.imageRoute),
          width: 300,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
