import 'dbconnection.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';

// Function to handle password reset
Future resetPassword() async {
  var conn = await DBconnection();

  print("===== RESET YOUR PASSWORD =====");
  print("");

  stdout.write("====1. Enter your username: ");
  var username = stdin.readLineSync();

  stdout.write("====2. Enter your first name: ");
  var firstName = stdin.readLineSync();

  stdout.write("====3. Enter your last name: ");
  var lastName = stdin.readLineSync();

  var userCheck = await conn.query(
      'SELECT * FROM users WHERE username = ? AND first_name = ? AND last_name = ?',
      [username, firstName, lastName]);

  if (userCheck.isNotEmpty) {

    var verificationCode = Random().nextInt(900000) + 100000;

    print(
        "==== A verification code has been sent to your terminal: $verificationCode ====");

    stdout.write("====4. Enter the verification code: ");
    var userInputCode = stdin.readLineSync();

    if (userInputCode == verificationCode.toString()) {
      stdout.write("====5. Enter your new password: ");
      stdin.echoMode = false;
      var newPassword = stdin.readLineSync().hashCode;
      stdin.echoMode = true;
      print("");

      stdout.write("====6. Confirm your new password: ");
      stdin.echoMode = false;
      var confirmPassword = stdin.readLineSync().hashCode;
      stdin.echoMode = true;
      print("");

      if (newPassword == confirmPassword) {
        await conn.query('UPDATE users SET password = ? WHERE username = ?',
            [newPassword, username]);

        print("===== Your password has been successfully reset! =====");
        await conn.close();
      } else {
        print("Passwords do not match, please try again.");
      }
    } else {
      print("Invalid verification code, please try again.");
    }
  } else {
    print("Invalid details provided. Please try again.");
  }

  await conn.close();
}
