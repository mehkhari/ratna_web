
import 'package:flutter/material.dart';
import 'package:practice_web/helpers/pizza.dart';
import 'package:practice_web/main.dart';

class CartWidget extends StatefulWidget {
  List<CartItem> cart;
  int index;
  VoidCallback callback;

  CartWidget({required this.cart, required this.index, required this.callback});
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Pizza(cartItem: widget.cart[widget.index])),
        // Expanded(child: Flavor(cartItem: widget.cart[widget.index])),
        IconButton(
          icon: Icon(Icons.delete,color: Colors.white,),
          onPressed: () {
            setState(() {
              print(widget.index);
              widget.cart.removeAt(widget.index);
              widget.callback();
            });
          },
        )
      ],
    );
  }
}