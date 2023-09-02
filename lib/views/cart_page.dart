import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        iconTheme: IconThemeData(color: blackColor),
        backgroundColor: whiteColor,
        title: Paragraph(
          text: 'Cart',
          weight: FontWeight.bold,
          color: blackColor,
        ),
      ),
    );
  }
}
