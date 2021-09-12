class Sales {
  String title;
  String sellPrice;
  String sellTotal;
  String sellVolume;
  Sales(this.title,this.sellPrice,this.sellTotal,this.sellVolume);

  Sales.fromMap(Map<String, dynamic> map)
      : assert(map['title'] != null),
        assert(map['sellVolume'] != null),
        assert(map['sellTotal'] != null),
        title = map['title'],
        sellVolume = map['sellVolume'],
        sellTotal=map['sellTotal'];

  @override
  String toString() => "Record<$title:$sellVolume:$sellTotal>";
}