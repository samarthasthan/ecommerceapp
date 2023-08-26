import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/delete_account_controller.dart';
import 'package:ecommerceapp/controllers/nagivation_animations/up_down_navigation.dart';
import 'package:ecommerceapp/views/boarding/onboard_page.dart';
import 'package:ecommerceapp/views/widgets/buttons/basic_text_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: whiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                APICacheManager().deleteCache('login_token');
                UpDownNavigation().navigateToPage(context, page: StartPage());
              },
              child: BasicTextButton(
                text: "Log out",
                textColor: whiteColor,
                backgroundColor: blackColor,
              ),
            ),
            SizedBox(
              height: padding,
            ),
            GestureDetector(
              onTap: () async {
                await DeleteAccount().delete();
                UpDownNavigation().navigateToPage(context, page: StartPage());
              },
              child: BasicTextButton(
                text: "Delete Account",
                textColor: whiteColor,
                backgroundColor: blackColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
