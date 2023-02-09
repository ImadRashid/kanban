import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import '../../../core/others/base_view_model.dart';

class KanbanBoardProvider extends BaseViewModel {
  String? newIssueTitle;
  String? newIssueDescription;
  String? newIssueDropDownValue;

  final config = AppFlowyBoardConfig(
    groupBackgroundColor: Colors.grey.shade200,
    groupPadding: const EdgeInsets.only(
      left: 20,
    ),
  );
  KanbanBoardProvider() {
    init();
  }
  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  late AppFlowyBoardScrollController boardController;

  init() {
    boardController = AppFlowyBoardScrollController();
    AppFlowyGroupData backlog = AppFlowyGroupData(
      id: "Backlog",
      name: "Backlog",
      items: backlogIssues,
    );

    AppFlowyGroupData inProgress = AppFlowyGroupData(
      id: "In Progress",
      name: "In Progress",
      items: inProgressIssues,
    );

    AppFlowyGroupData underReview = AppFlowyGroupData(
      id: "Underreview",
      name: "Underreview",
      items: underReviewIssues,
    );
    AppFlowyGroupData done = AppFlowyGroupData(
      id: "Done",
      name: "Done",
      items: doneIssues,
    );

    controller.addGroup(backlog);
    controller.addGroup(inProgress);
    controller.addGroup(done);
    controller.addGroup(underReview);
    controller.enableGroupDragging(false);
  }

// list of issues

  List<BoardItemModel> backlogIssues = [];
  List<BoardItemModel> inProgressIssues = [];
  List<BoardItemModel> doneIssues = [];
  List<BoardItemModel> underReviewIssues = [];
////

  addNewCard() {}
  addIssue({required BoardItemModel issue, required String groupId}) {
    if (groupId == "Backlog") {
      backlogIssues.add(issue);
    } else if (groupId == "In Progress") {
      inProgressIssues.add(issue);
    } else if (groupId == "Underreview") {
      underReviewIssues.add(issue);
    } else if (groupId == "Done") {
      doneIssues.add(issue);
    } else {}
    notifyListeners();
  }
}

class BoardItemModel extends AppFlowyGroupItem {
  final String title;
  final String description;
  final String startTime;

  BoardItemModel({
    required this.title,
    required this.description,
    required this.startTime,
  });

  @override
  String get id => title;
}
