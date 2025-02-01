import 'package:adan/indexq.dart';
import 'package:adan/quran.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:adan/Theme/colorapp.dart' as myColorApp;

class Indexquran extends StatefulWidget {
  const Indexquran({Key? key}) : super(key: key);

  @override
  State<Indexquran> createState() => _IndexquranState();
}

class _IndexquranState extends State<Indexquran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: myColorApp.ColorApp().background2,
        child: FutureBuilder<List<Indexqu>>(
          future: readJsonDataQuranf(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              var items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var verses = snapshot.data!;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: double.infinity, // Set width to 100%
                          height: 60.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: myColorApp.ColorApp()
                                  .background, // Set background color
                              // onPrimary: myColorApp.ColorApp.Textcolor, // Set text color
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Quran(
                                    surahNumber: verses[index].Idqurna!,
                                    surahName: verses[index].Name!,
                                    surahcontaya: verses[index].nbayat!,
                                    surahtype: verses[index].typequran!,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              '   ${verses[index].Name}',
                              style: TextStyle(
                                fontFamily: 'font2',
                                fontSize: 25,
                                backgroundColor:
                                    myColorApp.ColorApp().background,
                                color: myColorApp.ColorApp().Textcolor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Indexqu>> readJsonDataQuranf() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsondata/indqurankarim.json');
    final List<dynamic> dataList = json.decode(jsondata);

    // Map the dataList to Indexqu objects
    final List<Indexqu> verseList =
        dataList.map((e) => Indexqu.fromJson(e)).toList();

    return verseList;
  }
}
