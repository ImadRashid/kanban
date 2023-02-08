import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:karbanboard/screens/kanban_provider.dart';
import 'package:provider/provider.dart';

class KanbanBoard extends StatefulWidget {
  const KanbanBoard({Key? key}) : super(key: key);

  @override
  State<KanbanBoard> createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  @override
  Widget build(BuildContext context) {
    KanbanBoardProvider model = Provider.of<KanbanBoardProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Kanban Board")),
      body: AppFlowyBoard(
        controller: model.controller,
        cardBuilder: (context, group, groupItem) {
          return AppFlowyGroupCard(
            key: ValueKey(groupItem.id),
            child: _buildCard(groupItem),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          );
        },
        boardScrollController: model.boardController,
        footerBuilder: (context, columnData) {
          return SafeArea(
            bottom: true,
            child: AppFlowyGroupFooter(
              icon: const Icon(Icons.add, size: 20),
              title: const Text('Add New'),
              height: 50,
              margin: model.config.groupItemPadding,
              onAddButtonClick: () {
                // setState(() {
                //   group1!.items.add(TextItem("Hello there"));
                // });

                model.boardController.scrollToBottom(
                  columnData.id,
                );

                customDailgue(columnTitle: columnData.id);

                // setState(() {
                //   tempList.add(TextItem("added new"));
                // });

                // print(columnData.id.toString());

                // AppFlowyGroupData(id: )
              },
            ),
          );
        },
        headerBuilder: (context, columnData) {
          return AppFlowyGroupHeader(
            icon: const Icon(Icons.lightbulb_circle),
            title: Text(columnData.headerData.groupName),
            height: 50,
          );
        },
        groupConstraints: const BoxConstraints.tightFor(width: 240),
        config: model.config,
      ),
    );
  }

  customDailgue({final columnTitle}) {
    var cardTitle;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(children: [
                Text("Add Card to ${columnTitle}"),
                TextField(
                  onChanged: (value) {
                    cardTitle = value.toString();
                  },
                  decoration: InputDecoration(hintText: 'Enter Card Title'),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        // tempList.add(TextItem(cardTitle));
                      });

                      Navigator.pop(context);
                    },
                    child: Text("Save"))
              ]),
            ),
          );
        });
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is TextItem) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Text(item.s),
        ),
      );
    }

    if (item is RichTextItem) {
      return RichTextCard(item: item);
    }

    throw UnimplementedError();
  }
}

class RichTextCard extends StatefulWidget {
  final RichTextItem item;
  const RichTextCard({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<RichTextCard> createState() => _RichTextCardState();
}

class _RichTextCardState extends State<RichTextCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              widget.item.subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class TextItem extends AppFlowyGroupItem {
  final String s;

  TextItem(this.s);

  @override
  String get id => s;
}

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String subtitle;

  RichTextItem({required this.title, required this.subtitle});

  @override
  String get id => title;
}
