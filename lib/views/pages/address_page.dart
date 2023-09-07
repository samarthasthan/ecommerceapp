import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/views/pages/edit_address_page_.dart';
import 'package:ecommerceapp/views/widgets/texts/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        iconTheme: const IconThemeData(color: blackColor),
        backgroundColor: whiteColor,
        title: Paragraph(
          text: 'Addresses',
          weight: FontWeight.bold,
          color: blackColor,
        ),
      ),
      body: ListView.builder(
          itemCount: 2,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(4.0.sp),
              child: Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(curve)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Paragraph(
                          text: 'Default',
                          color: greenColor,
                        ),
                      ),
                      Paragraph(
                        text: 'Samarth Asthan',
                        weight: FontWeight.bold,
                      ),
                      Paragraph(
                        text: address,
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => EditAddressPage());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: greyColor),
                                  borderRadius: BorderRadius.circular(curve)),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50.w, vertical: 5.h),
                                  child: Paragraph(
                                    text: "Edit",
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: greyColor),
                                borderRadius: BorderRadius.circular(curve)),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50.w, vertical: 5.h),
                                child: Paragraph(
                                  text: "Delete",
                                  color: redColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
