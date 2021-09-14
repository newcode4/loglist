import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tradelist/library/do_progress_bar.dart';
import 'package:tradelist/model/GetxController.dart';
import 'package:tradelist/model/item_model.dart';
import 'package:tradelist/pages/sales.dart';

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
                            final Timestamp time = Timestamp.now();
                            final String btime = time.toString();
                            final String bname = title.toString();
                            final String bprice = price.text;
                            final String bvolume = volume.text;
                            final String btotal = result.toString();

                            final ItemBuyModel product = ItemBuyModel(
                                title: bname,
                                // buyDatetime: btime,
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
        .collection("month_result").document('${DateTime.now().subtract(Duration(days:7)).month}')
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

                            final Timestamp time = Timestamp.now();
                            final String btime = time.toString();
                            final String bname = title.toString();
                            final String bprice = price.text;
                            final String bvolume = Volume.toString();
                            final String btotal = data.toStringAsFixed(0);
                            bool bcolor = false;

                            if (data >= 0) bcolor = true;

                            final ItemSellModel product = ItemSellModel(
                              title: bname,
                              // buyDatetime: btime,
                              sellPrice: bprice,
                              sellVolume: bvolume,
                              sellTotal: btotal,
                            );
                            insertData(product.toMap());
                            String vtotal = box.read('result${DateTime.now().subtract(Duration(days:7)).month}');
                            String stotal = (int.parse(vtotal)+int.parse(btotal)).toString();
                            updateData({'month_total' : stotal});


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


