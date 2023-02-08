// import 'dart:ffi';

// import 'package:boardview/board_item.dart';
// import 'package:boardview/board_list.dart';
// import 'package:flutter/material.dart';

// import 'package:karbanboard/screen/homescreen_provider.dart';
// import 'package:provider/provider.dart';
// import 'homescreen_provider.dart';

// import 'dart:collection';
// import 'package:flutter/material.dart';

// import 'package:boardview/boardview_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:boardview/boardview.dart';

// class BoardItemObject {
//   String? title;

//   BoardItemObject({this.title}) {
//     if (this.title == null) {
//       this.title = "";
//     }
//   }
// }

// class BoardListObject {
//   String? title;
//   List<BoardItemObject>? items;

//   BoardListObject({this.title, this.items}) {
//     if (this.title == null) {
//       this.title = "";
//     }
//     if (this.items == null) {
//       this.items = [];
//     }
//   }
// }

// class BoardViewExample extends StatelessWidget {
//   final _listData = [
//     BoardListObject(title: "List title 1", items: [
//       BoardItemObject(title: 'Hello there'),
//     ]),
//     BoardListObject(title: "List title 2"),
//     BoardListObject(title: "List title 3")
//   ];

//   //Can be used to animate to different sections of the BoardView
//   BoardViewController boardViewController = new BoardViewController();

//   @override
//   Widget build(BuildContext context) {
//     List<BoardList> _lists = [];
//     for (int i = 0; i < _listData.length; i++) {
//       _lists.add(_createBoardList(_listData[i]) as BoardList);
//     }
//     return Scaffold(
//       body: BoardView(
//         lists: _lists,
//         boardViewController: boardViewController,
//       ),
//     );
//   }

//   Widget buildBoardItem(BoardItemObject itemObject) {
//     return BoardItem(
//         onStartDragItem:
//             (int? listIndex, int? itemIndex, BoardItemState? state) {},
//         onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
//             int? oldItemIndex, BoardItemState? state) {
//           //Used to update our local item data
//           var item = _listData[oldListIndex!].items![oldItemIndex!];
//           _listData[oldListIndex].items!.removeAt(oldItemIndex!);
//           _listData[listIndex!].items!.insert(itemIndex!, item);
//         },
//         onTapItem:
//             (int? listIndex, int? itemIndex, BoardItemState? state) async {},
//         item: Card(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(itemObject.title!),
//           ),
//         ));
//   }

//   Widget _createBoardList(BoardListObject list) {
//     List<BoardItem> items = [];
//     for (int i = 0; i < list.items!.length; i++) {
//       items.insert(i, buildBoardItem(list.items![i]) as BoardItem);
//     }

//     return BoardList(
//       onStartDragList: (int? listIndex) {},
//       onTapList: (int? listIndex) async {},
//       onDropList: (int? listIndex, int? oldListIndex) {
//         //Update our local list data
//         var list = _listData[oldListIndex!];
//         _listData.removeAt(oldListIndex!);
//         _listData.insert(listIndex!, list);
//       },
//       headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
//       backgroundColor: Color.fromARGB(255, 235, 236, 240),
//       header: [
//         Expanded(
//             child: Padding(
//                 padding: EdgeInsets.all(5),
//                 child: Text(
//                   list.title!,
//                   style: TextStyle(fontSize: 20),
//                 ))),
//       ],
//       items: items,
//     );
//   }
// }

// class Item {
//   final id;
//   late final listId;
//   final title;

//   Item({this.id, this.listId, this.title});
// }

// class Kanban extends StatefulWidget {
//   final double tileHeight = 100;
//   final double headerHeight = 80;
//   final double tileWidth = 300;

//   @override
//   _KanbanState createState() => _KanbanState();
// }

// class _KanbanState extends State<Kanban> {
//   LinkedHashMap<String, List<Item>>? board;

//   @override
//   void initState() {
//     board = LinkedHashMap();
//     board!.addAll({
//       "1": [
//         Item(id: "1", listId: "1", title: "Pera"),
//         Item(id: "2", listId: "1", title: "Papa"),
//       ],
//       "2": [
//         Item(id: "3", listId: "2", title: "Auto"),
//         Item(id: "4", listId: "2", title: "Bicicleta"),
//         Item(id: "5", listId: "2", title: "Bla bla"),
//       ],
//       "3": [
//         Item(id: "6", listId: "3", title: "Chile"),
//         Item(id: "7", listId: "3", title: "Madagascar"),
//         Item(id: "8", listId: "3", title: "Japón"),
//       ]
//     });

//     super.initState();
//   }

//   buildItemDragTarget(listId, targetPosition, double height) {
//     return DragTarget<Item>(
//       // Will accept others, but not himself
//       onWillAccept: (data) {
//         return board![data!.listId]!.isEmpty ||
//             data.id != board![listId]![targetPosition].id;
//       },

