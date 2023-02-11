import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karbanboard/ui/screens/board/kanban_provider.dart';
import 'package:karbanboard/ui/screens/profile/profileScreen.dart';
import 'package:provider/provider.dart';
import '../../../core/model/ticketModel.dart';
import '../../custom_widgets/board_footer.dart';
import '../../custom_widgets/custom_textfield.dart';

class KanbanBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KanbanBoardProvider(),
      child: Consumer<KanbanBoardProvider>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Kanban Board"),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(
                      ProfileScreen(),
                    );
                  },
                  icon: const Icon(
                    Icons.person_2,
                  ),
                ),
              ],
            ),
            body: AppFlowyBoard(
              controller: model.controller,
              boardScrollController: model.boardController,
              // scrollController: ,
              cardBuilder: (context, group, groupItem) {
                return AppFlowyGroupCard(
                  key: ValueKey(groupItem.id),
                  // child: _buildCard(groupItem),
                  child: TicketCard(
                    item: groupItem,
                    onTap: () {
                      // model.selectIssue(groupItem, context);
                    },
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
              footerBuilder: (context, columnData) {
                return SafeArea(
                  bottom: true,
                  child: BoardFooter(
                    icon: const Icon(Icons.add, size: 20),
                    title: const Text('Add New'),
                    height: 50,
                    margin: model.config.groupItemPadding,
                    onAddButtonClick: () async {
                      model.boardController.scrollToBottom(
                        columnData.id,
                      );

                      model.newIssueDropDownValue =
                          columnData.headerData.groupId;

                      // customDailgue(columnTitle: columnData.id);
                      await Get.bottomSheet(
                        StatefulBuilder(builder: (context, setState) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            // height: 300,
                            child: Column(
                              children: [
                                DropdownButton(
                                  value: model.newIssueDropDownValue,
                                  items: [
                                    "Backlog",
                                    "In Progress",
                                    "Underreview",
                                    "Done"
                                  ].map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  onChanged: (v) {
                                    model.newIssueDropDownValue = v;
                                    model.notifyListeners();
                                    print(v);
                                    print(model.newIssueDropDownValue);
                                    setState(() {});
                                  },
                                ),
                                CustomTextField(
                                  hintText: "title",
                                  onChanged: (newValue) {
                                    model.newIssueTitle = newValue;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  hintText: "Description",
                                  maxLines: 3,
                                  onChanged: (newValue) {
                                    model.newIssueDescription = newValue;
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    print(
                                      model.newIssueDropDownValue!,
                                    );
                                    model.addIssue(
                                      ticket: TicketModel(
                                        title: model.newIssueTitle!,
                                        description: model.newIssueDescription!,
                                        createdAt: DateTime.now().toString(),
                                        status: model.newIssueDropDownValue!,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                    ),
                                    child: const Text("Save"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      );

                      model.newIssueDropDownValue = null;
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
              groupConstraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 80,
              ),
              config: model.config,
            ),
          );
        },
      ),
    );
  }
}

// // customDailgue({final columnTitle}) {
// Widget _buildCard(AppFlowyGroupItem item) {
//   if (item is TicketModel) {
//     return TicketCard(item: item);
//   }
//   throw UnimplementedError();
// }

class TicketCard extends StatelessWidget {
  final item;
  final void Function()? onTap;
  TicketCard({
    required this.item,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              Text(
                item.description,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
