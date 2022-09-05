import 'package:fillform/baseclass.dart';
import 'package:fillform/insertpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  Database? db;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<List<Map<String, Object?>>> getdata() async {
    db = await baseclass().createdatabase();
    String qry = "select * from Test";
    List<Map<String, Object?>> l1 = await db!.rawQuery(qry);
    return l1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return insertpage();
            },
          ));
        },
      ),
      body:FutureBuilder(builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.hasData){
            List<Map<String, Object?>> l=snapshot.data as List<Map<String, Object?>>;
            return l.length > 0
                ? ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                Map m = l[index];
                return ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return insertpage(
                          m: m,
                        );
                      },
                    ));
                  },
                  onLongPress: () {
                    showDialog(
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Delete"),
                            content: Text(
                                "Are you sure you want to delete '${m['name']}'"),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  String qry =
                                      "delete from Test where id='${m['id']}'";
                                   await db!.rawDelete(qry);
                                  setState(() {
                                  });
                                },
                                child: Text("Yes"),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No"))
                            ],
                          );
                        },
                        context: context);
                  },
                  leading: Text("${m['id']}"),
                  title: Text("${m['name']}"),
                  subtitle: Text("${m['contact']}"),
                );
              },
            )
                : Center(
              child: Text("No data found"),
            );
          }
        }
        return Center(child: CircularProgressIndicator(),);
      },future: getdata(),)
    );
  }
}
