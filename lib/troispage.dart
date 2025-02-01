import 'package:adan/menuleft.dart';
import 'package:flutter/material.dart';
import 'package:adan/Theme/colorapp.dart' as myColorApp;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'doae.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  List<Douae> doaeList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
            {};
    final int indexr = arguments['indexr'] ?? 0;
    doaeList = getListByReceivedData(indexr);
  }

  List<Douae> getListByReceivedData(int receivedData) {
    // Return the appropriate list based on receivedData
    switch (receivedData) {
      case 0:
        return doaegroup;
      case 1:
        return doaegroup1;
      case 2:
        return doaegroup2;
      // Add more cases as needed
      default:
        return [];
    }
  }

  void updateItemRept(int index, int newRept) {
    setState(() {
      doaeList[index].rept = newRept;
      if (doaeList[index].rept <= 0) {
        doaeList.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
            {};
    final String label = arguments['label'] ?? '';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: MenuLeft(),
        appBar: AppBar(
          title: Text('$label'),
          backgroundColor: myColorApp.ColorApp().background,
          iconTheme: IconThemeData(
            color: myColorApp.ColorApp().Textcolor,
          ),
        ),
        body: Container(
          color: myColorApp.ColorApp().background2,
          child: ListView.builder(
              itemCount: doaeList.length,
              itemBuilder: (context, index) {
                return Testing(
                  doae: doaeList[index].doae,
                  rept: doaeList[index].rept,
                  index: index,
                  onUpdate: updateItemRept,
                );
              }),
        ),
      ),
    );
  }
}

class Testing extends StatefulWidget {
  final int index;
  final String doae;
  final int rept;
  final Function(int, int) onUpdate;

  const Testing({
    Key? key,
    required this.doae,
    required this.rept,
    required this.index,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  late int totalRep;

  @override
  void initState() {
    super.initState();
    totalRep = widget.rept;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: myColorApp.ColorApp().trans,
        foregroundColor: myColorApp.ColorApp().trans,
        shadowColor: myColorApp.ColorApp().trans,
        overlayColor: myColorApp.ColorApp().background2,
      ),
      onPressed: () {
        setState(() {
          totalRep = widget.rept;
          if (totalRep > 0) {
            totalRep--;
            widget.onUpdate(widget.index, totalRep);
          }
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: myColorApp.ColorApp().background,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(19.0),
                bottomRight: Radius.circular(19.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: myColorApp.ColorApp().Textcolor2,
                  spreadRadius: 7,
                  blurRadius: 7,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  alignment: Alignment.center,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        textDirection: TextDirection.rtl,
                        widget.doae,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: myColorApp.ColorApp().Textcolor,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: myColorApp.ColorApp().background2,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(19.0),
                      bottomRight: Radius.circular(19.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: myColorApp.ColorApp().shado1,
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset.zero,
                      ),
                    ],
                  ),
                  child: Container(
                    color: myColorApp.ColorApp().Textcolor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'تكرار',
                          style: TextStyle(
                            color: myColorApp.ColorApp().Textcolor2,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'font1',
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: myColorApp.ColorApp().background,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              '${widget.rept}',
                              style: TextStyle(
                                color: myColorApp.ColorApp().Textcolor,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'font1',
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Matrix Inversion Result'),
                                 
                                );
                              },
                            );
                          },
                          child: Text(
                            'مشاركة',
                            style: TextStyle(
                              color: myColorApp.ColorApp().Textcolor2,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'font1',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
