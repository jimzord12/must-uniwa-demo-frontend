class Quest {
  final String? id;
  final int? questId;
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
    required this.id,
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
  })  : id = null,
        questId = null,
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
      id: json['_id'] as String? ?? '',
      questId: json['questId'] as int? ?? 0,
      xp: json['xp'] as int? ?? 0,
      desc: json['desc'] as String? ?? '',
      title: json['title'] as String? ?? '',
      creationDate: DateTime.parse(
          json['creationDate'] as String? ?? DateTime.now().toString()),
      submissionDates:
          (json['submissionDates'] as List<dynamic>? ?? []).cast<DateTime>(),
      revisions: json['revisions'] as int? ?? 0,
      requiredSkills:
          (json['requiredSkills'] as List<dynamic>? ?? []).cast<String>(),
      createdBy: json['createdBy'] as String? ?? '',
      assignedTo: json['assignedTo'] as String? ?? '',
      isDone: json['isDone'] as bool? ?? false,
      pdfFilename: json['pdfFilename'] as String? ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
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
