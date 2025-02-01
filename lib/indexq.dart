

class Indexqu {
  int? Idqurna;
  String? Name;
  String? typequran;
 int? nbayat;






  Indexqu(this.Idqurna, this.Name, this.typequran,this.nbayat);

  Indexqu.fromJson(Map<String, dynamic> map) {
    Idqurna = map['Idsura'];
    Name = map['Namesurah'];
    typequran = map['Type'];
     nbayat = map['Countaya'];
  }
}
