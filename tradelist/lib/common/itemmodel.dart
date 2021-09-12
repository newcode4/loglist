import 'package:meta/meta.dart';

class ItemData {
  final String name; //매수가
  final String total; //합 가격
  final String name2;
  final String total2;

  ItemData(this.name2, this.total2, {this.name, this.total});

  Map<String, dynamic> toMap() {
    return {"name": this.name, "price": this.total};
  }
}
