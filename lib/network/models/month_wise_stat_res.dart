import 'package:hrmax/network/models/month_stat.dart';

class MonthWiseStatResponse {
  MonthStat january;
  MonthStat february;
  MonthStat march;
  MonthStat april;
  MonthStat may;
  MonthStat june;
  MonthStat july;
  MonthStat august;
  MonthStat september;
  MonthStat october;
  MonthStat november;
  MonthStat december;

  MonthWiseStatResponse.fromJsonMap(Map<String, dynamic> map)
      : january = MonthStat.fromJsonMap(map["january"]),
        february = MonthStat.fromJsonMap(map["february"]),
        march = MonthStat.fromJsonMap(map["march"]),
        april = MonthStat.fromJsonMap(map["april"]),
        may = MonthStat.fromJsonMap(map["may"]),
        june = MonthStat.fromJsonMap(map["june"]),
        july = MonthStat.fromJsonMap(map["july"]),
        august = MonthStat.fromJsonMap(map["august"]),
        september = MonthStat.fromJsonMap(map["september"]),
        october = MonthStat.fromJsonMap(map["october"]),
        november = MonthStat.fromJsonMap(map["november"]),
        december = MonthStat.fromJsonMap(map["december"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['january'] = january == null ? null : january.toJson();
    data['february'] = february == null ? null : february.toJson();
    data['march'] = march == null ? null : march.toJson();
    data['april'] = april == null ? null : april.toJson();
    data['may'] = may == null ? null : may.toJson();
    data['june'] = june == null ? null : june.toJson();
    data['july'] = july == null ? null : july.toJson();
    data['august'] = august == null ? null : august.toJson();
    data['september'] = september == null ? null : september.toJson();
    data['october'] = october == null ? null : october.toJson();
    data['november'] = november == null ? null : november.toJson();
    data['december'] = december == null ? null : december.toJson();
    return data;
  }
}
