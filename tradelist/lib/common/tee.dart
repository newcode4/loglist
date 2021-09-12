// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class ListDialog extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         var f = NumberFormat('###,###,###,###');
//         return Center(
//             child: Material(
//               type: MaterialType.transparency,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 padding: EdgeInsets.all(15),
//                 height: 300,
//                 width: MediaQuery.of(context).size.width * 0.7,
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: 25,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 25,
//                       ),
//                       Row(children: [
//                         Container(
//                           width: 60,
//                           child: Text("가격 : ",
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold)),
//                         ),
//                         Flexible(
//                           child: Container(
//                             margin: EdgeInsets.only(right: 20),
//                             child: TextFormField(
//                               keyboardType: TextInputType.number,
//                               controller: controller1,
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: "수량을 입력하세요",
//                                   hintStyle: TextStyle(color: Colors.grey[300])),
//                               cursorColor: Colors.blue,
//                               onChanged: (val) => value3 = val as int,
//                               validator: (val) {
//                                 if (val == null || val.isEmpty) {
//                                   return '가격을 입력하세요';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ),
//                       ]),
//                       Row(children: [
//                         Container(
//                           width: 60,
//                           child: Text("수량 : ",
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold)),
//                         ),
//                         Flexible(
//                           child: Container(
//                             margin: EdgeInsets.only(right: 20),
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               controller: controller2,
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: "가격을 입력하세요",
//                                   hintStyle: TextStyle(color: Colors.grey[300])),
//                               cursorColor: Colors.blue,
//                               onChanged: (val) => value4 = val as int,
//                             ),
//                           ),
//                         ),
//                       ]),
//                       ButtonBar(
//                           buttonPadding: EdgeInsets.all(0),
//                           alignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             CupertinoButton(
//                               onPressed: () {
//                                 var value3 = int.parse(controller1.text);
//                                 var value4 = int.parse(controller2.text);
//                                 result = value3 * value4;
//                                 print(result);
//                               },
//                               child: Text('확인'),
//                             ),
//                             CupertinoButton(
//                                 child: Text('저장'),
//                                 onPressed: () {
//                                   final newTodo = TodoModel(desc: title);
//                                   if (newTodo.desc.isNotEmpty) {
//                                     itemBloc.addTodo(newTodo);
//                                     Navigator.pop(context);
//                                   }
//                                   // count.write('t',cnt);
//                                   // title2.write('title${count.read('t')}',title);
//                                   // box2.write('sell2', result);
//                                   // cnt++;
//                                   // print(result);
//                                   // print(title);
//                                 })
//                           ]),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       Row(children: [
//                         Container(
//                           width: 60,
//                           child: Text("합계 : ",
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold)),
//                         ),
//                         Flexible(
//                           child: Container(
//                               margin: EdgeInsets.only(right: 20),
//                               child: Text(
//                                 "${f.format(result)}원",
//                                 style: TextStyle(fontSize: 16),
//                               )),
//                         ),
//                       ]),
//                     ]),
//               ),
//             ));
//       },
//     );
//   }
// }
