import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:tradelist/library/do_progress_bar.dart';
import 'package:tradelist/model/GetxController.dart';
import 'package:tradelist/model/item_model.dart';

import 'Constants.dart';

showDialogFunc(context, title) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: 180,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: ButtonBar(
                      buttonHeight: 40,
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            showDialogFunc2(context, title);
                          },
                          child: Text('매수하기'),
                          color: Colors.blue,
                        ),
                        RaisedButton(
                          onPressed: () {
                            showDialogFunc3(context, title);
                            print('$title 매도하기');
                          },
                          child: Text('매도하기'),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

showDialogFunc2(context, title) {
  TextEditingController price = TextEditingController();
  TextEditingController volume = TextEditingController();

  Future<void> insertData(final product) async {
    Firestore firestore = Firestore.instance;

    firestore
        .collection("buy_data")
        .add(product)
        .then((DocumentReference document) {
      print(document.documentID);
    }).catchError((e) {
      print(e);
    });
  }

  var value3;
  var value4;
  var result = 0;
  var cnt = 0;

  return showDialog(
    context: context,
    builder: (context) {
      var f = NumberFormat('###,###,###,###');
      return Center(
          child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(15),
          height: 300,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(children: [
                  Container(
                    width: 60,
                    child: Text("가격 : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: price,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "가격을 입력하세요",
                            hintStyle: TextStyle(color: Colors.grey[300])),
                        cursorColor: Colors.blue,
                        onChanged: (val) => value3 = val as int,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return '가격을 입력하세요';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ]),
                Row(children: [
                  Container(
                    width: 60,
                    child: Text("수량 : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: volume,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "수량을 입력하세요",
                            hintStyle: TextStyle(color: Colors.grey[300])),
                        cursorColor: Colors.blue,
                        onChanged: (val) => value4 = val as int,
                      ),
                    ),
                  ),
                ]),
                ButtonBar(
                    buttonPadding: EdgeInsets.all(0),
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          var value3 = int.parse(price.text);
                          var value4 = int.parse(volume.text);
                          result = value3 * value4;
                          print(result);
                        },
                        child: Text('확인'),
                      ),
                      CupertinoButton(
                          child: Text('저장'),
                          onPressed: () {
                            final DateTime now = DateTime.now();
                            final String btime =
                                DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
                            final String bname = title.toString();
                            final String bprice = price.text;
                            final String bvolume = volume.text;
                            final String btotal = result.toString();

                            final ItemBuyModel product = ItemBuyModel(
                                title: bname,
                                buyTime: btime,
                                buyPrice: bprice,
                                buyVolume: bvolume,
                                buyTotal: btotal);
                            insertData(product.toMap());
                            Navigator.pop(context);
                          })
                    ]),
                SizedBox(
                  height: 18,
                ),
                Row(children: [
                  Container(
                    width: 60,
                    child: Text("합계 : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                    child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          "${f.format(result)}원",
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                ]),
              ]),
        ),
      ));
    },
  );
}

showDialogFunc3(context, title2) {
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  var result2 = 0;

  return showDialog(
    context: context,
    builder: (context) {
      var f = NumberFormat('###,###,###,###');
      return Center(
          child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(15),
          height: 300,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  title2,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(children: [
                  Container(
                    width: 60,
                    child: Text("가격 : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller3,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "수량을 입력하세요",
                            hintStyle: TextStyle(color: Colors.grey[300])),
                        cursorColor: Colors.blue,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return '가격을 입력하세요';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ]),
                Row(children: [
                  Container(
                    width: 60,
                    child: Text("수량 : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: controller4,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "가격을 입력하세요",
                            hintStyle: TextStyle(color: Colors.grey[300])),
                        cursorColor: Colors.blue,
                      ),
                    ),
                  ),
                ]),
                ButtonBar(
                    buttonPadding: EdgeInsets.all(0),
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          var value1 = int.parse(controller3.text);
                          var value2 = int.parse(controller4.text);
                          result2 = value1 * value2;
                        },
                        child: Text('확인'),
                      ),
                      CupertinoButton(
                          child: Text('저장'),
                          onPressed: () {
                            title.write('title', title2);
                            box.write('sell', result2);
                            print(result2);
                            print(title2);
                          })
                    ]),
                SizedBox(
                  height: 18,
                ),
                Row(children: [
                  Container(
                    width: 60,
                    child: Text("합계 : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                    child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          "${f.format(result2)}원",
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                ]),
              ]),
        ),
      ));
    },
  );
}

