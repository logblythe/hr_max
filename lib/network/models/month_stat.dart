class MonthStat {
  int assigned;
  int attempted;
  int passed;

  MonthStat.fromJsonMap(Map<String, dynamic> map)
      : assigned = map["assigned"],
        attempted = map["attempted"],
        passed = map["passed"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assigned'] = assigned;
    data['attempted'] = attempted;
    data['passed'] = passed;
    return data;
  }
}
