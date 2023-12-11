import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/professor/create_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/professor/manage_submitted_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/student/accept_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/student/submit_or_forfeit_quest_modal.dart';

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
  String message = "Hello World!";
  // Quest dummyQuest =
  // Create an instance of the UserProvider
  final UserProvider userProvider = UserProvider();
  // Create an instance of the QuestProvider
  final QuestProvider questProvider = QuestProvider();

  // Initialize the text editing controllers
  final TextEditingController textEditingController1 = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: textEditingController1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Input 1',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: textEditingController2,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Input 2',
                  ),
                ),
                // ... other widgets
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: handleUserCreation,
                  child: const Text('Create User'),
                ),
                ElevatedButton(
                  onPressed: () => showSubmitOrForfeitQuestModal(context),
                  child: const Text('Submit or Forfeit Quest'),
                ),
                ElevatedButton(
                  onPressed: () => showCreateQuestModal(
                      context, "0xProfessor______01______"),
                  child: const Text('Create Quest'),
                ),
                ElevatedButton(
                  onPressed: () => showAcceptQuestModal(
                      context: context,
                      walletAddress: "0xStudent___01___",
                      questId: "657743cd4b16ec5e0204a9e0",
                      quest: questProvider.currentQuest!),
                  child: const Text('Accept Quest'),
                ),
                ElevatedButton(
                  onPressed: () => showQuestManagerModal(
                      context: context,
                      walletAddress: "0xStudent___01___",
                      questId: "657743cd4b16ec5e0204a9e0",
                      quest: questProvider.currentQuest!),
                  child: const Text('Download Quest PDF'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.dispose();
  }

  void handleUserCreation() async {
    try {
      // Assuming you want to use the values from the text fields to create the user
      String address =
          textEditingController1.text; // Example: use text from text field
      String role = textEditingController2
          .text; // Example: use text from another text field

      // Validate inputs here if necessary
      if (address.isEmpty || role.isEmpty) {
        throw Exception("Address and role cannot be empty");
      }

      if (role != "student" && role != "professor") {
        throw Exception("Role must be either student or professor");
      }

      print("Creating user with address: $address");
      print("Creating user with role: $role");

      // Call createUser from userProvider
      await userProvider.createUser(address, role);

      // Update the UI after the user is created
      if (userProvider.user != null) {
        setState(() {
          message = "The new User ID: ${userProvider.user!.userId}";
        });
      } else {
        // Handle the case where the user is not created
        setState(() {
          message = "User creation failed";
        });
      }
    } catch (error) {
      // Handle any errors here
      setState(() {
        message = "Error: ${error.toString()}";
      });
    }
  }
}
