import 'dart:async';
import 'dart:io';
import 'login.dart';
import 'dbConnection.dart';

Future userRegister() async {
  var conn = await DBconnection();
  print("=====WELCOME TO OUR REGISTRATION =====");
  print("");

  stdout.write("====1. Enter your first name: ");
  var fName = stdin.readLineSync();

  stdout.write("====2. Enter your last name: ");
  var lName = stdin.readLineSync();
  
  print("===== Select Your Gender =====");
  print("===== 1. Male            ======");
  print("===== 2. Female          =====");
  stdout.write("Press (1) for Male or (2) for Female: ");
  var userGender = stdin.readLineSync();
  
  // ignore: prefer_typing_uninitialized_variables
  var gender;
  if (userGender == "1") {
    gender = "MALE";
  } else if (userGender == "2") {
    gender = "FEMALE";
  }

  stdout.write("====3. Enter your username: ");
  var username = stdin.readLineSync();

  stdout.write("====4. Enter your course name: ");
  var courseName = stdin.readLineSync();

  stdout.write("====5. Enter your institution name: ");
  var institutionName = stdin.readLineSync();

  stdout.write("====6. Enter your year of completion: ");
  var yearCompletion = stdin.readLineSync();

  stdout.write("====7. Enter your GPA: ");
  var gPa = stdin.readLineSync();

  stdout.write("====8. Enter your password: ");
  stdin.echoMode = false;
  var password = stdin.readLineSync().hashCode;
  stdin.echoMode = true;
  print("");

  stdout.write("====9. Enter your password to verify: ");
  stdin.echoMode = false;
  var verPassword = stdin.readLineSync().hashCode;
  stdin.echoMode = true;
  print("");

  var urole = "kawaida";
  // ignore: prefer_typing_uninitialized_variables
  var pasword;
  
  if (password == verPassword) {
    pasword = verPassword;
    
    // ignore: unused_local_variable
    var userDataInsert = await conn.query(
      'INSERT INTO users VALUES(?,?,?,?,?,?)',
      [fName, lName, gender, username, pasword, urole]
    );

    // ignore: unused_local_variable
    var academicDataInsert = await conn.query(
      'INSERT INTO academic_details VALUES(?,?,?,?,?)',
      [username, courseName, institutionName, yearCompletion, gPa]
    );

    await conn.close(); 
    
    print("Thank you for using our registration menu");
    print("===== You are successfully registered =====");
    print("");
    print(" ______________________________________ ");
    print("#                                      #");
    print("You want to login...?");
    print("1. Yes");
    print("2. No");

    stdout.write("Press (1) to accept login page or (2) to cancel: ");
    var userAcception = stdin.readLineSync();
    if (userAcception == "1") {
      login(); 
    } else {
      exit(0); 
    }
  } else {
    print("Password did not match, try again later");
    exit(0); 
  }
}
