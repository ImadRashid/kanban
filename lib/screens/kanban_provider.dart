import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';

import '../core/extensions/color.dart';
import '../core/others/base_view_model.dart';

class KanbanBoardProvider extends BaseViewModel {
  final config = AppFlowyBoardConfig(
    groupBackgroundColor: HexColor.fromHex('#F7F8FC'),
    // stretchGroupHeight: false,
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
  }

// list of issues

  List<AppFlowyGroupItem> backlogIssues = [];
  List<AppFlowyGroupItem> inProgress = [];
  List<AppFlowyGroupItem> done = [];
  List<AppFlowyGroupItem> underReview = [];
////
}
