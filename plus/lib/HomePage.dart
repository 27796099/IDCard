import 'package:flutter/material.dart';
import 'package:plus/operation.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final operation op = operation();
  final item = ['plus', 'subtraction', 'multiplication', 'division'];
  String dropdownValue = 'plus';
  String x = "";
  String y = "";
  double ans = 0;
  String equal = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'x',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    if (value == null) {
                      setState(() => x = "0");
                    } else {
                      setState(() => x = value);
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  value: dropdownValue,
                  icon: Icon(Icons.menu),
                  underline: Container(
                    height: 2,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      //print(dropdownValue);
                    });
                  },
                  items: item.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'y',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    if (value == null) {
                      setState(() => y = "0");
                    } else {
                      setState(() => y = value);
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (dropdownValue == "plus") {
                      ans = op.plus(x, y);
                      setState(() {
                        equal = '答案為$ans';
                      });
                    } else if (dropdownValue == "subtraction") {
                      ans = op.subtraction(x, y);
                      setState(() {
                        equal = '答案為$ans';
                      });
                    } else if (dropdownValue == "multiplication") {
                      ans = op.multiplication(x, y);
                      setState(() {
                        equal = '答案為$ans';
                      });
                    } else {
                      ans = op.division(x, y);
                      setState(() {
                        equal = '答案為$ans';
                      });
                    }
                  },
                  child: Text(
                    '=',
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
                SizedBox(
                  height: 28.0,
                ),
                Text(
                  equal,
                  style: TextStyle(color: Colors.red, fontSize: 30.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
