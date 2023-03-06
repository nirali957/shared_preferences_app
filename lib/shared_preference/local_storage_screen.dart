import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_app/model/model_data_list.dart';
import 'package:shared_preferences_app/shared_preference/local_storage_second.dart';

class LocalStorageScreen extends StatefulWidget {
  const LocalStorageScreen({Key? key}) : super(key: key);

  @override
  State<LocalStorageScreen> createState() => _LocalStorageScreenState();
}

class _LocalStorageScreenState extends State<LocalStorageScreen> {
  SharedPreferences? sharedPreferences;
  int first = 0;
  bool second = true;
  String third = '';
  List<String> dataList = [];

  UserModel? userModel;
  dynamic data = 'gf';

  @override
  void initState() {
    // TODO: implement initState
    getInstanceData();
    super.initState();
  }

  getInstanceData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getData();
    getModelData();
  }

  setData() async {
    await sharedPreferences!.setInt('first', 20);
    await sharedPreferences!.setBool('second', false);
    await sharedPreferences!.setString('third', 'name');
    await sharedPreferences!.setStringList('dataList', ['horse', 'cow', 'sheep']);
  }

  getData() async {
    if (sharedPreferences!.containsKey('first')) {
      debugPrint('true');
      first = sharedPreferences!.getInt('first')!;
      second = sharedPreferences!.getBool('second')!;
      third = sharedPreferences!.getString('third')!;
      dataList = sharedPreferences!.getStringList('dataList')!;
    } else {
      debugPrint('false');
      first = 0;
      second = true;
      third = '';
      dataList = [];
    }
    setState(() {});
  }

  removeData() {
    sharedPreferences!.remove('first');
  }

  setModelData() async {
    UserModel userModel = UserModel(
      title: "1234567",
      date: "10/12/2002",
    );

    await sharedPreferences!.setString('model_data', jsonEncode(UserModel));
  }

  // To get model data from Shared Preferences --------->>>
  getModelData() {
    data = jsonDecode(sharedPreferences!.getString('model_data')!);
    userModel = UserModel.fromJson(data);
    debugPrint("Data ------------>>> $data");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared preference first Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "first: $first",
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "second: $second",
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "third: $third",
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "dataList: $dataList",
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "data: $data",
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocalStorageSecondScreen(),
                  ),
                );
              },
              child: const Text('Next Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                setModelData();
              },
              child: const Text("Set Model Data"),
            ),
            ElevatedButton(
              onPressed: () {
                getModelData();
              },
              child: const Text("Get Model Data"),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                getData();
              },
              heroTag: 'get data',
              child: const Icon(Icons.arrow_downward),
            ),
            FloatingActionButton(
              onPressed: () {
                setData();
              },
              heroTag: 'set data',
              child: const Icon(Icons.arrow_upward),
            ),
            FloatingActionButton(
              onPressed: () {
                removeData();
              },
              heroTag: 'remove data',
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
