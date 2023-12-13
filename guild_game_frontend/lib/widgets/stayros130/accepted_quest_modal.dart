import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';

class AcceptedQuestModal extends StatelessWidget {
  final String title;
  final String skills;
  final int xp;
  final String description;

  const AcceptedQuestModal({
    super.key,
    required this.title,
    required this.skills,
    required this.xp,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: title,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.9, // 90% of screen height
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(title,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Required Skills: $skills'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('XP: $xp'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Description: $description'),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
