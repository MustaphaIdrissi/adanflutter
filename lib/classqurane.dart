class ClassQurane {
  int? Idqurna;
  String? Name;
  String? typequran;
  int? nbayat;
  int? nbpage;

  ClassQurane(this.Idqurna, this.Name, this.typequran, this.nbayat, this.nbpage);

  ClassQurane.fromJson(Map<String, dynamic> map) {
    Idqurna = map['Idsura'];
    Name = map['Namesurah'];
    typequran = map['Type'];
    nbayat = map['Countaya'];
    nbpage = map['Page'];
  }
}
