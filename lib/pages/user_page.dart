import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late List<User> listUser = [];
  late Future<List<User>> _future;
  late ScrollController scroll = ScrollController();
  String selectedName = "";
  int page = 1;
  bool isLoading = false;

  Future<List<User>> getUser(int page) async {
    var url = Uri.parse("https://reqres.in/api/users?page=$page");
    var respone = await http.get(url);
  if(respone.statusCode ==200){
    final parsed = jsonDecode(respone.body);
    Data dataUser = Data.fromJson(parsed);
    listUser.addAll(dataUser.data);
    page++;
  return listUser;
  }
  else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      listUser.clear();
      page = 2;
    });
    _future = getUser(page);
  }

  @override
  void initState() {
    _future = getUser(page);
    super.initState();
    scroll.addListener(() async {
      if (scroll.position.pixels == scroll.position.maxScrollExtent &&
          !isLoading) {
        setState(() {
          isLoading = true;
        });
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _future = getUser(page);
        });
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Third Screen',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
                future: _future,
                builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
                if(snapshot.hasData){
                  var listDataUser = snapshot.data;
                  if(listDataUser!.isNotEmpty){
                    return Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                         return Stack(
                          children: <Widget>[
                            RefreshIndicator(
                              onRefresh: refresh,
                              child: ListView.builder(
                                controller: scroll,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: listDataUser.length,
                                itemBuilder: (context,index){
                                  return ListTile(
                                    leading: Image.network(listDataUser[index].avatar.toString()),
                                    title: Text(listDataUser[index].firstName.toString()+listDataUser[index].lastName.toString()),
                                    
                                    subtitle: Text(listDataUser[index].email.toString()),
                                    onTap: (){
                                      selectedName =
                                      "${listDataUser[index].firstName} ${listDataUser[index].lastName}";
                                  Navigator.pop(context, [selectedName]);
                                    }
                                  );
                                }
                                ),
                      
                              ),
                              if(isLoading)...[
                                       const Positioned(
                                          left: 0,
                                          bottom: 0,
                                          child: SizedBox(
                                            height: 80,
                                            width: 20,
                                            child:  Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                      ]
                          ],
                        );
                        },                    
                      ),
                    );
                    }else {
                        return Center(
                          child: Column(
                            children: const <Widget>[
                              Text("Tidak Ada Data")
                            ],
                          ),
                        );
                      }
                  }else {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: const <Widget>[
                                  SizedBox(height: 5),
                                  CircularProgressIndicator(),
                                  SizedBox(height: 5),
                                ],
                              ),
                            );
                          }
                        ),
                      );
                    }
                   }            
                ),
        ],
      )
    );
  }
}
