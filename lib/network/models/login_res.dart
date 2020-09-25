class LoginRes {
  int idUser;
  int idRole;
  Object gender;
  Object maritalStatus;
  String roleName;
  int idHRBranch;
  int idDepartment;
  int idCompany;
  String fullName;
  bool cidAccess;
  bool isTemporarySessionEnabled;
  bool isNewlyAded;
  bool isDepartmentHead;
  bool rememberMe;
  String userToken;
  String branch;
  String department;
  String functionalTitle;
  String corporateTitle;
  String email;
  String phone;

  LoginRes.fromJsonMap(Map<String, dynamic> map)
      : idUser = map["idUser"],
        idRole = map["idRole"],
        gender = map["gender"],
        maritalStatus = map["maritalStatus"],
        roleName = map["roleName"],
        idHRBranch = map["idHRBranch"],
        idDepartment = map["idDepartment"],
        idCompany = map["idCompany"],
        fullName = map["fullName"],
        cidAccess = map["cidAccess"],
        isTemporarySessionEnabled = map["isTemporarySessionEnabled"],
        isNewlyAded = map["isNewlyAded"],
        isDepartmentHead = map["isDepartmentHead"],
        rememberMe = map["rememberMe"],
        userToken = map["userToken"],
        branch = map["branch"],
        department = map["department"],
        functionalTitle = map["functionalTitle"],
        corporateTitle = map["corporateTitle"],
        email = map["emailID"],
        phone = map["mobileNumber"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = idUser;
    data['idRole'] = idRole;
    data['gender'] = gender;
    data['maritalStatus'] = maritalStatus;
    data['roleName'] = roleName;
    data['idHRBranch'] = idHRBranch;
    data['idDepartment'] = idDepartment;
    data['idCompany'] = idCompany;
    data['fullName'] = fullName;
    data['cidAccess'] = cidAccess;
    data['isTemporarySessionEnabled'] = isTemporarySessionEnabled;
    data['isNewlyAded'] = isNewlyAded;
    data['isDepartmentHead'] = isDepartmentHead;
    data['rememberMe'] = rememberMe;
    data['userToken'] = userToken;
    data['branch'] = branch;
    data['department'] = department;
    data['functionalTitle'] = functionalTitle;
    data['corporateTitle'] = corporateTitle;
    data['emailID'] = email;
    data['mobileNumber'] = phone;
    return data;
  }
}
