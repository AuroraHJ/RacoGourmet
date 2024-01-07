class Restaurants {
  int? id;
  int? userId;
  String? nom_rest;
  String? ciutat_rest;
  String? createdAt;

  Restaurants({this.id, this.userId, this.nom_rest, this.ciutat_rest, this.createdAt});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    nom_rest = json['nom_rest'];
    ciutat_rest = json['ciutat_rest'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['nom_rest'] = nom_rest;
    data['ciutat_rest'] = ciutat_rest;
    data['created_at'] = createdAt;
    return data;
  }

  static List<Restaurants> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Restaurants.fromJson(e)).toList();
  }
}
