import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LogPage extends StatelessWidget {
  LogPage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  Widget build(BuildContext context) {



//To retrieve the string


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '매매일지',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(
                child: Text('진행종목', style: TextStyle(color: Colors.black)),
              ),
              Tab(
                child: Text('완료종목', style: TextStyle(color: Colors.black)),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _getHomePageWidget(),
            _getHomePageWidget2(),
          ],
        ),
      ),
    );
  }

  Widget _getHomePageWidget() {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("buy_data").snapshots(),

        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> queryShapshot) {
          if (queryShapshot.hasError) return Text("Error");

          if (queryShapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              child: CircularProgressIndicator(),
              height:200,
              width:200,
            );
          } else {
            final list = queryShapshot.data.documents;


            return ListView.builder(itemBuilder: (context, index) {
              return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  color: Colors.white,
                  child: InkWell(

                    child: ListTile(
                        trailing: Container(
                          width: 150,
                          child: Row(children: [
                            ButtonBar(
                              children: [
                                RaisedButton(
                                  onPressed: () {},
                                  child: const Text('매도하기'),
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {}),
                          ]),
                        ),
                        title: Text(list[index]["name"],
                          style: TextStyle(
                            fontSize: 16.5,
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text("매수가 : ${list[index]["price"]}\n"
                            "매수금액 : ${list[index]["total"]}원",
                            style: TextStyle(
                              fontSize: 8.5,
                              fontFamily: 'RobotoMono',
                              fontWeight: FontWeight.w500,
                            ))),
                  ));
            },
                itemCount: list.length);
          }
        },
      ),
    );
  }

  Widget _getHomePageWidget2() {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("buy_data").snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> queryShapshot) {
          if (queryShapshot.hasError) return Text("Error");

          if (queryShapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            final list = queryShapshot.data.documents;

            return ListView.builder(itemBuilder: (context, index) {
              return ListTile(
                title: Text(list[index]["name"]),
                subtitle: Text(list[index]["price"]),
              );
            });
          }
        },
      ),
    );
  }
}


