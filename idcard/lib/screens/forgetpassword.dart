import 'package:flutter/material.dart';
import 'package:idcard/services/auth.dart';
import 'package:idcard/shared/constants.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({super.key});

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  final AuthService _auth = AuthService();
  final _fromkey = GlobalKey<FormState>();
  String email = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('重設密碼'),
      ),
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _fromkey,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Icon(
                    Icons.restart_alt,
                    size: 100,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    '輸入您註冊的email',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 50),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Email',
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_fromkey.currentState!.validate()) {
                        dynamic result = await _auth.resetPassword(email);
                        if (result == null) {
                          setState(() {
                            error = '信箱帳號未被註冊';
                          });
                        } else
                          (setState(() {
                            error = '信已寄出,請查看信箱';
                          }));
                      }
                    },
                    child: Text(
                      '重設密碼',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      primary: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
