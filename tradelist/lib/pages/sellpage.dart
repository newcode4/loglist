import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:tradelist/model/GetxController.dart';
import 'package:tradelist/model/item_model.dart';
import 'package:tradelist/utilites/toolsUtilities.dart';

SellPageState pageState;

class SellPage extends StatefulWidget {
  @override
  SellPageState createState() {
    pageState = SellPageState();
    return pageState;
  }
}

class SellPageState extends State<SellPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 컬렉션명

  final String sellName = "sell_data";

  // 필드명
  final String title = "title";
  final String sellPrice = "sellPrice";
  final String sellTotal = "sellTotal";
  final String sellVolume = "sellVolume";
  final String sellColor = "sellColor";

  // final String buyDatetime = "buyDatetime";

  final controller = Get.put(BuilderController());

  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection(sellName)
                      // .orderBy(buyDatetime, descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text("Error: ${snapshot.error}");
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text("Loading...");
                      default:
                        return new ListView(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                          bool chage = true;

                          if (double.parse(document[sellTotal]) > 0)
                            chage = true;
                          if (double.parse(document[sellTotal]) < 0)
                            chage = false;
                          // Timestamp ts = document[buyDatetime];
                          // String dt = timestampToStrDateTime(ts);
                          List<ItemSellModel> elements = [
                            ItemSellModel(
                                title: document[title],
                                sellTime: document['sellTime'],
                                sellTotal: document[sellTotal],
                                sellPrice: document[sellPrice],
                                sellVolume: document[sellVolume]),
                          ];

                          print(document['sellTime']);
                          return GroupedListView<ItemSellModel, String>(
                            shrinkWrap: true,
                            elements: elements,
                            // 리스트에 사용할 데이터 리스트
                            groupBy: (element) => element.sellTime.split(' ')[0],
                            // 데이터 리스트 중 그룹을 지정할 항목
                            groupComparator: (value1, value2) => value1.compareTo(value2),
                            //groupBy 항목을 비교할 비교기
                            itemComparator: (item1, item2) => item1.sellTime
                                .split(' ')[1]
                                .compareTo(item2.sellTime.split(' ')[1]),
                            // 그룹안의 데이터 비교기
                            order: GroupedListOrder.DESC,
                            //정렬(오름차순)
                            useStickyGroupSeparators: false,
                            //가장 위에 그룹 이름을 고정시킬 것인지
                            groupSeparatorBuilder: (String value) => Padding(
                              //그룹 타이틀 모양
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            itemBuilder: (c, element) {
                              return Card(
                                  elevation: 4,
                                  margin: EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  color: Colors.white,
                                  child: InkWell(
                                      // Read Document
                                      onTap: () {
                                        showDocument(document.documentID);
                                      },
                                      // Update or Delete Document

                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: ListTile(
                                            trailing: Container(
                                              width: 132,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    ButtonBar(
                                                      children: [
                                                        RaisedButton(
                                                          onPressed: () {},
                                                          child: const Text(
                                                              '거래내역'),
                                                          color: Colors.blue,
                                                        ),
                                                      ],
                                                    ),
                                                    IconButton(
                                                        icon: Icon(Icons.delete,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          deleteDoc(document
                                                              .documentID);
                                                        }),
                                                  ]),
                                            ),
                                            title: Text(
                                              document[title],
                                              style: TextStyle(
                                                color: chage
                                                    ? Colors.redAccent
                                                    : Colors.blue,
                                                fontSize: 16.5,
                                                fontFamily: 'RobotoMono',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            subtitle: Text(
                                              "\n거래차익 : ${f.format(int.parse(document[sellTotal]))}원",
                                              style: TextStyle(
                                                fontSize: 12.5,
                                                fontFamily: 'RobotoMono',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ))));
                            },
                          );
                        }).toList());
                    }
                  }
                  // list_1(snapshot);

                  )),
        ],
      ),

      // Create Document
    );
  }

  /// Firestore CRUD Logic

  trans(String formatname) {
    NumberFormat('###,###,###,###').format(formatname).replaceAll(' ', '');
  }

  // 문서 조회 (Read)
  void showDocument(String documentID) {
    Firestore.instance
        .collection(sellName)
        .document(documentID)
        .get()
        .then((doc) {
      showReadDocSnackBar(doc);
    });
  }

  // 문서 갱신 (Update)
  void updateDoc(String docID, String name, String description) {
    Firestore.instance.collection(sellName).document(docID).updateData({
      title: name,
      sellPrice: docID,
      sellTotal: description,
    });
  }

  // 문서 삭제 (Delete)
  void deleteDoc(String docID) {
    Firestore.instance.collection(sellName).document(docID).delete();
  }

  void showReadDocSnackBar(DocumentSnapshot doc) {
    var scaffoldState = _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: ToolsUtilities.whiteColor,
          duration: Duration(seconds: 5),
          content: Text(
            "${doc[title]}\n\n"
            "거래 로그 적을 예정",
            style: TextStyle(color: Colors.black),
          ),
          // "\n$buyDatetime: ${timestampToStrDateTime(doc[buyDatetime])}"),
          action: SnackBarAction(
            label: "닫기",
            textColor: Colors.blue,
            onPressed: () {},
          ),
        ),
      );
  }
}
