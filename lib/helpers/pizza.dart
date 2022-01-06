import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:practice_web/main.dart';
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
  List<String> steps=["Step 1","step 2","step 3","step 4"];
  @override
  void initState() {
    super.initState();
    _value = widget.cartItem.itemName;
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