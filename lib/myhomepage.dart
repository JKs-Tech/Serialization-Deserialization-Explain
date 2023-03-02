import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serialize_deserialize/usermodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<UserModel> dataList = [];

class _MyHomePageState extends State<MyHomePage> {
  Future<List<UserModel>> getUser() async {
    final userData =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(userData.body.toString());
    if (userData.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        dataList.add(UserModel.fromJson(i));
      }
      return dataList;
    } else {
      return dataList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(dataList[index].title.toString()),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
