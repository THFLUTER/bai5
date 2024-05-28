import 'dart:convert';

import 'package:bai5/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  bool _checkvalue_1 = false;
  bool _checkvalue_2 = false;
  bool _checkvalue_3 = false;
  int _gender = 0;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passswordController = TextEditingController();
  final _confirmpassController = TextEditingController();
  //get user
  getUser() {
    var fullname = _nameController.text;
    var email = _emailController.text;
    //get gender
    var gendername = 'None';
    if (_gender == 1) {
      gendername = "Male";
    } else if (_gender == 2) {
      gendername = "Female";
    } else {
      gendername = "other";
    }
    //
    var favoriteName = '';
    if (_checkvalue_1) {
      favoriteName += "Music, ";
    }
    if (_checkvalue_2) {
      favoriteName += "Movie, ";
    }
    if (_checkvalue_3) {
      favoriteName += "Book, ";
    }
    if (favoriteName != "")
      favoriteName = favoriteName.substring(0, favoriteName.length - 2);
    // create class
    var objUser = User(
        fullname: fullname,
        email: email,
        gender: gendername,
        favorite: favoriteName);
    return objUser;
  }

  //sava user to shared _ preferences
  Future<bool> saveUser(User objUser) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String strUser = jsonEncode(objUser);
      prefs.setString('user', strUser);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'User Information',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Full name",
                  icon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  icon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  icon: Icon(Icons.password),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmpassController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm password",
                  icon: Icon(Icons.password),
                ),
              ),
              const SizedBox(height: 16),
              const Text("What is your gender?"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Male"),
                      leading: Transform.translate(
                        offset: const Offset(16, 0),
                        child: Radio(
                          value: 1,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text("Female"),
                    leading: Transform.translate(
                      offset: const Offset(16, 0),
                      child: Radio(
                        value: 2,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                  )),
                  Expanded(
                      child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text("other"),
                    leading: Transform.translate(
                      offset: const Offset(16, 0),
                      child: Radio(
                        value: 3,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 16),
              const Text("What is your favorite?"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Music"),
                      value: _checkvalue_1,
                      onChanged: (value) {
                        setState(() {
                          _checkvalue_1 = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Movie"),
                      value: _checkvalue_2,
                      onChanged: (value) {
                        setState(() {
                          _checkvalue_2 = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Book"),
                      value: _checkvalue_3,
                      onChanged: (value) {
                        setState(() {
                          _checkvalue_3 = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        //get value

                        User objUser = getUser();
                        //save tp share
                        if (await saveUser(objUser) == true) {
                          print(objUser.toJson());
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text('Alert'),
                                  content: SingleChildScrollView(
                                      child: Text("save successfull")),
                                );
                              });
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text("login"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
