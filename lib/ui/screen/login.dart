import 'package:authentication_imp/helper/colors.dart';
import 'package:authentication_imp/helper/loader/overlayLoader.dart';
import 'package:authentication_imp/helper/regex.dart';
import 'package:authentication_imp/helper/size_calculator.dart';
import 'package:authentication_imp/ui/components/authentication_header.dart';
import 'package:authentication_imp/ui/components/full_button.dart';
import 'package:authentication_imp/ui/components/textfields/general_textfield.dart';
import 'package:authentication_imp/ui/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:hng_authentication/widgets/widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static final _formKey = new GlobalKey<FormState>();
  // Key _k1 = new GlobalKey();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController usernameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool obscurePassword = true;
  String? _email;

  FocusNode focusNode = FocusNode();
  @override
  void dispose() {
    emailEditingController.dispose();
    usernameEditingController.dispose();
    passwordEditingController.dispose();
    // focusNode.dispose();
    super.dispose();
  }

  // loginOverlay() async {
  //   final overlay = LoadingOverlay.of(context);
  //    return await overlay.during(checkEmail());
  //   // return await overlay.during(
  //   //   Future.delayed(
  //   //     Duration(seconds: 2),
  //   //     () => Navigator.pop(context),
  //   //   ),
  //   );
  // }

  Future login(email, password) async {
    final authRepository = Authentication();
    final data = await authRepository.signIn(email, password);
    print('sign up Email >>> ${email}');
    print('sign up password >>> ${password}');
    print('sign up Email >>> ${data.email}');

    if (data != null) {
      // Registration failed, display an error message
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyHomePage(
          title: 'Home Page',
        ),
      ));

      showSnackbar(context, Colors.green, 'SignIn successful');
      print('sign up Email >>> ${data.email}');
      print('sign up id >>> ${data.id}');
      print('sign up created at >>> ${data.createdAt}');
    } else {
      showSnackbar(context, Colors.red, 'SignIn ERROR');
    }
  }

  loginOverlay(email, password) async {
    final overlay = LoadingOverlay.of(context);
   return await overlay.during(login(email, password));

  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final overlay = LoadingOverlay.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {
                // Navigator.pop(context);
              },
              padding:
                  EdgeInsets.symmetric(horizontal: sizer(true, 24, context)),
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.greySecondBackground,
                size: sizer(false, 15, context),
              )),
          backgroundColor: AppColors.greySecondBackground,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sizer(true, 24, context),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthenticationHeader(
                          titleText: "Sign in your to your account"),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: sizer(false, 18, context),
                            ),
                            Text(
                              "Welcome back to continue enjoying the amazing experience in HNG 🙌🏼",
                              style: TextStyle(
                                fontSize: sizer(true, 13, context),
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: sizer(false, 40, context),
                            ),
                            SizedBox(
                              height: sizer(false, 8, context),
                            ),
                            Text(
                              "Enter your email address",
                              style: TextStyle(
                                fontSize: sizer(true, 13, context),
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              "(e.g. example@gmail.com)",
                              style: TextStyle(
                                fontSize: sizer(true, 13, context),
                                color: AppColors.text3,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: sizer(false, 10, context),
                            ),
                            GeneralTextField(
                              key: _formKey,
                              focusNode: focusNode,
                              textController: emailEditingController,
                              keyboardType: TextInputType.emailAddress,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              // hintText: "email",
                              validator: emailVal,
                              onChanged: (val) => setState(() {
                                _email = val;
                              }),
                            ),
                            SizedBox(
                              height: sizer(false, 8, context),
                            ),
                            Text(
                              "Enter your password",
                              style: TextStyle(
                                fontSize: sizer(true, 13, context),
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              "(must be at least 8 characters)",
                              style: TextStyle(
                                fontSize: sizer(true, 13, context),
                                color: AppColors.text3,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: sizer(false, 10, context),
                            ),
                            GeneralTextField(
                              textController: passwordEditingController,
                              // hintText: "********",
                              validator: passwordVal,
                              obscureText: obscurePassword,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (val) => setState(() {}),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: sizer(true, 24, context),
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: sizer(false, 8, context),
                            ),
                            FullButton(
                              buttonText: "Done",
                              online:
                                  emailRegExMatch(emailEditingController.text),
                              buttonFunction: () async {
                                // await overlay.during(login(email, password));
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => MyHomePage(
                                //     title: 'Home Page',
                                //   ),
                                // ));
                                  final email = emailEditingController.text;
                                final password = passwordEditingController.text;
                                // loginOverlay(email, password);
                                login(email, password);
                              },
                            ),
                            SizedBox(
                              height: sizer(false, 30, context),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
