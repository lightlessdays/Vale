import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valecode/pages/homepage/homepage.dart';
import 'package:valecode/pages/login/register.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _auth = FirebaseAuth.instance;
  bool emailError = false;
  bool passwordError = false;
  bool obscureText = true;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://raw.githubusercontent.com/lightlessdays/img/main/vale/V%20A%20L%20E.jpg",
                width: (MediaQuery.of(context).size.width) / 2.5,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                cursorColor: Colors.black,
                style: const TextStyle(
                    fontFamily: 'PoppinsLight',
                    color: Colors.black,
                    fontSize: 20.0),
                controller: emailTextController,
                decoration: InputDecoration(
                  errorText:
                      (emailError) ? "Please enter a valid e-mail." : null,
                  hintText: "E-mail",
                  filled: true,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: obscureText,
                cursorColor: Colors.black,
                style: const TextStyle(
                    fontFamily: 'PoppinsLight',
                    color: Colors.black,
                    fontSize: 20.0),
                controller: passwordTextController,
                decoration: InputDecoration(
                  errorText: (passwordError)
                      ? "Password must be at least 8 charachters long."
                      : null,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        (obscureText) ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      )),
                  hintText: "Password",
                  filled: true,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  String email = emailTextController.text;
                  String password = passwordTextController.text;
                  if (isValidEmail(email)) {
                    setState(() {
                      emailError = false;
                    });
                    if (password.length > 7) {
                      setState(() async {
                        passwordError = false;
                        try {
                          await _auth.signInWithEmailAndPassword(email: email, password: password);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const HomePage(),
                            ),
                          );
                        } catch (e) {
                          String exception = e.toString();
                          exception=exception.replaceAll(
                              "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.",
                              "The password entered is invalid.");
                          exception=exception.replaceAll("[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.", "The email does not exist.");
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Expanded(
                                child: AlertDialog(
                                  title: Text(exception),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.black),
                                      ),
                                      child: const Text('CLOSE'),

                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      });

                      //condition hit
                    } else {
                      setState(() {
                        passwordError = true;
                      });
                    }
                  } else {
                    setState(() {
                      emailError = true;
                    });
                  }
                },
                child: Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: const Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                          fontFamily: 'PoppinsLight',
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a user? ',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsExtraLight',
                        fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RegistrationScreen()
                        ),
                      );
                    },
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsSemiBold',
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
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

  bool isValidEmail(String mailId) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(mailId);
    return emailValid;
  }
}
