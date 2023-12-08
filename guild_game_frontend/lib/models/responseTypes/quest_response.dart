class QuestResponse {
  final int questId;
  final int xp;
  final String title;
  final DateTime creationDate;
  final List<DateTime> submissionDates;
  final int revisions;
  final List<String> requiredSkills;
  final int createdBy;
  final bool isDone;
  final DateTime? completedDate;
  final String? rejectedReason;
  final String id;
  final int v;

  QuestResponse({
    required this.questId,
    required this.xp,
    required this.title,
    required this.creationDate,
    required this.submissionDates,
    required this.revisions,
    required this.requiredSkills,
    required this.createdBy,
    required this.isDone,
    this.completedDate,
    this.rejectedReason,
    required this.id,
    required this.v,
  });

  // From JSON
  factory QuestResponse.fromJson(Map<String, dynamic> json) {
    return QuestResponse(
      questId: json['questId'],
      xp: json['xp'],
      title: json['title'],
      creationDate: DateTime.parse(json['creationDate']),
      submissionDates: (json['submissionDate'] as List<dynamic>)
          .map((e) => DateTime.parse(e.toString()))
          .toList(),
      revisions: json['revisions'],
      requiredSkills: List<String>.from(json['requiredSkills']),
      createdBy: json['createdBy'],
      isDone: json['isDone'],
      completedDate: json['completedDate'] != null
          ? DateTime.parse(json['completedDate'])
          : null,
      rejectedReason: json['rejectedReason'],
      id: json['_id'],
      v: json['__v'],
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
      'isDone': isDone,
      'completedDate': completedDate?.toIso8601String(),
      'rejectedReason': rejectedReason,
      'id': id,
      '_v': v,
    };
  }
}
