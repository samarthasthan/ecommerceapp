import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/views/main_menu_pages/account_page.dart';
import 'package:ecommerceapp/views/main_menu_pages/category_page.dart';
import 'package:ecommerceapp/views/main_menu_pages/home_page.dart';
import 'package:ecommerceapp/views/main_menu_pages/wishlist_page.dart';

import 'package:flutter/material.dart';
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
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: redColor,
          unselectedItemColor: blackColor,
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
              ),
              label: "Home",
              activeIcon: PhosphorIcon(
                PhosphorIcons.regular.house,
              ),
            ),
            BottomNavigationBarItem(
                icon: PhosphorIcon(
                  PhosphorIcons.light.squaresFour,
                ),
                activeIcon: PhosphorIcon(
                  PhosphorIcons.regular.squaresFour,
                ),
                label: "Category"),
            BottomNavigationBarItem(
                icon: PhosphorIcon(
                  PhosphorIcons.light.heart,
                ),
                activeIcon: PhosphorIcon(
                  PhosphorIcons.regular.heart,
                ),
                label: "Wishlist"),
            BottomNavigationBarItem(
                icon: PhosphorIcon(
                  PhosphorIcons.light.userCircle,
                ),
                activeIcon: PhosphorIcon(
                  PhosphorIcons.regular.userCircle,
                ),
                label: "Account"),
          ],
        ),
      ),
    );
  }
}
