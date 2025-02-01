import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Adanmp extends StatefulWidget {
  @override
  _AdanmpState createState() => _AdanmpState();
}

class _AdanmpState extends State<Adanmp> {
  List<String> tasbih = [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
    'لا إله إلا الله وحده لا شريك له له الملك وله الحمد وهو على كل شيء قدير',
  ];

  @override
  void initState() {
    super.initState();
    _loadTasbihList();
  }

  Future<void> _loadTasbihList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tasbih = prefs.getStringList('tasbihList') ?? tasbih;
    });
  }

  Future<void> _saveTasbihList(List<String> tasbihList) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasbihList', tasbihList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasbih'),
      ),
      body: ListView.builder(
        itemCount: tasbih.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasbih[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewTasbihDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addNewTasbihDialog(BuildContext context) async {
    // ignore: unused_local_variable
    String newTasbih = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String _enteredTasbih = '';
        return AlertDialog(
          title: Text('Add New Tasbih'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter new tasbih'),
            onChanged: (value) {
              _enteredTasbih = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_enteredTasbih.isNotEmpty) {
                  setState(() {
                    tasbih.add(_enteredTasbih);
                  });
                  _saveTasbihList(tasbih);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
