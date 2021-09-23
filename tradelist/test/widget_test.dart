import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DashPage extends StatelessWidget {
  DashPage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 20,
                      spreadRadius: 10,
                    )
                  ],
                  color: Colors.indigo[500],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      '대쉬보드',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ButtonBar(
                            buttonPadding: EdgeInsets.zero,
                            alignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                onPressed: () {},
                                child: Text('입금'),
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text('출금'),
                                color: Colors.red,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('투자금액 : 원',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 80,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('수익금     : 원',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 100,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('합계         : 원',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 80, right: 34, left: 34),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 6,
                                    blurRadius: 4)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.dashboard,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Dashboard',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 6,
                                    blurRadius: 4)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.account_balance,
                                    color: Colors.white),
                                Text(
                                  'Balance',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 6,
                                    blurRadius: 4)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.credit_card,
                                  color: Colors.white,
                                ),
                                Text(
                                  'CreditCard',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 6,
                                    blurRadius: 4)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.language,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Language',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 6,
                                    blurRadius: 4)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.question_answer,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Questions',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 6,
                                    blurRadius: 4)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Visibility',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


