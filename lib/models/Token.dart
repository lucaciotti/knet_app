import 'package:knet_app/models/_abstract_model.dart';

class Token implements Model {
  int id;
  String _tokenType;
  int _expiresIn;
  String _accessToken;
  String _refreshToken;

  Token(this._tokenType, this._expiresIn, this._accessToken, this._refreshToken);

  Token.map(dynamic obj) {
    this._tokenType = obj["token_type"];
    this._expiresIn = obj["expires_in"];
    this._accessToken = obj["access_token"];
    this._refreshToken = obj["refresh_token"];
  }

  String get tokenType => _tokenType;
  int get expiresIn => _expiresIn;
  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["token_type"] = _tokenType;
    map["expires_in"] = _expiresIn;
    map["access_token"] = _accessToken;
    map["refresh_token"] = _refreshToken;
    return map;
  }

  Token.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    _tokenType = map["token_type"];
    _expiresIn = map["expires_in"];
    _accessToken = map["access_token"];
    _refreshToken = map["refresh_token"];
  }
}