import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';

class MultiBoardListExample extends StatefulWidget {
  const MultiBoardListExample({Key? key}) : super(key: key);

  @override
  State<MultiBoardListExample> createState() => _MultiBoardListExampleState();
}

class _MultiBoardListExampleState extends State<MultiBoardListExample> {
// Define Board Controller

  final AppFlowyBoardController controller = AppFlowyBoardController(
    // onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
    //   debugPrint('Move item from $fromIndex to $toIndex');
    // },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  late AppFlowyBoardScrollController boardController;

  // AppFlowyGroupData? group1;

  var tempList = [
    // TextItem("Card 1"),
    TextItem("Card 2"),
    RichTextItem(title: "Card 3", subtitle: 'Aug 1, 2020 4:05 PM'),
    // TextItem("Card 4"),
    // TextItem("Card 5"),
    TextItem("Card 6"),
    RichTextItem(title: "Card 7", subtitle: 'Aug 1, 2020 4:05 PM'),
    RichTextItem(title: "Card 8", subtitle: 'Aug 1, 2020 4:05 PM'),
    TextItem("Card 9"),
  ];

  @override
  void initState() {
    // disable group dragging
    // controller.enableGroupDragging(false);
    boardController = AppFlowyBoardScrollController();
    AppFlowyGroupData backlog = AppFlowyGroupData(
      id: "Backlog",
      name: "Backlog",
    );

    AppFlowyGroupData inProgress = AppFlowyGroupData(
      id: "In Progress",
      name: "In Progress",
    );

    AppFlowyGroupData underReview = AppFlowyGroupData(
      id: "Underreview",
      name: "Underreview",
    );
    AppFlowyGroupData done = AppFlowyGroupData(
      id: "Done",
      name: "Done",
    );

    controller.addGroup(backlog);
    controller.addGroup(inProgress);
    controller.addGroup(done);
    controller.addGroup(underReview);
    controller.enableGroupDragging(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: HexColor.fromHex('#F7F8FC'),
      // stretchGroupHeight: false,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Kanban Board")),
      body: AppFlowyBoard(
          controller: controller,
          cardBuilder: (context, group, groupItem) {
            return AppFlowyGroupCard(
              key: ValueKey(groupItem.id),
              child: _buildCard(groupItem),
            );
          },
          boardScrollController: boardController,
          footerBuilder: (context, columnData) {
            return SafeArea(
              bottom: true,
              child: AppFlowyGroupFooter(
                icon: const Icon(Icons.add, size: 20),
                title: const Text('Add New'),
                height: 50,
                margin: config.groupItemPadding,
                onAddButtonClick: () {
                  // setState(() {
                  //   group1!.items.add(TextItem("Hello there"));
                  // });

                  boardController.scrollToBottom(
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
              title: SizedBox(
                width: 60,
                child: TextField(
                  controller: TextEditingController()
                    ..text = columnData.headerData.groupName,
                  onSubmitted: (val) {
                    controller
                        .getGroupController(columnData.headerData.groupId)!
                        .updateGroupName(val);
                  },
                ),
              ),
              addIcon: const Icon(Icons.add, size: 20),
              moreIcon: const Icon(Icons.more_horiz, size: 20),
              height: 50,
              margin: config.groupItemPadding,
            );
          },
          groupConstraints: const BoxConstraints.tightFor(width: 240),
          config: config),
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
                        tempList.add(TextItem(cardTitle));
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

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
