import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TokenVerify extends GetxController {
  Future<bool> verify() async {
    var token = await APICacheManager().getCacheData("login_token");
    var headers = {
      'Authorization': 'Bearer ${token.syncData}',
    };

    var url = Uri.parse(baseUrl + verifyTokenUrl);
    var res = await http.get(url, headers: headers);
    print(res.statusCode);
    if (res.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }
}
