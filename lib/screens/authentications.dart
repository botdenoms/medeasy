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
                  : Center(
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
                    ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () async {
                      bool success = await authHander();
                      if (!success) {
                        // display error
                        return;
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Account(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(
                        10.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1EEE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          reset
                              ? 'Reset'
                              : user
                                  ? 'Log In'
                                  : 'Sign Up',
                          style: const TextStyle(fontSize: 16),
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
        // check user pass
        // try {
        //   // ignore: unused_local_variable
        //   final credential =
        //       await FirebaseAuth.instance.signInWithEmailAndPassword(
        //     email: email.text,
        //     password: password.text,
        //   );
        //   return true;
        // } catch (e) {
        //   // on FirebaseAuthException
        //   // if (e.code == 'user-not-found') {
        //   //   print('No user found for that email.');
        //   // } else if (e.code == 'wrong-password') {
        //   //   print('Wrong password provided for that user.');
        //   // }
        //   // ignore: avoid_print
        //   print(e);
        //   return false;
        // }
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
          );
          bool success = await fireCon.addUser(user, id);
          return success;
        }
        // new user
//         try {
//           // ignore: unused_local_variable
//           final credential =
//               await FirebaseAuth.instance.createUserWithEmailAndPassword(
//             email: email.text,
//             password: password.text,
//           );
//           //  firestore add user data
// final db = FirebaseFirestore.instance;
//           Map<String, dynamic> data = {
//             'name': name.text,
//             'telephone': telephone.text,
//             'email': email.text,
//             'specialist': false,
//             'at': DateTime.now(),
//           };
//           await db
//               .collection('users')
//               .doc(credential.user?.uid)
//               .set(data)
//               // ignore: avoid_print
//               .onError((e, _) => print(e));
//           return true;
//         } catch (e) {
//           // if (e.code == 'weak-password') {
//           //   print('The password provided is too weak.');
//           // } else if (e.code == 'email-already-in-use') {
//           //   print('The account already exists for that email.');
//           // }
//           // ignore: avoid_print
//           print(e);
//           return false;
//         }
      }
    }
  }
}
