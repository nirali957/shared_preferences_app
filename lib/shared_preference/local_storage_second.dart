import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSecondScreen extends StatefulWidget {
  const LocalStorageSecondScreen({Key? key}) : super(key: key);

  @override
  State<LocalStorageSecondScreen> createState() => _LocalStorageSecondScreenState();
}

class _LocalStorageSecondScreenState extends State<LocalStorageSecondScreen> {
  SharedPreferences? sharedPreferences;
  int first = 0;
  bool second = true;
  String third = '';
  List<String> dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    getInstanceData();
    super.initState();
  }

  getInstanceData() async {
    sharedPreferences = await SharedPreferences.getInstance();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second screen'),
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
            // Text(
            //   "userModel: $userModel",
            //   style: const TextStyle(
            //     fontSize: 23,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getData();
        },
        heroTag: 'get second data',
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}
