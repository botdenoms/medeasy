import 'package:flutter/material.dart';

import './screens.dart';
import '../widgets/widgets.dart';

import '../model/models.dart';
import 'package:get/get.dart';
import 'package:medeasy/controllers/controllers.dart';

class Authentications extends StatefulWidget {
  const Authentications({super.key});

  @override
  State<Authentications> createState() => _AuthenticationsState();
}

class _AuthenticationsState extends State<Authentications> {
  bool user = false;
  bool reset = false;
  String signUpText = 'Join others already on the platform';
  String logInText = 'Welcome back';
  String resetText = 'Password reset';
  bool resolving = false;

  // Text controllers
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 20),
              Text(
                reset
                    ? resetText
                    : user
                        ? logInText
                        : signUpText,
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 20),
              reset
                  ? ResetWidget(
                      email: email,
                      name: name,
                    )
                  : user
                      ? LogInWidget(
                          email: email,
                          password: password,
                        )
                      : SignUpWidget(
                          name: name,
                          telephone: telephone,
                          email: email,
                          password: password,
                        ),
              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      reset = false;
                      user = !user;
                    });
                  },
                  child: Text(
                    user
                        ? 'Don\'t have an account, SignUp'
                        : 'Have an account, log in',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              reset
                  ? const SizedBox()
                  : user
                      ? Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                reset = true;
                              });
                            },
                            child: const Text(
                              'Forgot the password!',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                      : const SizedBox(),
              const SizedBox(height: 30),
              resolving
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          color: Colors.greenAccent,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              resolving = !resolving;
                            });
                            bool success = await authHander();
                            setState(() {
                              resolving = !resolving;
                            });
                            if (!success) {
                              // display error
                              Get.snackbar(
                                  'Failed', 'Failed to process your request',
                                  backgroundColor: Colors.redAccent);
                              return;
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const Account(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(
                              10.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x22000000),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(2, 2),
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                reset
                                    ? 'Reset'
                                    : user
                                        ? 'Log In'
                                        : 'Sign Up',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1E1E1E),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> authHander() async {
    // input validation
    if (reset) {
      if (name.text == '' || email.text == '') {
        // empty fields
        return false;
      } else {
        // reset action
        return false;
      }
    }
    if (user) {
      // log in
      if (password.text == '' || email.text == '') {
        // empty fields
        return false;
      } else {
        final UserController userCon = Get.find();
        bool success = await userCon.logIn(email.text, password.text);
        return success;
      }
    } else {
      // sign up
      if (password.text == '' ||
          email.text == '' ||
          name.text == '' ||
          telephone.text == '') {
        // empty fields
        return false;
      } else {
        final UserController userCon = Get.find();
        final FireStoreController fireCon = Get.find();
        String? id = await userCon.singUp(email.text, password.text);
        if (id == null) {
          return false;
        } else {
          User user = User(
            name: name.text,
            email: email.text,
            telephone: telephone.text,
            at: DateTime.now(),
            specialist: false,
          );
          bool success = await fireCon.addUser(user, id);
          return success;
        }
      }
    }
  }
}
