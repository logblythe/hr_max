
class ChuchCategories {
	List<String> categories;

	ChuchCategories.fromJson(Map<String, dynamic> map){
		categories = List<String>.from(map["categories"]);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['categories'] = categories;
		return data;
	}
}
