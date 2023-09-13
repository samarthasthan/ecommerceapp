import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/controllers/user_controllers/token_verify.dart';
import 'package:ecommerceapp/main_menu.dart';
import 'package:ecommerceapp/views/boarding_pages/onboard_page.dart';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isCacheExist = await APICacheManager().isAPICacheKeyExist("user_details");
  if (isCacheExist) {
    if (await TokenVerify().verify() == true) {
      runApp(const FruBayAppHome());
    } else {
      runApp(const FruBayAppAuth());
    }
  } else {
    runApp(const FruBayAppAuth());
  }
}

class FruBayAppAuth extends StatelessWidget {
  const FruBayAppAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: backgroundColor,
              iconTheme: IconThemeData(size: 23.sp)),
          home: const StartPage(),
        );
      },
    );
  }
}

class FruBayAppHome extends StatelessWidget {
  const FruBayAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
              scaffoldBackgroundColor: backgroundColor,
              iconTheme: IconThemeData(size: 23.sp)),
          debugShowCheckedModeBanner: false,
          home: const MainMenu(),
        );
      },
    );
  }
}
