class Timesalate {
  String? date;
  String? fajr;
  String? sunrise;
  String? Dhuhr;
  String? Asr;
  String? Sunset;
  String? Maghrib;
  String? Isha;
  String? Imsak;
  String? Midnight;
  String? Firstthird;
  String? Lastthird;

  Timesalate(
      {this.date,
      this.fajr,
      this.sunrise,
      this.Dhuhr,
      this.Asr,
      this.Sunset,
      this.Maghrib,
      this.Isha,
      this.Imsak,
      this.Midnight,
      this.Firstthird,
      this.Lastthird});
  Timesalate.fromJson(Map<String, dynamic> map) {
    date = map['date'];
    fajr = map['timings']['Fajr'];
    sunrise = map['timings']['Sunrise'];
    Dhuhr = map['timings']['Dhuhr'];
    Asr = map['timings']['Asr'];
    Sunset = map['timings']['Sunset'];
    Maghrib = map['timings']['Maghrib'];
    Isha = map['timings']['Isha'];
    Imsak = map['timings']['Imsak'];
    Midnight = map['timings']['Midnight'];
    Firstthird = map['timings']['Firstthird'];
    Lastthird = map['timings']['Lastthird'];
  }
}
