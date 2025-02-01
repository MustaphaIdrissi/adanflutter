import 'package:adan/timedalate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:adan/menuleft.dart';
import 'package:adan/Theme/colorapp.dart' as myColorApp;

class PrayerTimesScreen extends StatefulWidget {
  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  Row afiche(String name, String timed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          '${name} : ',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: myColorApp.ColorApp().Textcolor,
          ),
        ),
        Text(
          '${timed}',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: myColorApp.ColorApp().Textcolor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuLeft(),
        body: Container(
          color: myColorApp.ColorApp().background2,
          child: FutureBuilder(
            future: ReadJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<Timesalate>;
                return ListView.builder(
                    // ignore: unnecessary_null_comparison
                    itemCount: items == null ? 0 : items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: 600,
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Card(
                                  color: myColorApp.ColorApp().background,
                                  elevation: 5,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(bottom: 12),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  color: myColorApp.ColorApp()
                                                      .background,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'اوقات الصلاة اليوم :${items[index].date.toString()}',
                                                        style: TextStyle(
                                                          fontSize: 26.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: myColorApp.ColorApp()
                                                      .Textcolor,
                                                ),
                                                afiche(
                                                    'الامساك',
                                                    items[index]
                                                        .Imsak
                                                        .toString()),
                                                afiche(
                                                    'الفجر',
                                                    items[index]
                                                        .fajr
                                                        .toString()),
                                                afiche(
                                                    'الشروق',
                                                    items[index]
                                                        .sunrise
                                                        .toString()),
                                                afiche(
                                                    'الظهر',
                                                    items[index]
                                                        .Dhuhr
                                                        .toString()),
                                                afiche(
                                                    'العصر',
                                                    items[index]
                                                        .Asr
                                                        .toString()),
                                                afiche(
                                                    'المغرب',
                                                    items[index]
                                                        .Maghrib
                                                        .toString()),
                                                afiche(
                                                    'العشاء',
                                                    items[index]
                                                        .Isha
                                                        .toString()),

                                                // Add more rows for other prayer timings if needed
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }

  Future<List<Timesalate>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsondata/prayer_times.json');
    final List<dynamic> dataList = json.decode(jsondata);

    DateTime yourDate =
        DateTime.now(); // Replace with your actual DateTime object
    String formattedDate = DateFormat('dd-MM-yyyy').format(yourDate);

    // Filter items with 'id' equal to 1
    final filteredList =
        dataList.where((item) => item['date'] == formattedDate).toList();

    // Print the filtered list

    return filteredList.map((e) => Timesalate.fromJson(e)).toList();
  }
}
