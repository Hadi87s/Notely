import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController email;
  late final TextEditingController password;
  // late means that this variable does't have a value right now, but it will have one before it gets used.

//the initState() and dispose() are only for stateful widgets only
  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController(); // this is like a constructor
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose(); // this is like a destructor.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello Bro"),
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder(
          future: FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email.text, password: password.text),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Your email"),
                    ), // this is how we assign our controller to the text field given.
                    TextField(
                      controller: password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(hintText: "Your password"),
                    ), // this is how we assign our controller to the text field given.
                    TextButton(
                        onPressed: () async {
                          Firebase.initializeApp(
                              options: DefaultFirebaseOptions.currentPlatform);

                          // created an instance of firebase and give it the username and the password written by the user (the value we got from the textControllers)
                          // and since this FirebaseAuth returns a future we need to await of it for it to really perform the work we want
                        },
                        child: const Text('Register')),
                  ],
                );
              default:
                return const Text("Loading...");
            }
          },
        ));
  }
}
