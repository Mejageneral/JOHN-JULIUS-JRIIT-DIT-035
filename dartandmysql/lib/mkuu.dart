import 'dart:async';
import 'dart:io';
import 'registerRG.dart';
import 'register.dart';

// Function to handle actions for "mkuu" (admin)
Future mkuuAct() async {
  print("What do you want?");
  print("1. Register Registrar");
  print("2. Register Normal User");

  stdout.write("Press 1 to Register Registrar or 2 for Normal user: ");
  var userInput = stdin.readLineSync();
  
  if (userInput == "1") {
    registrarRegister(); 
  } else if (userInput == "2") {
    userRegister(); 
  }
}

Future mkuuu() async {
  mkuuAct(); 
}
