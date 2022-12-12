import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tennis_court/providers/providers.dart';

import 'package:flutter_tennis_court/models/court.dart';

import 'package:flutter_tennis_court/widgets/widgets.dart';

class CourtDetailScreen extends StatelessWidget {
  const CourtDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final court = ModalRoute.of(context)!.settings.arguments as Court;

    return ChangeNotifierProvider(
      create: (context) => FormProvider(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomSliverAppBar(court: court),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BookingForm(court: court),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({Key? key, required this.court}) : super(key: key);

  final Court court;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180,
      elevation: 0,
      pinned: true,
      centerTitle: true,
      title: Text(
        court.name,
        style: const TextStyle(
          shadows: [Shadow(color: Colors.black87, offset: Offset(0.3, 2))],
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: court.id,
          child: Image.asset(court.imageRoute, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
