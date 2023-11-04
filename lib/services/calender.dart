import 'package:flutter/material.dart';

class GetDate {
  var date;
  getDateFromUser(context) async {
    DateTime? pickData = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2123));
    if(pickData!=null){
      date=pickData;
    }
  }
}