//       // (Item data) {
//       //   return board[listId].isEmpty ||
//       //       data.id != board[listId][targetPosition].id;
//       // },
//       // Moves the card into the position

//       onAccept: (Item? data) {
//         return setState(() {
//           board![data!.listId]!.remove(data);
//           data!.listId = listId!;
//           if (board![listId]!.length > targetPosition) {
//             board![listId]!.insert(targetPosition + 1, data);
//           } else {
//             board![listId]!.add(data);
//           }
//         });
//       },

//       // onAccept: (Item? data) {
//       //   setState(() {
//       //     board![data.listId]!.remove(data);
//       //     data!.listId! = listId;
//       //     if (board![listId]!.length > targetPosition) {
//       //       board![listId]!.insert(targetPosition + 1, data);
//       //     } else {
//       //       board![listId]!.add(data);
//       //     }
//       //   });
//       // },
//       builder: (context, data, List<dynamic> rejectedData) {
//         if (data.isEmpty) {
//           // The area that accepts the draggable
//           return Container(
//             height: height,
//           );
//         } else {
//           return Column(
//             // What's shown when hovering on it
//             children: [
//               Container(
//                 height: height,
//               ),
//               ...data.map((Item? item) {
//                 return Opacity(
//                   opacity: 0.5,
//                   child: ItemWidget(item: item),
//                 );
//               }).toList()
//             ],
//           );
//         }
//       },
//     );
//   }

//   buildHeader(String listId) {
//     Widget header = Container(
//       height: widget.headerHeight,
//       child: HeaderWidget(title: listId),
//     );

//     return Stack(
//       // The header
//       children: [
//         Draggable<String>(
//           data: listId,
//           child: header, // A header waiting to be dragged
//           childWhenDragging: Opacity(
//             // The header that's left behind
//             opacity: 0.2,
//             child: header,
//           ),
//           feedback: FloatingWidget(
//             child: Container(
//               // A header floating around
//               width: widget.tileWidth,
//               child: header,
//             ),
//           ),
//         ),
//         buildItemDragTarget(listId, 0, widget.headerHeight),
//         DragTarget<String>(
//           // Will accept others, but not himself
//           onWillAccept: (final incomingListId) {
//             return listId != incomingListId;
//           },
//           // Moves the card into the position
//           onAccept: (String incomingListId) {
//             setState(
//               () {
//                 LinkedHashMap<String, List<Item>> reorderedBoard =
//                     LinkedHashMap();
//                 for (String key in board!.keys) {
//                   if (key == incomingListId) {
//                     reorderedBoard[listId] = board![listId]!;
//                   } else if (key == listId) {
//                     reorderedBoard[incomingListId] = board![incomingListId]!;
//                   } else {
//                     reorderedBoard[key] = board![key]!;
//                   }
//                 }
//                 board = reorderedBoard;
//               },
//             );
//           },

