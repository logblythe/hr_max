class LearningCount {
  double TotalPending;
  double TotalLearning;
  double TotalAttempted;
  double TotalPassed;
  double TotalAverage;

  LearningCount.fromJsonMap(Map<String, dynamic> map)
      : TotalPending = map["TotalPending"],
        TotalLearning = map["TotalLearning"],
        TotalAttempted = map["TotalAttempted"],
        TotalPassed = map["TotalPassed"],
        TotalAverage = map["TotalAverage"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalPending'] = TotalPending;
    data['TotalLearning'] = TotalLearning;
    data['TotalAttempted'] = TotalAttempted;
    data['TotalPassed'] = TotalPassed;
    data['TotalAverage'] = TotalAverage;
    return data;
  }
}
