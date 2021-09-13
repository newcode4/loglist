class Sales {
  String title;
  String sellPrice;
  String month_total;
  String sellVolume;
  String sellMonth;
  String sellYeal;
  Sales(this.title,this.sellPrice,this.month_total,this.sellVolume,this.sellMonth,this.sellYeal);

  Sales.fromMap(Map<String, dynamic> map)
      :

        // assert(map['title'] != null),
        // assert(map['sellVolume'] != null),

        title = map['title'],
        sellVolume = map['sellVolume'],
        sellMonth = map['sellMonth'],
        sellPrice = map['sellPrice'],
        month_total=map['month_total'];

  @override
  String toString() => "Record<$title:$sellVolume:$month_total:$sellPrice:$sellMonth>";
}