LogDiaLog(context, String title, String Volume, int datatotal) {
  TextEditingController price = TextEditingController();
  TextEditingController su = TextEditingController();
  final controller = Get.put(BuilderController());
  controller.resultdata(double.parse(Volume), 0);

  Firestore firestore = Firestore.instance;

  Future<void> insertData(final product) async {
    firestore
        .collection("sell_data")
        .add(product)
        .then((DocumentReference document) {
      print(document.documentID);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> updateData(final result) async {
    firestore
        .collection("month_result")
        .document('00${DateTime.now().subtract(Duration(days: 7)).month}')
        .updateData(result)
        .then((value) => print('updated'));
  }

  var value3;
  var value4;
  var result = 0;
  var cnt = 0;

  return showDialog(
    context: context,
    builder: (context) {
      var f = NumberFormat('###,###,###,###');
      return Center(
          child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.68,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(children: [
                  Container(
                    width: 60,
                    child: Text("가격 : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: price,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "가격을 입력하세요",
                            hintStyle: TextStyle(color: Colors.grey[300])),
                        cursorColor: Colors.blue,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return controller.resultdata(
                                double.parse(Volume), 0);
                          }
                          return controller.resultdata(
                              double.parse(Volume), int.parse(price.text));
                        },
                      ),
                    ),
                  ),
                ]),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("수량 :  $Volume개 보유 중입니다.",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                    child: GetBuilder<BuilderController>(
                        init: BuilderController(),
                        builder: (_) {
                          return GestureDetector(
                            child: DoProgressBar(
                              title: " ",
                              width: 150,
                              percentage: _.count,
                              firstlimit: _.count * 0.3,
                              secondlimit: _.count * 0.7,
                            ),
                          );
                        })),
                SizedBox(
                  height: 14,
                ),
                Container(
                  child: GetBuilder<BuilderController>(
                      init: BuilderController(),
                      builder: (_) {
                        return Text("합계 : ${f.format(_.total)}원",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold));
                      }),
                ),
                SizedBox(
                  height: 14,
                ),
                ButtonBar(
                    buttonPadding: EdgeInsets.only(bottom: 2, top: 4),
                    alignment: MainAxisAlignment.center,
                    buttonHeight: 30,
                    buttonMinWidth: 30,
                    children: [
                      RaisedButton(
                          child: Text("-10"),
                          onPressed: () {
                            controller.decrease2();
                            controller.resultdata(
                                controller.count, int.parse(price.text));
                          }),
                      RaisedButton(
                          child: Text("-1"),
                          onPressed: () {
                            controller.decrease();
                            controller.resultdata(
                                controller.count, int.parse(price.text));
                          }),
                      RaisedButton(
                          child: Text("+1"),
                          onPressed: () {
                            controller.decrease();
                            controller.resultdata(
                                controller.count, int.parse(price.text));
                          }),
                      RaisedButton(
                          child: Text("+10"),
                          onPressed: () {
                            controller.increment2();
                            controller.resultdata(
                                controller.count, int.parse(price.text));
                          }),
                    ]),
                ButtonBar(
                    buttonPadding: EdgeInsets.only(bottom: 0, top: 0),
                    buttonMinWidth: 50,
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                          child: Text("10%"),
                          onPressed: () {
                            controller.ten();
                            controller.resultdata(
                                controller.count, int.parse(price.text));
                          }),
                      RaisedButton(
                          child: Text("50%"),
                          onPressed: () {
                            controller.fifty();
                            controller.resultdata(
                                controller.count, int.parse(price.text));
                          }),
                      RaisedButton(
                          child: Text("100%"),
                          onPressed: () {
                            controller.one_hundred();
                            controller.resultdata(
                                controller.count, int.parse(price.text));
                          }),
                    ]),
                SizedBox(
                  height: 14,
                ),
                ButtonBar(
                    buttonPadding: EdgeInsets.all(0),
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          // var value3 = int.parse(price.text);
                          // var value4 = int.parse(Volume);
                          // result = value3 * value4;
                          Navigator.pop(context);
                        },
                        child: Text('취소'),
                      ),
                      CupertinoButton(
                          child: Text('매도'),
                          onPressed: () {
                            double data = controller.total - datatotal;

                            final DateTime now = DateTime.now();
                            final String btime =
                                DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
                            final String bname = title.toString();
                            final String bprice = price.text;
                            final String bvolume = Volume.toString();
                            final String btotal = data.toStringAsFixed(0);
                            bool bcolor = false;

                            if (data >= 0) bcolor = true;

                            final ItemSellModel product = ItemSellModel(
                              title: bname,
                              sellTime: btime,
                              sellPrice: bprice,
                              sellVolume: bvolume,
                              sellTotal: btotal,
                            );
                            insertData(product.toMap());
                            String vtotal = box.read(
                                'result2${DateTime.now().subtract(Duration(days: 7)).month}');
                            String stotal =
                                (int.parse(vtotal) + int.parse(btotal))
                                    .toString();
                            updateData({'month_total': stotal});

                            // if(int.parse(btotal)<0) color.write('resultcolor', Colors.blue);

                            Navigator.pop(context);
                          })
                    ]),
              ]),
        ),
      ));
    },
  );
}

