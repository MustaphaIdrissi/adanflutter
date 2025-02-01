class Listquran {
  int? surah_number;
  int? verse_number;
  String? aya;
  Listquran(this.surah_number, this.verse_number, this.aya);

  Listquran.fromJson(Map<String, dynamic> map) {
    surah_number = map['surah_number'];
    verse_number = map['verse_number'];
    aya = map['text'];
  }
}



