class LearningCount {
  String totalPending;
  String totalLearning;
  String totalAttempted;
  String totalPassed;
  String totalAverage;

  LearningCount.fromJsonMap(Map<String, dynamic> map)
      : totalPending = map["totalPending"],
        totalLearning = map["totalLearning"],
        totalAttempted = map["totalAttempted"],
        totalPassed = map["totalPassed"],
        totalAverage = map["totalAverage"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPending'] = totalPending;
    data['totalLearning'] = totalLearning;
    data['totalAttempted'] = totalAttempted;
    data['totalPassed'] = totalPassed;
    data['totalAverage'] = totalAverage;
    return data;
  }
}