FinishDiaLog(context, String title, String docID) {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 컬렉션명

  final String sellName = "sell_data";

  // 필드명
  final String title2 = "title";
  final String sellPrice = "sellPrice";
  final String sellTotal = "sellTotal";
  final String sellVolume = "sellVolume";
  final String sellColor = "sellColor";

  // final String buyDatetime = "buyDatetime";

  final controller = Get.put(BuilderController());

  var f = NumberFormat('###,###,###,###');

  return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
          ),

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
                          .where('title', isEqualTo: title)
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
                                    title: document[title2],
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
                                groupBy: (element) =>
                                    element.sellTime.split(' ')[0],
                                // 데이터 리스트 중 그룹을 지정할 항목
                                groupComparator: (value1, value2) =>
                                    value2.compareTo(value1),
                                //groupBy 항목을 비교할 비교기
                                itemComparator: (item1, item2) => item1.sellTime
                                    .split(' ')[0]
                                    .compareTo(item2.sellTime.split(' ')[0]),
                                // 그룹안의 데이터 비교기
                                order: GroupedListOrder.DESC,
                                //정렬(오름차순)
                                useStickyGroupSeparators: false,
                                //가장 위에 그룹 이름을 고정시킬 것인지
                                groupSeparatorBuilder: (String value) =>
                                    Padding(
                                  //그룹 타이틀 모양
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                itemBuilder: (c, element) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Card(
                                        elevation: 4,
                                        margin: EdgeInsets.all(8),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        color: Colors.white,
                                        child: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: ListTile(
                                              title: Text(
                                                document[title2],
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
                                                "${document['sellTime'].split(' ')[1]}"
                                                "\n거래차익 : ${f.format(int.parse(document[sellTotal]))}원",
                                                style: TextStyle(
                                                  fontSize: 12.5,
                                                  fontFamily: 'RobotoMono',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ))),
                                  );
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
      });
}

DepositDialog(context, int total) {
  TextEditingController price = TextEditingController();

  Firestore firestore = Firestore.instance;

  Future<void> updateData(final result) async {
    firestore
        .collection("user_money_log")
        .document('money')
        .updateData(result)
        .then((value) => print('updated'));
  }

  return showDialog(
    context: context,
    builder: (context) {
      var f = NumberFormat('###,###,###,###');
      return Center(
          child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.33,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  '입금하기',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(children: [
                  Container(
                    width: 60,
                    child: Text("가격 : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: price,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "가격을 입력하세요",
                            hintStyle: TextStyle(color: Colors.grey[300])),
                        cursorColor: Colors.blue,
                      ),
                    ),
                  ),
                ]),

                SizedBox(
                  height: 14,
                ),
                ButtonBar(
                    buttonPadding: EdgeInsets.all(0),
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('취소'),
                      ),
                      CupertinoButton(
                          child: Text('확인'),
                          onPressed: () {
                            int money = int.parse(price.text);
                            print(total);
                            print(money);
                            updateData({'money': total});
                            box.write('money',money);
                            Get.find<CalculationController>().deposit(total, money);

                            // if(int.parse(btotal)<0) color.write('resultcolor', Colors.blue);

                            Navigator.pop(context);
                          })
                    ]),
              ]),
        ),
      ));
    },
  );
}
