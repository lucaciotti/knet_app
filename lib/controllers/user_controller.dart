import 'dart:async';
import 'package:knet_app/helpers/network_api.dart';
import 'package:knet_app/helpers/database.dart';

import 'package:knet_app/models/Token.dart';
import 'package:knet_app/models/User.dart';

class UserController {
  
  NetApiHelper _netUtil = new NetApiHelper();
  DbHelper _db = new DbHelper();

  Future<Token> _getToken() async {
    return Token.fromMap(await _db.getFirst("Token"));
  }

  FutureOr<dynamic> getUserProfile() async {
    User myProfile;
    dynamic map = await _db.getFirst("User");
    if (map!=null) {
      // Info already in DB
      return myProfile = User.fromMap(map);
    } else {
      // We Have to retrieve info From the Net
      final profileUrl = Uri.http("kdev.kronakoblenz.it","/api/user");
      Token tkn = await this._getToken();
      final headers = {
        "Authorization": tkn.tokenType+" "+tkn.accessToken,
        "Accept": "application/json",
      };
      return _netUtil.get(profileUrl, headers: headers).then((dynamic res) async {
        if(res["message"] != null) return res;
        myProfile =  new User.map(res);
        //update database
        // int trunc = await _db.truncateTable("User");
        // if (trunc>0) {
          await _db.insert("User", myProfile);
        // } else {
        //   throw new Exception("Can't truncate DB!");
        // }
        return myProfile;
        });
    }
  }
}