//           builder: (context, data, List<dynamic> rejectedData) {
//             if (data.isEmpty) {
//               // The area that accepts the draggable
//               return Container(
//                 height: widget.headerHeight,
//                 width: widget.tileWidth,
//               );
//             } else {
//               return Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 3,
//                     color: Colors.blueAccent,
//                   ),
//                 ),
//                 height: widget.headerHeight,
//                 width: widget.tileWidth,
//               );
//             }
//           },
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     buildKanbanList(String listId, List<Item> items) {
//       return SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             buildHeader(listId),
//             ListView.builder(
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               itemCount: items.length,
//               itemBuilder: (BuildContext context, int index) {
//                 // A stack that provides:
//                 // * A draggable object
//                 // * An area for incoming draggables
//                 return Stack(
//                   children: [
//                     Draggable<Item>(
//                       data: items[index],
//                       child: ItemWidget(
//                         item: items[index],
//                       ), // A card waiting to be dragged
//                       childWhenDragging: Opacity(
//                         // The card that's left behind
//                         opacity: 0.2,
//                         child: ItemWidget(item: items[index]),
//                       ),
//                       feedback: Container(
//                         // A card floating around
//                         height: widget.tileHeight,
//                         width: widget.tileWidth,
//                         child: FloatingWidget(
//                             child: ItemWidget(
//                           item: items[index],
//                         )),
//                       ),
//                     ),
//                     buildItemDragTarget(listId, index, widget.tileHeight),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
//       appBar: AppBar(title: Text("Kanban test")),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: board!.keys.map((String key) {
//               return Container(
//                 width: widget.tileWidth,
//                 child: buildKanbanList(key, board![key]!),
//               );
//             }).toList()),
//       ),
//     );
//   }
// }

// // The list header (static)
// class HeaderWidget extends StatelessWidget {
//   final title;

//   const HeaderWidget({this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.teal,
//       child: ListTile(
//         dense: true,
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 20.0,
//           vertical: 10.0,
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         trailing: Icon(
//           Icons.sort,
//           color: Colors.white,
//           size: 30.0,
//         ),
//         onTap: () {},
//       ),
//     );
//   }
// }

// // The card (static)
// class ItemWidget extends StatelessWidget {
//   final Item? item;

//   const ItemWidget({this.item});
//   ListTile makeListTile(Item item) => ListTile(
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 20.0,
//           vertical: 10.0,
//         ),
//         title: Text(
//           item.title,
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         subtitle: Text("listId: ${item.listId}"),
//         trailing: Icon(
//           Icons.sort,
//           color: Colors.white,
//           size: 30.0,
//         ),
//         onTap: () {},
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8.0,
//       margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color.fromRGBO(64, 75, 96, .9),
//         ),
//         child: makeListTile(item!),
//       ),
//     );
//   }
// }

// class FloatingWidget extends StatelessWidget {
//   final Widget? child;

//   const FloatingWidget({this.child});

//   @override
//   Widget build(BuildContext context) {
//     return child!;
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => HomeScreenProvider(),
//       child: Consumer<HomeScreenProvider>(builder: (contex, model, child) {
//         return Text("dd");

//         // Scaffold(
//         //   appBar: AppBar(
//         //     title: Text("Home"),
//         //   ),
//         //   bottomNavigationBar: Row(children: [
//         //     TextButton(onPressed: () {}, child: Text("add card to Column1"))
//         //   ]),
//         //   body: Column(
//         //     children: [
//         //       Row(
//         //         crossAxisAlignment: CrossAxisAlignment.start,
//         //         mainAxisAlignment: MainAxisAlignment.start,
//         //         children: [
//         //           Container(
//         //             width: MediaQuery.of(context).size.width / 3,
//         //             child: Column(
//         //               children: [
//         //                 Text("Title 1"),
//         //                 model.firstColumCardsLength == 0
//         //                     ? Text("No cards")
//         //                     : ListView.builder(
//         //                         itemCount: model.firstColumCardsLength,
//         //                         shrinkWrap: true,
//         //                         itemBuilder: (context, index) {
//         //                           return Container(
//         //                             width:
//         //                                 MediaQuery.of(context).size.width / 3,
//         //                             margin: EdgeInsets.only(top: 15),
//         //                             child: Column(
//         //                               children: [
//         //                                 Container(
//         //                                   color: Colors.yellow,
//         //                                   child: Text(
//         //                                       "Card so the first and the fo"),
//         //                                 )
//         //                               ],
//         //                             ),
//         //                           );
//         //                         })
//         //               ],
//         //             ),
//         //           ),

//         //           /// ===================================================================
//         //           ///        Second colum
//         //           ///
//         //           ///
//         //           Container(
//         //             width: MediaQuery.of(context).size.width / 3,
//         //             child: Column(
//         //               children: [
//         //                 Text("Title 2"),
//         //                 model.secondColumCardsLength == 0
//         //                     ? Text("No cards")
//         //                     : ListView.builder(
//         //                         itemCount: model.secondColumCardsLength,
//         //                         shrinkWrap: true,
//         //                         itemBuilder: (context, index) {
//         //                           return Container(
//         //                             margin: EdgeInsets.only(top: 15),
//         //                             child: Column(
//         //                               children: [
//         //                                 Container(
//         //                                   width: MediaQuery.of(context)
//         //                                           .size
//         //                                           .width /
//         //                                       3,
//         //                                   color: Colors.yellow,
//         //                                   child: Text("Card"),
//         //                                 )
//         //                               ],
//         //                             ),
//         //                           );
//         //                         })
//         //               ],
//         //             ),
//         //           ),
//         //           Container(
//         //             width: MediaQuery.of(context).size.width / 3,
//         //             child: Column(
//         //               children: [
//         //                 Text("Title 3"),
//         //                 model.thirdColumnCardsLength == 0
//         //                     ? Text("No cards")
//         //                     : ListView.builder(
//         //                         itemCount: model.thirdColumnCardsLength,
//         //                         shrinkWrap: true,
//         //                         itemBuilder: (context, index) {
//         //                           return Column(
//         //                             children: [
//         //                               Container(
//         //                                 color: Colors.yellow,
//         //                                 child: Text("Card"),
//         //                               )
//         //                             ],
//         //                           );
//         //                         })
//         //               ],
//         //             ),
//         //           ),
//         //         ],
//         //       ),
//         //     ],
//         //   ),
//         // );
//       }),
//     );
//   }
// }
