import 'package:another_flutter_app/models/user_model.dart';
import 'package:another_flutter_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:guild_game_frontend/guild_game_module_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: "Maria's Main Flutter App"),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          brightness: Brightness.dark,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  AnotherAppUser? currentUser;
  AnotherAppUser student_01 = AnotherAppUser(
      privateKey:
          "2e0a0ee77631554530414c4a68385fd8328c837a1d5986f1e409f42d58a1a2f1",
      role: 'student',
      name: 'Student 01'); // Metamask PC: Sepolia Deployer

  AnotherAppUser student_02 = AnotherAppUser(
      privateKey:
          "9ca15b4b9dd7edebefa71fc3bc4c2ec3bde908a9de3bf057495b0c0ceffda798",
      role: 'student',
      name: 'Student 02'); // Metamask PC: DEAD_Genera-Manager

  AnotherAppUser professor_01 = AnotherAppUser(
      privateKey:
          "0b92f463b02f418512302a166bd4dd9f8724dc92c0083a7f7cae288e75227b50",
      role: 'professor',
      name: 'Professor 01'); // Metamask PC: DEAD_Genera-simple

  AnotherAppUser professor_02 = AnotherAppUser(
      privateKey:
          "df7ea54eb4e3f7664cc107e5643be49a26601f93362acd708e909dbfe5d941ae",
      role: 'professor',
      name: 'Professor 02'); // Metamask PC: Oracle-Acc

  void _selectUser(AnotherAppUser selectedUser) {
    setState(() {
      print(" -> Selected User: ${selectedUser.name} <-");
      currentUser = selectedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(" === Rendering main.dart ===");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (currentUser == null)
              const Text(
                'Please Select a User to before entering the Guild Game: ',
                style: TextStyle(fontSize: 20),
              )
            else
              Text(
                'You are logged in as: ${currentUser!.name}',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 20),
            CustomButton(
                buttonText: "Student 01",
                buttonColor: Colors.amber.shade800,
                onPressed: () {
                  _selectUser(student_01);
                }),
            const SizedBox(height: 20),
            CustomButton(
                buttonText: "Student 02",
                buttonColor: Colors.amber.shade800,
                onPressed: () {
                  _selectUser(student_02);
                }),
            const SizedBox(height: 20),
            CustomButton(
                buttonText: "Professor 01",
                onPressed: () {
                  _selectUser(professor_01);
                }),
            const SizedBox(height: 20),
            CustomButton(
                buttonText: "Professor 02",
                onPressed: () {
                  _selectUser(professor_02);
                }),
            const SizedBox(height: 56),
            CustomButton(
                buttonText: "Enter Guild Game",
                buttonColor: Colors.deepPurple,
                isActive: currentUser != null,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuildGameModuleWidget(
                        key: UniqueKey(),
                        role: currentUser!.role,
                        privKey: currentUser!.privateKey,
                        // role: 'professor',
                        // privKey:
                        //     "2e0a0ee77631554530414c4a68385fd8328c837a1d5986f1e409f42d58a1a2f1",
                        // role: 'student',
                        // privKey:
                        //     "9ca15b4b9dd7edebefa71fc3bc4c2ec3bde908a9de3bf057495b0c0ceffda798",
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
