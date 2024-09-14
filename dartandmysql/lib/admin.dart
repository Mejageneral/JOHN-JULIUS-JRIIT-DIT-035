import 'dart:io';
// import 'package:dart_and_mysql/mkuuu.dart';
import 'dbConnection.dart';
import 'dart:async';
import 'mkuu.dart';

Future adminLogin() async {
  var conn = await DBconnection();
  
  print("#" * 30);
  print("#${" Welcome to Admin Panel ".padLeft(15).padRight(28)}#");
  print("#" * 30);
  print("");
  print("Please Authorize your Administrative Identity");
  print("");


  stdout.write("Enter Your Username: ");
  var userUsername = stdin.readLineSync();

  stdout.write("Enter Your Password: ");
  stdin.echoMode = false;
  var userPassword = stdin.readLineSync();
  stdin.echoMode = true;

  var dbUsernames = await conn.query("SELECT username FROM users");
  var userList = [];
  for (var user in dbUsernames) {
    userList.add(user.first.toString());
  }

  if (userList.contains(userUsername)) {
    var uUsername = userUsername;

    var dbPassword = await conn
        .query("SELECT password FROM users WHERE username=?", [uUsername]);
    var names = [];
    var dbNames =
        await conn.query("select * from users where username=?", [uUsername]);

    for (var name in dbNames.toList()) {
      names.add(name[0].toString());
      names.add(name[1].toString());
    }
    var realPassword = dbPassword.toList()[0][0];

    var dbRole = await conn
        .query("SELECT role FROM users WHERE username=?", [uUsername]);
    var dbRoles = await conn.query("select * from users where username=?", [uUsername]);
    for (var role in dbRoles.toList()) {
      names.add(role[0].toString());
      names.add(role[1].toString());
    }
    var realRole = dbRole.toList()[0][0];

    if (realPassword.toString() == userPassword.hashCode.toString() &&
        realRole == "mkuu") {
      print("");
      print("welcome ${names[0]} ${names[1]}");
      mkuuu(); 
    }
    await conn.close();
  } else {
    print("Wewe sio Mkuu");
  }
}
