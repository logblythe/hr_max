
class Jokes {

  List<String> categories;
  String created_at;
  String icon_url;
  String id;
  String updated_at;
  String url;
  String value;

	Jokes.fromJson(Map<String, dynamic> map):
		categories = List<String>.from(map["categories"]),
		created_at = map["created_at"],
		icon_url = map["icon_url"],
		id = map["id"],
		updated_at = map["updated_at"],
		url = map["url"],
		value = map["value"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['categories'] = categories;
		data['created_at'] = created_at;
		data['icon_url'] = icon_url;
		data['id'] = id;
		data['updated_at'] = updated_at;
		data['url'] = url;
		data['value'] = value;
		return data;
	}
}
