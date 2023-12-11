import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/quest_desc.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/quest_title.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/skills_and_exp_section.dart';

void showQuestViewerModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled:
        true, // Allows the modal to take up more than half the screen
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900], // Dark backdrop as per your description
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            padding: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              // Make the content scrollable
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: const QuestTitle(
                        title: 'Quest Title',
                        content: 'Dragon Slayer',
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  const SkillsAndEXP(
                      exp: 420,
                      skills:
                          'Swordsmanship, Archery, Magic, Stealth, Alchemy, Smithing, Enchanting, Speechcraft, Lockpicking, Pickpocketing, Sneaking, Acrobatics, Athletics, Endurance, Restoration, Destruction, Conjuration, Altera'),
                  const SizedBox(
                    height: 16,
                  ),
                  const QuestDescription(
                      title: 'Description',
                      textAlign: TextAlign.justify,
                      content:
                          "In the ancient and mystical land of Eldoria, a legendary quest awaits the bravest of souls. Known as \"The Quest for the Celestial Crystal,\" it is a journey fraught with peril, mystery, and the promise of eternal glory. The crystal, believed to be a shard of the fallen star of Eldar, holds immense power and is said to grant its possessor untold strength and wisdom. It lies hidden in the treacherous depths of the Dark Forest, guarded by the enigmatic Forest Spirit—a creature of both beauty and terror, whose riddles have baffled many a brave heart. Along the way, adventurers must traverse through the treacherous paths of the Whispering Woods, cross the tumultuous waters of the River of Sorrow, and face the trials set by the ancient Order of the Starlit Knights, who test the purity of one's heart and the strength of one's resolve. Only those of true valor and noble spirit can hope to claim the Celestial Crystal and emerge as legends in the annals of Eldoria. The quest is a beacon for heroes far and wide, calling to those who dare to dream and are bold enough to embark on a journey that promises to be as rewarding as it is dangerous."),

                  const SizedBox(
                    height: 24,
                  ),

                  // Removed the Row for single child
                  ActionsSection(
                    buttons: [
                      ActionSectionButton(
                        text: 'Upload',
                        onPressed: () {},
                        icon: Icons.upload_file,
                      ),
                      ActionSectionButton(
                        text: 'Forfeit',
                        onPressed: () {
                          // Handle forfeit
                        },
                        icon: Icons.cancel_outlined,
                        backgroundColor: Colors.red.shade400,
                        textColor: Colors.white,
                      ),
                      // Add more buttons as needed
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
