import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karbanboard/core/enums/view_state.dart';
import 'package:karbanboard/core/services/board_services.dart';
import '../../../core/model/ticketModel.dart';
import '../../../core/others/base_view_model.dart';
import '../../../locator.dart';
import '../../others/snackbars.dart';
import 'detailScreen.dart';

class KanbanBoardProvider extends BaseViewModel {
  String? newIssueTitle;
  String? newIssueDescription;
  String? newIssueDropDownValue;

  BoardServices _boardService = locator<BoardServices>();
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
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  late AppFlowyBoardScrollController boardController;

  init() {
    initializeBoardSettings();
    fetchAllIssues();
  }

  ///
  /// list of issues
  ///

  List<AppFlowyGroupItem> backlogIssues = [];
  List<AppFlowyGroupItem> inProgressIssues = [];
  List<AppFlowyGroupItem> doneIssues = [];
  List<AppFlowyGroupItem> underReviewIssues = [];

  ///
  /// Selected an Issue Function
  ///
  AppFlowyGroupItem? selectedIssue;
  selectIssue(groupItem, context) async {
    print("Item = ${groupItem.status.toLowerCase()}");
    String groupName = groupItem.status.toLowerCase();
    selectedIssue = groupItem;
    // await Get.to(DetailScreen());
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen()),
    );
    selectedIssue = null;
  }

////

  addIssue({required TicketModel ticket}) async {
    try {
      // setState(ViewState.busy);
      print(ticket.status);
      await _boardService.addNewTicket(ticket);
      if (ticket.status == "Backlog") {
        backlogIssues.add(ticket);
      } else if (ticket.status == "In Progress") {
        inProgressIssues.add(ticket);
      } else if (ticket.status == "Underreview") {
        underReviewIssues.add(ticket);
      } else if (ticket.status == "Done") {
        doneIssues.add(ticket);
      } else {}
    } catch (e) {
      print(e);
      showCustomSnackBar(
        "Error",
        "$e",
      );
    }
    setState(ViewState.idle);
    notifyListeners();
  }

  fetchAllIssues() async {
    try {
      final data = await _boardService.fetchAllTickets();
      print(data.docs.first.data());
      //parse data
      for (int i = 0; i < data.docs.length; i++) {
        if (data.docs[i]['status'] == "Backlog") {
          backlogIssues.add(
            TicketModel.fromJson(data.docs[i].data()),
          );
        } else if (data.docs[i]['status'] == "In Progress") {
          inProgressIssues.add(
            TicketModel.fromJson(data.docs[i].data()),
          );
        } else if (data.docs[i]['status'] == "Done") {
          doneIssues.add(
            TicketModel.fromJson(data.docs[i].data()),
          );
        } else if (data.docs[i]['status'] == "Underreview") {
          underReviewIssues.add(
            TicketModel.fromJson(data.docs[i].data()),
          );
        } else {}
      }
      notifyListeners();
    } catch (e) {}
  }

  ///
  /// This is the board initialization Code
  ///
  initializeBoardSettings() {
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

  resetProvider() {
    backlogIssues = [];
    inProgressIssues = [];
    doneIssues = [];
    underReviewIssues = [];
    newIssueTitle = null;
    newIssueDescription = null;
    newIssueDropDownValue = null;
  }
}
