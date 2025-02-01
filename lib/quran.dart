import 'package:adan/menuleft.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:adan/listquran.dart';
import 'package:adan/Theme/colorapp.dart' as myColorApp;

class Quran extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  final int surahcontaya;
  final String surahtype;

  const Quran({
    Key? key,
    required this.surahNumber,
    required this.surahName,
    required this.surahcontaya,
    required this.surahtype,
  }) : super(key: key);

  @override
  State<Quran> createState() => _QuranState();
}

class _QuranState extends State<Quran> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.surahName),
          backgroundColor: myColorApp.ColorApp().background,
        ),
        body: Container(
          color: myColorApp.ColorApp().background2,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, top: 12.0, right: 0.0, bottom: 0.0),
            child: FutureBuilder<List<Listquran>>(
              future: readJsonDataQuran(widget.surahNumber),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else if (snapshot.hasData) {
                  var items = snapshot.data!;
                  return OrientationBuilder(
                    builder: (context, orientation) {
                      var compiledSurahText = compileSurahText(items);
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Image.asset(
                                    'images/na.png',
                                    width: MediaQuery.of(context).size.width,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    left: 20,
                                    child: Text(
                                      ' ${widget.surahtype} ',
                                      style: TextStyle(
                                        fontFamily: 'font5',
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Positioned(
                                    child: Text(
                                      'سورة ${widget.surahName} ',
                                      style: TextStyle(
                                        fontFamily: 'font2',
                                        fontSize: 30,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Positioned(
                                    right: 20,
                                    child: Text(
                                      '${widget.surahcontaya} ',
                                      style: TextStyle(
                                        fontFamily: 'font1',
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    compiledSurahText,
                                    style: TextStyle(
                                      fontFamily: 'font6',
                                      fontSize: orientation == Orientation.portrait ? 22 : 42,
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
        drawer: MenuLeft(),
      ),
    );
  }

  Future<List<Listquran>> readJsonDataQuran(int surahNumber) async {
    final jsondata = await rootBundle.rootBundle.loadString('jsondata/jsononline.json');
    final List<dynamic> dataList = json.decode(jsondata);

    // Filter the data based on 'surah_number' equal to surahNumber
    final filteredList = dataList.where((item) => item['surah_number'] == surahNumber).toList();

    // Map the filtered list to Listquran objects
    final List<Listquran> surahtList = filteredList.map((e) => Listquran.fromJson(e)).toList();

    return surahtList;
  }

  String compileSurahText(List<Listquran> verses) {
    var compiledText = '';
    for (var verse in verses) {
      compiledText += '${verse.aya} {${verse.verse_number}} ';
    }
    return compiledText.trim();
  }
}
