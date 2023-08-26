import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:ecommerceapp/controllers/token_verify.dart';
import 'package:ecommerceapp/main_menu.dart';
import 'package:ecommerceapp/views/boarding/onboard_page.dart';
// ignore: unused_import
import 'package:ecommerceapp/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isCacheExist = await APICacheManager().isAPICacheKeyExist("login_token");
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
          home: StartPage(),
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
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainMenu(),
        );
      },
    );
  }
}
