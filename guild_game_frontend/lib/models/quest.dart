class Quest {
  final String? questId;
  final int xp;
  final String desc;
  final String title;
  final DateTime creationDate;
  final List<DateTime> submissionDates;
  final int revisions;
  final List<String> requiredSkills;
  final String createdBy;
  final String? assignedTo;
  final bool isDone;
  final DateTime? completedDate;
  final String? rejectedReason;
  final String? pdfFilename;

  Quest({
    required this.questId,
    required this.xp,
    required this.desc,
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

  // New Quest
  Quest.newQuest({
    required this.requiredSkills,
    required this.xp,
    required this.desc,
    required this.title,
    required this.createdBy,
  })  : questId = null,
        creationDate = DateTime.now(),
        submissionDates = [],
        revisions = 0,
        assignedTo = null, // You might want to assign later
        isDone = false,
        completedDate = null,
        rejectedReason = null,
        pdfFilename = null;

  // From JSON
  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      questId: json['questId'],
      xp: json['xp'] ?? 0,
      desc: json['desc'],
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
