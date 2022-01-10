import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:practice_web/main.dart';
import 'package:http/http.dart'as http;
import 'package:practice_web/models/step_response.dart';
import 'package:practice_web/service/httpService.dart';

class Pizza extends StatefulWidget {
  CartItem cartItem;

  Pizza({required this.cartItem});
  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  String _value = "";
  List<String> steps=["Step 1"];
  List<StepsResponse> stepResponse=[];
  @override
  void initState() {
    super.initState();
    getSteps();
    _value = widget.cartItem.itemName;
  }

  getSteps()async{
    log("<---Hitting the Steps Data--->");
    var response = await http.get(Uri.parse("https://rathna3121.pythonanywhere.com/video_list/"));
    setState(() {
      stepResponse=stepsResponseFromJson(response.body);
      loopSteps(stepResponse);
    });
  }
  loopSteps(List<StepsResponse> stepResponse){
    for(var i in stepResponse){
      setState(() {
        steps.add(i.stepname.toString());
      });
    }
  }
  @override
  void didUpdateWidget(Pizza oldWidget) {
    if (oldWidget.cartItem.itemName != widget.cartItem.itemName) {
      _value = widget.cartItem.itemName;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff5499C7),
          borderRadius: BorderRadius.circular(4)
      ),
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: DropdownButton(
          value: _value,
          underline:SizedBox(),
          isExpanded: true,
          items:steps.map((e) {
            return DropdownMenuItem(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("$e"),
                ), value: "$e");
          }).toList(),
          onChanged: (value) {
            setState(() {
              _value = value.toString();
              widget.cartItem.itemName = value.toString();
            });
          }),
    );
  }
}