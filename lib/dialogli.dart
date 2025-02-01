import 'package:flutter/material.dart';
import 'package:adan/Theme/colorapp.dart' as myColorApp;

class dail1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  List<String> textList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' إضافة التسبيح'),
        backgroundColor: myColorApp.ColorApp().background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Your other form fields can go here

            // Text list
            Expanded(
              child: ListView.builder(
                itemCount: textList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(textList[index]),
                  );
                },
              ),
            ),

            // Add text button
            ElevatedButton(
              onPressed: () {
                _showTextDialog();
              },
              child: Text(' إضافة التسبيح'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a dialog for adding text
  Future<void> _showTextDialog() async {
    TextEditingController textController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(' إضافة التسبيح'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: ' إضافة التسبيح'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('الغاء'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  textList.add(textController.text);
                });
                Navigator.of(context).pop();
              },
              child: Text(' إضافة'),
            ),
          ],
        );
      },
    );
  }
}
