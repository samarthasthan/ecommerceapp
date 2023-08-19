import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: whiteColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 5; i++)
                CachedNetworkImage(
                    imageUrl:
                        "https://filesamples.com/samples/image/webp/sample1.webp"),
            ],
          ),
        ));
  }
}
