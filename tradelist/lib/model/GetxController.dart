import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuilderController extends GetxController {
  double su;

  double count = 0;
  double total=0;

  increment() {
    count++;
    update();
  }

  increment2() {
    count= count +10;
    update();
  }

  decrease() {
    count--;
    update();
  }

  decrease2() {
    count= count -10;
    update();
  }

  ten() {
    count = su * 0.1;
    update();
  }

  fifty() {
    count = su * 0.5;
    update();
  }

  one_hundred() {
    count = su;
    update();
  }

  movedata(String volume) {
    count = double.parse(volume);
    su = double.parse(volume);
    update();
  }

  resultdata(double volume,int price){
    if(print==0){
      total=0;
      update();
    }else
    total = count*price;
    update();
  }
}



