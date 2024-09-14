import 'dart:io';
import 'dbConnection.dart';

Future acDetails() async {  
  var conn = await DBconnection();
  
  print("===  Welcome to Our Viewing Academic Details Page  ===");
  print("===  Please Authorize Your Identity  ===");
  
  stdout.write("Enter your username: ");
  var userUsername = stdin.readLineSync();
  print("");
  
  var dbusernames = await conn.query("SELECT username FROM academic_details");
  var userList = [];
  for (var user in dbusernames) {
    userList.add(user.first.toString());
  }

  if (userList.contains(userUsername)) {
    var uusername = userUsername;
    var names = [];
    
    var dbnames = await conn.query("SELECT * FROM academic_details WHERE username=?", [uusername]);

    for (var name in dbnames.toList()) {
      names.add(name[0].toString()); 
      names.add(name[1].toString()); 
      names.add(name[2].toString()); 
      names.add(name[3].toString()); 
      names.add(name[4].toString()); 
    }
    
    print("Your username is '${names[0]}', Course name '${names[1]}', Institution name '${names[2]}', "
      "year of completion '${names[3]}', and GPA is '${names[4]}'.");
    
    await conn.close();
  } else {
    print("Username not found in academic details.");
    await conn.close();
  }
}
