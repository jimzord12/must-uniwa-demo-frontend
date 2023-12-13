import 'package:flutter/material.dart';
import 'package:micro_guild_game/screens/loaded_screen.dart';
import 'package:micro_guild_game/widgets/stayros130/custom_button.dart';
import 'package:micro_guild_game/widgets/stayros130/ranks.dart';

class PortfolioScreen extends StatelessWidget {
  PortfolioScreen({super.key});

  final int dummyXp = 420;
  final int dummyQuestsCompleted = 22;
  String skillColumn1 = '';
  String skillColumn2 = '';
  List<String> dummySkills = [
    'Skill #1', 'Skill #2', 'Skill #3', 'Skill #4', 'Skill #5', 'Skill #6'
  ];
  
  @override
  Widget build(BuildContext context) {
    // dummySkills1 += '\ntest2';
    // print(dummySkills1);
    for (var i = 0; i < dummySkills.length; i++) {
      if (i < dummySkills.length / 2) {
        skillColumn1 += '${dummySkills[i]}\n';
      } else {
        skillColumn2 += '${dummySkills[i]}\n';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'RANK: ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      TextSpan(
                          text: Ranks().getRank(dummyXp).toString().split('.').last,
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                //title: Text('Total XP: ${dummyXp.toString()}'),
                title: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Total XP: ',
                        style: TextStyle(color: Colors.white, fontSize: 18,),
                      ),
                      TextSpan(
                          text: dummyXp.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Quest completed in total: ',
                        style: TextStyle(color: Colors.white, fontSize: 18,),
                      ),
                      TextSpan(
                          text: dummyQuestsCompleted.toString(),
                          style: const TextStyle(color: Colors.white,  fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                title: const Text('Available Skills:'),
                subtitle: Row(
                  children: [
                    Column(
                        children: [
                          Text(skillColumn1),
                        ]),
                    Expanded(
                        child: Column(
                      children: [
                        Text(skillColumn2),
                      ],
                    ))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'All the completed Quests:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  CustomButton(
                      buttonText: 'Quest Example #1',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoadedScreen()));
                      }),
                  SizedBox(height: 20),
                  CustomButton(
                      buttonText: 'Quest Example #2',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoadedScreen()));
                      }),
                  SizedBox(height: 20),
                  CustomButton(
                      buttonText: 'Quest Example #3',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoadedScreen()));
                      }),
                  SizedBox(height: 20),
                  CustomButton(
                      buttonText: 'Quest Example #4',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoadedScreen()));
                      }),
                  SizedBox(height: 20),
                  CustomButton(
                      buttonText: 'Quest Example #5',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoadedScreen()));
                      }),
                  SizedBox(height: 20),
                  CustomButton(
                      buttonText: 'Quest Example #6',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoadedScreen()));
                      }),
                  SizedBox(height: 20),
                  CustomButton(
                      buttonText: 'Quest Example #7',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoadedScreen()));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
