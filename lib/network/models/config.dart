
class Config {

  int id;
  int duration;
  int timePerQuestion;
  int totalQuestion;
  double markPerQuestion;
  double negativeMarkingScore;
  double minPassMark;
  bool negativeMarking;
  bool allowLast;
  bool allowFirst;
  bool allowBack;
  bool suffleQuestion;
  bool allowReview;
  bool allowSubmit;
  bool autoMove;
  bool autoMoveHolder;
  bool isAnswerMandatory;
  bool enableAutoClose;
  bool showResult;
  bool enableGenerateCertificate;
  bool showCorrectAnswer;

	Config.fromJsonMap(Map<String, dynamic> map): 
		id = map["Id"],
		duration = map["duration"],
		timePerQuestion = map["timePerQuestion"],
		totalQuestion = map["TotalQuestion"],
		markPerQuestion = map["MarkPerQuestion"],
		negativeMarkingScore = map["NegativeMarkingScore"],
		minPassMark = map["MinPassMark"],
		negativeMarking = map["NegativeMarking"],
		allowLast = map["allowLast"],
		allowFirst = map["allowFirst"],
		allowBack = map["allowBack"],
		suffleQuestion = map["SuffleQuestion"],
		allowReview = map["allowReview"],
		allowSubmit = map["allowSubmit"],
		autoMove = map["autoMove"],
		autoMoveHolder = map["autoMoveHolder"],
		isAnswerMandatory = map["isAnswerMandatory"],
		enableAutoClose = map["enableAutoClose"],
		showResult = map["showResult"],
		enableGenerateCertificate = map["enableGenerateCertificate"],
		showCorrectAnswer = map["showCorrectAnswer"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Id'] = id;
		data['duration'] = duration;
		data['timePerQuestion'] = timePerQuestion;
		data['TotalQuestion'] = totalQuestion;
		data['MarkPerQuestion'] = markPerQuestion;
		data['NegativeMarkingScore'] = negativeMarkingScore;
		data['MinPassMark'] = minPassMark;
		data['NegativeMarking'] = negativeMarking;
		data['allowLast'] = allowLast;
		data['allowFirst'] = allowFirst;
		data['allowBack'] = allowBack;
		data['SuffleQuestion'] = suffleQuestion;
		data['allowReview'] = allowReview;
		data['allowSubmit'] = allowSubmit;
		data['autoMove'] = autoMove;
		data['autoMoveHolder'] = autoMoveHolder;
		data['isAnswerMandatory'] = isAnswerMandatory;
		data['enableAutoClose'] = enableAutoClose;
		data['showResult'] = showResult;
		data['enableGenerateCertificate'] = enableGenerateCertificate;
		data['showCorrectAnswer'] = showCorrectAnswer;
		return data;
	}
}
