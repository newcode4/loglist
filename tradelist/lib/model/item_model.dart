import 'package:flutter/cupertino.dart';

class ItemBuyModel {
  String title;
  String buyPrice;
  String buyTotal;
  String buyVolume;
  // String buyDatetime;

  ItemBuyModel({this.title, this.buyPrice, this.buyTotal ,this.buyVolume});


  Map<String, dynamic> toMap() => {
    'title': this.title,
    'buyPrice': this.buyPrice,
    'buyTotal': this.buyTotal,
    'buyVolume': this.buyVolume,

    // 'buyDatetime': this.buyDatetime
  };
}

class ItemSellModel {
  String title;
  String sellPrice;
  String sellTotal;
  String sellVolume;


  // String buyDatetime;

  ItemSellModel({this.title, this.sellPrice, this.sellTotal ,this.sellVolume});


  Map<String, dynamic> toMap() => {
    'title': this.title,
    'sellPrice': this.sellPrice,
    'sellTotal': this.sellTotal,
    'sellVolume': this.sellVolume,


    // 'buyDatetime': this.buyDatetime
  };
}