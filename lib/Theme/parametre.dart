import 'package:adan/Theme/adant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:adan/Theme/colorapp.dart' as myappcolor;

class Paramg extends StatefulWidget {
  @override
  _ParamgState createState() => _ParamgState();
}

class _ParamgState extends State<Paramg> {
  Color backgroundColor =
      myappcolor.ColorApp().background; // Initial background color
  Color textColor = myappcolor.ColorApp().Textcolor; // Initial text color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myappcolor.ColorApp().background2,
      body: Column(
        children: [
          SizedBox(
            width: 600,
            height: 300,
            child: Card(
              color: myappcolor.ColorApp().background,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("الون الخلفية:",
                            style: TextStyle(
                                fontSize: 24,
                                color: myappcolor.ColorApp().Textcolor)),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                myappcolor.ColorApp().background2),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('اختر لون الخلفية',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color:
                                              myappcolor.ColorApp().Textcolor)),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: backgroundColor,
                                      onColorChanged: (color) {
                                        setState(() {
                                          backgroundColor = color;
                                        });
                                      },
                                      showLabel: true,
                                      pickerAreaHeightPercent: 0.8,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('موافق',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: myappcolor.ColorApp()
                                                  .Textcolor)),
                                      onPressed: () {
                                        setState(() {
                                          myappcolor.ColorApp().updateColors(
                                            background: backgroundColor,
                                          );
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('إختر لون',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: myappcolor.ColorApp().Textcolor,
                                  backgroundColor:
                                      myappcolor.ColorApp().background2)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("الون الخط :",
                            style: TextStyle(
                                fontSize: 24,
                                color: myappcolor.ColorApp().Textcolor)),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                myappcolor.ColorApp().background2),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('اختر لون النص',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color:
                                              myappcolor.ColorApp().Textcolor)),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor:
                                          myappcolor.ColorApp().background,
                                      onColorChanged: (color) {
                                        setState(() {
                                          textColor = color;
                                        });
                                      },
                                      showLabel: true,
                                      pickerAreaHeightPercent: 0.8,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('موافق',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: myappcolor.ColorApp()
                                                  .Textcolor)),
                                      onPressed: () {
                                        setState(() {
                                          myappcolor.ColorApp().updateColors(
                                            textColor: textColor,
                                          );
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('إختر لون',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: myappcolor.ColorApp().Textcolor,
                                  backgroundColor:
                                      myappcolor.ColorApp().background2)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("الحجم الخط:",
                            style: TextStyle(
                                fontSize: 24,
                                color: myappcolor.ColorApp().Textcolor)),
                        SizedBox(
                          width: 90.0, // Set the desired width
                          height: 50.0, // Set the desired height

                          child: TextField(),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                myappcolor.ColorApp().background2),
                          ),
                          onPressed: () {},
                          child: Text('موافق',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: myappcolor.ColorApp().Textcolor,
                                  backgroundColor:
                                      myappcolor.ColorApp().background2)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("اختيار المدينة :",
                            style: TextStyle(
                                fontSize: 24,
                                color: myappcolor.ColorApp().Textcolor)),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                myappcolor.ColorApp().background2),
                          ),
                          onPressed: () {

 Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdantPage(), // Replace with your class name
                ),
              );


                          },
                          child: Text('اختيلر المدينة',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: myappcolor.ColorApp().Textcolor,
                                  backgroundColor:
                                      myappcolor.ColorApp().background2)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),



          SizedBox(
            width: 600,
            height: 200,
            child: Card(
              color: backgroundColor, // Apply selected background color
              child: Center(
                child: Text(
                  'Sample Text',
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
