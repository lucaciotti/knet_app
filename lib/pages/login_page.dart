import 'package:flutter/material.dart';
import 'package:knet_app/controllers/login_controller.dart';
import 'package:validate/validate.dart';
// import 'package:knet_app/pages/home_page.dart';

class _LoginData {
  String username = '';
  String password = '';
}

class LoginPage extends StatefulWidget {
  // static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  LoginController _loginCtrl = new LoginController();
  _LoginData _data = new _LoginData();
  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'luca.ciotti@gmail.com',
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: this._validateEmail,
      onSaved: (String value) {
        this._data.username = value;
      }
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '112358',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onSaved: (String value) {
        this._data.password = value;
      }
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightGreen.shade100,
        color: Colors.lightGreen,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () { 
            this.submit();
            // Navigator.of(context).pushNamed('/home');
          },
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: this._formKey,
          child: Padding(
            // shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logo,
                SizedBox(height: 48.0),
                email,
                SizedBox(height: 8.0),
                password,
                SizedBox(height: 24.0),
                loginButton,
                _isLoading ? CircularProgressIndicator() : forgotLabel
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }

  void submit() async {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save(); // Save our form now.
      var res = await this._loginCtrl.login(this._data.username, this._data.password);
      if (res["error"] != null) {  
        setState(() {
          _isLoading = false;
        });
        this._showDialog(res["error"], res['message']);
      } else {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }
  
  // user defined function
  void _showDialog(title, content) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Warning!"),
          content: new Text(content),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}