class Receptes {
  int? idRecepte;
  int? idUsuari;
  String? createdAt;
  String? nomRecepte;
  String? preparacio;

  Receptes(
      {this.idRecepte,
      this.idUsuari,
      this.createdAt,
      this.nomRecepte,
      this.preparacio});

  Receptes.fromJson(Map<String, dynamic> json) {
    idRecepte = json['id'];
    idUsuari = json['FK_idUsuari'];
    createdAt = json['created_at'];
    nomRecepte = json['titol'];
    preparacio = json['preparacio'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = idRecepte;
    data['FK_idUsuari'] = idUsuari;
    data['created_at'] = createdAt;
    data['titol'] = nomRecepte;
    data['preparacio'] = preparacio;
    return data;
  }

  static List<Receptes> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Receptes.fromJson(e)).toList();
  }
}
