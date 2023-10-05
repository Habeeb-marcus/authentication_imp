import 'package:authentication_imp/helper/colors.dart';
import 'package:authentication_imp/ui/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:hng_authentication/widgets/widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var name = '';
  var  email = '';

  Future getUser() async {
    final authRepository = Authentication();
    final data = await authRepository.getUser();
    if (data != null) {
      print('sign up Email >>> ${data.email}');
      print('sign up id >>> ${data.id}');
      print('sign up created at >>> ${data.createdAt}');
      setState(() {
        name = data.name;
        email = data.email;
      });
      return data;
    } else {
      showSnackbar(context, AppColors.secondaryRedColor, 'ERROR getting user');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
     
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        elevation: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  'https://picsum.photos/250?image=9',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),  
              ),
            ),
            const SizedBox(height: 20),
             Text('Welcome to home page!!!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(
                'Name:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(email,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.greenColor,
        onPressed: () async {
          final authRepository = Authentication();
          final data = await authRepository.logout('email@gmail.com');
          if (data != null) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SignInPage(),
            ));

            showSnackbar(
                context, AppColors.greenColor, 'logOut successfully!!');
            print('sign up Email >>> ${data.email}');
            print('sign up id >>> ${data.id}');
            print('sign up created at >>> ${data.createdAt}');
          } else {
            showSnackbar(
                context, AppColors.secondaryRedColor, 'ERROR logging out');
          }
        },
        tooltip: 'log out',
        child: const Icon(Icons.logout_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
