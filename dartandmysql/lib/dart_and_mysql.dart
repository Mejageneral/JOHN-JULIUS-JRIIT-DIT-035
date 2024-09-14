import 'dart:io';
import 'register.dart';
import 'admin.dart';
import 'login.dart';


void main() async {  
  print("=" * 30);
  print("=    Welcome to Our System    =");
  print("=" * 30);
  print("");
  print("=== Select an option below ===");
  print("=== 1. Login                ===");
  print("=== 2. Register             ===");

  stdout.write("Press (1) to Login or Press (2) to register: ");
  var userSelection = stdin.readLineSync();

  if (userSelection == "1") {
    print("Who are you?");
    print("1. Normal User");
    print("2. Mkuu");
    stdout.write("Press 1 or 2: ");

    var loginRole = stdin.readLineSync();

    if (loginRole == "1") {
      login(); 
    } else if (loginRole == "2") {
      adminLogin(); 
    }
  } else if (userSelection == "2") {
    userRegister(); 
  }
}
