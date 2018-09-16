import 'package:knet_app/models/_abstract_model.dart';

class User extends Model {
  String _name;
  String _nickname;
  String _email;
  String _lang;
  String _ditta;
  String _role;

  User(this._name, this._nickname, this._email, this._lang, this._ditta, this._role);

  User.map(dynamic obj) {
    this._name = obj["name"];
    this._nickname = obj["nickname"];
    this._email = obj["email"];
    this._lang = obj["lang"];
    this._ditta = obj["ditta"];
    this._role = obj["role_name"];
  }

  String get name => _name;
  String get nickname => _nickname;
  String get email => _email;
  String get lang => _lang;
  String get ditta => _ditta;
  String get roleName => _role;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["nickname"] = _nickname;
    map["email"] = _email;
    map["lang"] = _lang;
    map["ditta"] = _ditta;
    map["role_name"] = _role;

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    _name = map["name"];
    _nickname = map["nickname"];
    _email = map["email"];
    _lang = map["lang"];
    _ditta = map["ditta"];
    _role = map["role"];
  }
  
}