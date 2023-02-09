import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbanboard/core/services/auth_services.dart';
import '../../locator.dart';
import '../model/ticketModel.dart';

class BoardServices {
  final _ref = FirebaseFirestore.instance;
  final _authService = locator<AuthService>();
  //add new issue
  Future addNewTicket(TicketModel ticket) async {
    try {
      _ref
          .collection("tickets")
          .doc(_authService.appUser.userId)
          .collection("tickets")
          .add(ticket.toJson());
    } catch (e) {
      throw "Error";
    }
  }

// fetch all issues
  Future fetchAllTickets() async {
    try {
      final result = await _ref
          .collection("tickets")
          .doc(_authService.appUser.userId)
          .collection("tickets")
          .get();

      return result;
    } catch (e) {
      throw "Error $e";
    }
  }
}
