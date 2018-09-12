import 'package:knet_app/models/_abstract_model.dart';

class User implements Model {
  int id;
  String _nickname;
  String _email;
  String _lang;
  String _ditta;

  User(this._nickname, this._email, this._lang, this._ditta);

  User.map(dynamic obj) {
    this._nickname = obj["nickname"];
    this._email = obj["email"];
    this._lang = obj["lang"];
    this._ditta = obj["ditta"];
  }

  String get nickname => _nickname;
  String get email => _email;
  String get lang => _lang;
  String get ditta => _ditta;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["nickname"] = _nickname;
    map["email"] = _email;
    map["lang"] = _lang;
    map["ditta"] = _ditta;

    return map;
  }
  
}