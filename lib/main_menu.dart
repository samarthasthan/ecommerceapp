import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/views/pages/account_page.dart';
import 'package:ecommerceapp/views/pages/category_page.dart';
import 'package:ecommerceapp/views/pages/home_page.dart';
import 'package:ecommerceapp/views/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final PageController controller = PageController();

  /// initializing controller for PageView

  int currentIndex = 0;
  final tabPages = [
    const HomePage(),
    const CategoryPage(),
    const WishListPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        /// Wrapping the tabs with PageView
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: tabPages,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;

            /// Switching bottom tabs
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey))),
        height: 82,
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            iconSize: 20.sp,
            selectedFontSize: 11.0,
            unselectedFontSize: 11.0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: blackColor,
            currentIndex: currentIndex,
            onTap: (index) {
              controller.jumpToPage(index);

              /// Switching the PageView tabs
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: PhosphorIcon(
                  PhosphorIcons.light.house,
                  color: greyColor,
                ),
                label: "Home",
                activeIcon: PhosphorIcon(
                  PhosphorIcons.regular.house,
                  color: blackColor,
                ),
              ),
              BottomNavigationBarItem(
                  icon: PhosphorIcon(
                    PhosphorIcons.light.squaresFour,
                    color: greyColor,
                  ),
                  activeIcon: PhosphorIcon(
                    PhosphorIcons.regular.squaresFour,
                    color: blackColor,
                  ),
                  label: "Category"),
              BottomNavigationBarItem(
                  icon: PhosphorIcon(
                    PhosphorIcons.light.heart,
                    color: greyColor,
                  ),
                  activeIcon: PhosphorIcon(
                    PhosphorIcons.regular.heart,
                    color: blackColor,
                  ),
                  label: "Wishlist"),
              BottomNavigationBarItem(
                  icon: PhosphorIcon(
                    PhosphorIcons.light.userCircle,
                    color: greyColor,
                  ),
                  activeIcon: PhosphorIcon(
                    PhosphorIcons.regular.userCircle,
                    color: blackColor,
                  ),
                  label: "Account"),
            ],
          ),
        ),
      ),
    );
  }
}
