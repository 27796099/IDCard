import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reservoirapi/model/data.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<hosdata> datas = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    getData(); // 第一次加载数据
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      getData(); // 每分钟调用一次getData方法
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 在页面销毁时取消定时器
    super.dispose();
  }

  Future<void> getData() async {
    var response = await http.get(Uri.https('api.kcg.gov.tw',
        'api/service/get/c54aabef-9426-471f-98c3-a99b70568f82'));
    var jsonData = jsonDecode(response.body);
    if (jsonData['data'] != null) {
      List<hosdata> dataList = [];
      for (var eachData in jsonData['data']) {
        final data = hosdata(
          NB: eachData['NB'],
          SDD_SENAME: eachData['SDD_SENAME'],
          SDD_EMPNAME: eachData['SDD_EMPNAME'],
          SDD_ROOMNO: eachData['SDD_ROOMNO'],
        );
        dataList.add(data);
      }
      setState(() {
        datas = dataList; // 更新数据并刷新界面
      });
    }
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('高雄市立民生醫院診間看診進度'),
      ),
      body: ListView.builder(
        itemCount: datas.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    datas[index].NB,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "科名: ${datas[index].SDD_SENAME}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "室號: ${datas[index].SDD_ROOMNO}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "醫生: ${datas[index].SDD_EMPNAME}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
