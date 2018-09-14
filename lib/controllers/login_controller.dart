import 'dart:async';
import 'package:knet_app/helpers/network_api.dart';
import 'package:knet_app/helpers/database.dart';

import 'package:knet_app/models/Token.dart';

class LoginController {
  // static final _baseUrl = env['BASE_URL'];
  // static final _apiKey = env['APY_KEY'];
  // static final _apiScope = env['APY_SCOPE'];
  // static final _apiClientId = env['APY_CLIENT_ID'];
  // static final _apiGrantType = env['APY_GRANT_TYPE'];

  NetApiHelper _netUtil = new NetApiHelper();
  DbHelper _db = new DbHelper();

  Future<dynamic> login(String username, String password) {
    final loginUrl = Uri.http("kdev.kronakoblenz.it","/oauth/token");
    final body = {
      "client_id": "2",//_apiClientId,
      "client_secret": "h6RtVyifEqGrkIKEnZz2Q7vTPTFzR1kC4F02s1fB",//_apiKey,
      "scope": "*",//_apiScope,
      "grant_type": "password",//_apiGrantType,
      "username": username,
      "password": password
    };

    return _netUtil.post(loginUrl, body: body).then((dynamic res) async {
      print(res.toString());
      if(res["error"] != null) return res;
      // Token tkn = new Token.map(res);
      int trunc = await _db.truncateTable("Token");
      if (trunc>0) {
        await _db.insert("Token", new Token.map(res));
      } else {
        throw new Exception("Can't truncate DB!");
      }
      /* Map map = await _db.getFirst("Token");
      Token tkn2 = Token.fromMap(map);
      print(tkn2.toString());
      print("This is the access Token:${tkn2.accessToken}"); */
      return res;
    });
  }

}