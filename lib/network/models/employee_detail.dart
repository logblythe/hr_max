
class EmployeeDetail {

  String loginId;
  String name;
  String department;
  String branch;
  String imagePath;
  Object pdfUrl;
  Object mediaUrl;
  Object mediaList;
  Object pdfList;

	EmployeeDetail.fromJsonMap(Map<String, dynamic> map): 
		loginId = map["loginId"],
		name = map["name"],
		department = map["department"],
		branch = map["branch"],
		imagePath = map["imagePath"],
		pdfUrl = map["pdfUrl"],
		mediaUrl = map["mediaUrl"],
		mediaList = map["mediaList"],
		pdfList = map["pdfList"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['loginId'] = loginId;
		data['name'] = name;
		data['department'] = department;
		data['branch'] = branch;
		data['imagePath'] = imagePath;
		data['pdfUrl'] = pdfUrl;
		data['mediaUrl'] = mediaUrl;
		data['mediaList'] = mediaList;
		data['pdfList'] = pdfList;
		return data;
	}
}
