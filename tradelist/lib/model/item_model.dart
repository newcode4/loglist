import 'package:flutter/cupertino.dart';

class ItemBuyModel {
  String title;
  String buyPrice;
  String buyTotal;
  String buyTime;
  String buyVolume;
  // String buyDatetime;

  ItemBuyModel({this.title, this.buyPrice, this.buyTotal ,this.buyVolume,this.buyTime});


  Map<String, dynamic> toMap() => {
    'title': this.title,
    'buyPrice': this.buyPrice,
    'buyTotal': this.buyTotal,
    'buyVolume': this.buyVolume,
    'butTime': this.buyTime

    // 'buyDatetime': this.buyDatetime
  };
}

class ItemSellModel {
  String title;
  String sellTime;
  String sellPrice;
  String sellTotal;
  String sellVolume;


  // String buyDatetime;

  ItemSellModel({this.title, this.sellPrice, this.sellTotal ,this.sellVolume,this.sellTime});


  Map<String, dynamic> toMap() => {
    'title': this.title,
    'sellPrice': this.sellPrice,
    'sellTotal': this.sellTotal,
    'sellVolume': this.sellVolume,
    'sellTime': this.sellTime


    // 'buyDatetime': this.buyDatetime
  };
}

class Sales {
  String title;
  String sellPrice;
  String month_total;
  String sellVolume;
  String month;
  String sellMonth;
  String sellYeal;
  Sales(this.title,this.sellPrice,this.month_total,this.sellVolume,this.sellMonth,this.month);

  Sales.fromMap(Map<String, dynamic> map)
      :

  // assert(map['title'] != null),
  // assert(map['sellVolume'] != null),

        title = map['title'],
        sellVolume = map['sellVolume'],
        sellMonth = map['sellMonth'],
        sellPrice = map['sellPrice'],
        month = map['month'],
        month_total=map['month_total'];


  @override
  String toString() => "Record<$title:$sellVolume:$month_total:$sellPrice:$sellMonth:$month>";
}

class User {

  String money;

  User(this.money);

  User.fromMap(Map<String, dynamic> map)
      :

  // assert(map['title'] != null),
  // assert(map['sellVolume'] != null),

        money = map['money'];

  @override
  String toString() => "Record<$money>";
}