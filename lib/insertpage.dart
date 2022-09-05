import 'package:fillform/baseclass.dart';
import 'package:fillform/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class insertpage extends StatefulWidget {
  Map? m;

  insertpage({this.m});

  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {
  Database? db;
  List<bool> view = [true, true];
  int _dart=0;
  int _java=0;
  int _c=0;
  int _c1=0;

  String radio = "";

  TextEditingController _name = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _cpassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    baseclass().createdatabase().then((value) {
      db = value;
    });

    if (widget.m != null) {
      _name.text = "${widget.m!['name']}";
      _contact.text = "${widget.m!['contact']}";
      _email.text = "${widget.m!['email']}";
      _password.text = "${widget.m!['password']}";
      radio = "${widget.m!['gender']}";
      _dart=widget.m!['dart'];
      _java=widget.m!['java'];
      _c=widget.m!['c'];
      _c1=widget.m!['c1'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      controller: _name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("First Name"),
                        suffixIcon: Icon(Icons.person),
                        prefix: Text("Mr."),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: _contact,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Phone Number"),
                        suffixIcon: Icon(Icons.call),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                        suffixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _password,
                      obscureText: view[0],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Enter Password"),
                        helperText: "Must be 1 or more Number",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                view[0] = !view[0];
                              });
                            },
                            icon: view[0]
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      //controller: _cpassword,
                      obscureText: view[1],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Confirm Password"),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                view[1] = !view[1];
                              });
                            },
                            icon: view[1]
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("Gender :"),
                        Radio(
                          onChanged: (value) {
                            radio = value.toString();
                            setState(() {});
                          },
                          value: "Male",
                          groupValue: radio,
                        ),
                        Text("Male"),
                        Radio(
                          onChanged: (value) {
                            radio = value.toString();
                            setState(() {});
                          },
                          value: "Female",
                          groupValue: radio,
                        ),
                        Text("Female"),
                        Radio(
                          onChanged: (value) {
                            radio = value.toString();
                            setState(() {});
                          },
                          value: "Other",
                          groupValue: radio,
                        ),
                        Text("Other"),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Text("Language :"),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Checkbox(
                                      onChanged: (value) {
                                        _c = value!?1:0;
                                        setState(() {});
                                      },
                                      value: _c==1?true:false),
                                  Text(
                                    "C Language",
                                  ),
                                  Checkbox(
                                      onChanged: (value) {
                                        _c1 = value!?1:0;
                                        setState(() {});
                                      },
                                      value: _c1==1?true:false),
                                  Text("C++"),
                                  Checkbox(
                                      onChanged: (value) {
                                        _dart = value!?1:0;
                                        setState(() {});
                                      },
                                      value: _dart==1?true:false),
                                  Text("Dart"),
                                  Checkbox(
                                      onChanged: (value) {
                                        _java = value!?1:0;
                                        setState(() {});
                                      },
                                      value: _java==1?true:false),
                                  Text("Java")
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: (widget.m == null)
                          ? ElevatedButton(
                              onPressed: () async {
                                String name = _name.text;
                                String contact = _contact.text;
                                String email = _email.text;
                                String password = _password.text;
                                String _gender=radio;

                                String qry =
                                    "insert into Test (name,contact,email,password,gender,c,c1,dart,java) values ('$name','$contact','$email','$password','$_gender','$_c','$_c1','$_dart','$_java')";
                                await db!.rawInsert(qry);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return viewpage();
                                  },
                                ));
                              },
                              child: Text("Submit"))
                          : ElevatedButton(
                              onPressed: () async {
                                String name = _name.text;
                                String contact = _contact.text;
                                String email = _email.text;
                                String password = _password.text;
                                String _gender=radio;


                                String qry =
                                    "update Test set name='$name',contact='$contact',email='$email',password='$password',gender='$_gender',c='$_c' ,c1='$_c1' ,dart='$_dart' ,java='$_java' where id='${widget.m!['id']}' ";
                                await db!.rawUpdate(qry);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return viewpage();
                                  },
                                ));
                              },
                              child: Text("Update")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: goback);
  }

  Future<bool> goback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return viewpage();
      },
    ));
    return Future.value();
  }
}
