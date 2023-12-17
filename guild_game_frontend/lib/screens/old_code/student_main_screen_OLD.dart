// import 'package:flutter/material.dart';
// import 'package:guild_game_frontend/models/ranks.dart';
// import 'package:guild_game_frontend/providers/user_provider.dart';
// import 'package:guild_game_frontend/screens/current_quests_screen.dart';
// import 'package:guild_game_frontend/screens/guild_board_screen.dart';
// import 'package:guild_game_frontend/screens/pending_quests_screen.dart';
// import 'package:guild_game_frontend/screens/portfolio_screen.dart';
// import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
// import 'package:provider/provider.dart';

// class StudentMainScreen extends StatelessWidget {
//   StudentMainScreen({super.key});

//   Color notificationColor = Colors.red;

//   @override
//   build(BuildContext context) {
//     // final questProvider = Provider.of<QuestProvider>(context, listen: false);
//     final UserProvider userProvider =
//         Provider.of<UserProvider>(context, listen: true);

//     if (userProvider.user!.pendingReviewQuests.isEmpty) {
//       notificationColor = Colors.transparent;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//             'Rank: ${Ranks().getRank(userProvider.user!.xp).toString().split('.').last}'), // Get rank from xp
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomButton(
//               buttonText: 'Current Quests',
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const CurrentQuestsScreen()));
//               },
//             ),
//             SizedBox(
//                 height:
//                     MediaQuery.of(context).size.height / 20), // Add some space
//             Stack(
//               children: [
//                 CustomButton(
//                   buttonText: 'Pending Quests',
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const PendingQuestsScreen()));
//                   },
//                 ),
//                 Positioned(
//                   right: 2,
//                   top: 2,
//                   child: Container(
//                     padding: const EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                       color: notificationColor,
//                       borderRadius: BorderRadius.circular(32),
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 38,
//                       minHeight: 38,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//                 height:
//                     MediaQuery.of(context).size.height / 20), // Add some space
//             CustomButton(
//               buttonText: 'Available Quests',
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const GuildBoardScreen()));
//               },
//             ),
//             SizedBox(
//                 height:
//                     MediaQuery.of(context).size.height / 20), // Add some space
//             CustomButton(
//               buttonText: 'History of Quests',
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => PortfolioScreen()));
//               },
//             ),
//             SizedBox(
//                 height:
//                     MediaQuery.of(context).size.height / 20), // Add some space
//           ],
//         ),
//       ),
//     );
//   }
// }
