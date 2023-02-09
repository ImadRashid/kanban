import 'package:flutter/material.dart';
import 'package:karbanboard/ui/screens/board/kanban_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // KanbanBoardProvider model = Provider.of<KanbanBoardProvider>(context);
    return Consumer<KanbanBoardProvider>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [],
          ),
        );
      },
    );
  }
}
