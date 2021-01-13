class LearningTrackerRes {
  String learningFromDateTime;
  String learningToDateTime;
  int idELearningTracker;
  int idTrackerHistory;
  int idHRCourse;
  String courseName;
  String instruction;
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
  bool readingMaterialExist;
  bool enableGenerateCertificate;
  bool downloading = false;

  LearningTrackerRes.fromJsonMap(Map<String, dynamic> map)
      : learningFromDateTime = map["learningFromDateTime"],
        learningToDateTime = map["learningToDateTime"],
        idELearningTracker = map["idELearningTracker"],
        idTrackerHistory = map["idTrackerHistory"],
        idHRCourse = map["idHRCourse"],
        courseName = map["courseName"],
        instruction = map["instruction"],
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
        allowStartTraining = map["allowStartTraining"],
        readingMaterialExist = map["readingMaterialExist"],
        enableGenerateCertificate=map["enableGenerateCertificate"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['learningFromDateTime'] = learningFromDateTime;
    data['learningToDateTime'] = learningToDateTime;
    data['idELearningTracker'] = idELearningTracker;
    data['idTrackerHistory'] = idTrackerHistory;
    data['idHRCourse'] = idHRCourse;
    data['courseName'] = courseName;
    data['instruction'] = instruction;
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
    data['readingMaterialExist'] = readingMaterialExist;
    data['enableGenerateCertificate'] = enableGenerateCertificate;
    return data;
  }
}
