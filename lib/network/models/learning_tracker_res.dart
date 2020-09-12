class LearningTrackerRes {
  String learningFromDateTime;
  String learningToDateTime;
  int idELearningTracker;
  int idHRCourse;
  String courseName;
  String courseCode;
  int idELearningSetting;
  String assignedOn;
  String completedOn;
  int enableTraining;
  String status;
  double obtainedMark;
  double passMark;
  bool enableRepeat;
  bool isAttended;
  int attemptCount;
  int allowStartTraining;

  LearningTrackerRes.fromJsonMap(Map<String, dynamic> map)
      : learningFromDateTime = map["learningFromDateTime"],
        learningToDateTime = map["learningToDateTime"],
        idELearningTracker = map["idELearningTracker"],
        idHRCourse = map["idHRCourse"],
        courseName = map["courseName"],
        courseCode = map["courseCode"],
        idELearningSetting = map["idELearningSetting"],
        assignedOn = map["assignedOn"],
        completedOn = map["completedOn"],
        enableTraining = map["enableTraining"],
        status = map["status"],
        obtainedMark = map["obtainedMark"],
        passMark = map["passMark"],
        enableRepeat = map["enableRepeat"],
        isAttended = map["isAttended"],
        attemptCount = map["attemptCount"],
        allowStartTraining = map["allowStartTraining"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['learningFromDateTime'] = learningFromDateTime;
    data['learningToDateTime'] = learningToDateTime;
    data['idELearningTracker'] = idELearningTracker;
    data['idHRCourse'] = idHRCourse;
    data['courseName'] = courseName;
    data['courseCode'] = courseCode;
    data['idELearningSetting'] = idELearningSetting;
    data['assignedOn'] = assignedOn;
    data['completedOn'] = completedOn;
    data['enableTraining'] = enableTraining;
    data['status'] = status;
    data['obtainedMark'] = obtainedMark;
    data['passMark'] = passMark;
    data['enableRepeat'] = enableRepeat;
    data['isAttended'] = isAttended;
    data['attemptCount'] = attemptCount;
    data['allowStartTraining'] = allowStartTraining;
    return data;
  }
}
