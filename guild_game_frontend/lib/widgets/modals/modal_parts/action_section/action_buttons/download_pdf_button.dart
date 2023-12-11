import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/utils/pdf_convert_and_open.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class DownloadPdfButton extends StatelessWidget {
  final QuestProvider questProvider = QuestProvider();

  DownloadPdfButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: "Download PDF",
      icon: Icons.download,
      backgroundColor: const Color.fromARGB(255, 187, 239, 242),
      onPressed: () => _downloadFile(context),
    );
  }

  void _downloadFile(BuildContext context) async {
    final pdfName = questProvider.currentQuest!.pdfFilename!;
    final pdfBase64content = await questProvider.fetchPdfContent(pdfName);
    await convertAndOpenPdf(context, pdfBase64content, pdfName);
  }
}
