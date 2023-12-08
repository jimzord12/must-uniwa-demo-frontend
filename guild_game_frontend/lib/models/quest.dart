class Quest {
  final int questId;
  final int xp;
  final String title;
  final DateTime creationDate;
  final List<DateTime> submissionDates;
  final int revisions;
  final List<String> requiredSkills;
  final int createdBy;
  final int assignedTo;
  final bool isDone;
  final DateTime? completedDate;
  final String? rejectedReason;
  final String? pdfFilename;

  Quest({
    required this.questId,
    required this.xp,
    required this.title,
    required this.creationDate,
    required this.submissionDates,
    required this.revisions,
    required this.requiredSkills,
    required this.createdBy,
    required this.assignedTo,
    required this.isDone,
    this.completedDate,
    this.rejectedReason,
    this.pdfFilename,
  });

  // From JSON
  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      questId: json['questId'],
      xp: json['xp'] ?? 0,
      title: json['title'],
      creationDate: DateTime.parse(json['creationDate']),
      submissionDates: (json['submissionDate'] as List)
          .map((e) => DateTime.parse(e))
          .toList(),
      revisions: json['revisions'] ?? 0,
      requiredSkills: List<String>.from(json['requiredSkills'] ?? []),
      createdBy: json['createdBy'],
      assignedTo: json['assignedTo'],
      isDone: json['isDone'] ?? false,
      completedDate: json['completedDate'] != null
          ? DateTime.parse(json['completedDate'])
          : null,
      rejectedReason: json['rejectedReason'],
      pdfFilename: json['pdfFilename'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'questId': questId,
      'xp': xp,
      'title': title,
      'creationDate': creationDate.toIso8601String(),
      'submissionDate':
          submissionDates.map((e) => e.toIso8601String()).toList(),
      'revisions': revisions,
      'requiredSkills': requiredSkills,
      'createdBy': createdBy,
      'assignedTo': assignedTo,
      'isDone': isDone,
      'completedDate': completedDate?.toIso8601String(),
      'rejectedReason': rejectedReason,
      'pdfFilename': pdfFilename,
    };
  }
}
