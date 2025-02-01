import 'package:adan/Theme/colorapp.dart' as myColorApp;
import 'package:adan/classqurane.dart';
import 'package:adan/guran.dart';
import 'package:adan/homing.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class Menuquran extends StatefulWidget {
  const Menuquran({Key? key});

  @override
  State<Menuquran> createState() => _MenuquranState();
}

class _MenuquranState extends State<Menuquran> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: myColorApp.ColorApp().background2,
        child: FutureBuilder<List<ClassQurane>>(
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
                              Navigator.pushNamed(
                                context,
                                '/page2',
                                arguments: {
                                  'label': 'أذان',
                                  'indexr': 2,
                                  'RN': verses[index].nbpage.toString(),
                                },
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

  Future<List<ClassQurane>> readJsonDataQuranf() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsondata/indqurankarim.json');
    final List<dynamic> dataList = json.decode(jsondata);

    // Map the dataList to Indexqu objects
    final List<ClassQurane> verseList =
        dataList.map((e) => ClassQurane.fromJson(e)).toList();

    return verseList;
  }
}
