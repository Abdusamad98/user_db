import 'package:flutter/material.dart';
import 'package:user_db/data/local/local_database.dart';
import 'package:user_db/data/models/cached_user.dart';

class MyUsersPage extends StatefulWidget {
  const MyUsersPage({Key? key}) : super(key: key);

  @override
  State<MyUsersPage> createState() => _MyUsersPageState();
}

class _MyUsersPageState extends State<MyUsersPage> {
  List<CachedUser> cachedUsers = [];



  _init()async{
    cachedUsers = await LocalDatabase.getAllCachedUsers();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users page"),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                await LocalDatabase.insertCachedUser(
                    CachedUser(age: 12, userName: "Abdulloh"));
                cachedUsers = await LocalDatabase.getAllCachedUsers();
                setState(() {});
              },
              child: const Text("Add User")),
          Expanded(
              child: ListView(
            children: List.generate(cachedUsers.length, (index) {
              var item = cachedUsers[index];
              return ListTile(
                title: Text(item.userName),
                subtitle: Text(item.id.toString()),
                trailing: IconButton(onPressed :() async{
                  LocalDatabase.deleteCachedUserById(item.id!);
                  cachedUsers = await LocalDatabase.getAllCachedUsers();
                  setState(() {});
                },icon: const Icon(Icons.delete),),
              );
            }),
          ))
        ],
      ),
    );
  }
}
