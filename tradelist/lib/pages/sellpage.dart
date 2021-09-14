import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tradelist/model/GetxController.dart';
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
                        return ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                                bool chage =true;

                            if(double.parse(document[sellTotal])>0) chage = true;
                            if(double.parse(document[sellTotal])<0) chage = false;
                            // Timestamp ts = document[buyDatetime];
                            // String dt = timestampToStrDateTime(ts);
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
                                            width: 150,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  ButtonBar(
                                                    children: [
                                                      RaisedButton(
                                                        onPressed: () {
                                                        },
                                                        child:
                                                            const Text('거래내역'),
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
                                              color:  chage? Colors.redAccent: Colors.blue,
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
                          }).toList(),
                        );
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
