import 'package:flutter/material.dart';
import 'package:adan/menuleft.dart';
import 'package:adan/Theme/colorapp.dart' as myColorApp;
import 'package:shared_preferences/shared_preferences.dart';
import '../troispage.dart';
import '../homing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await myColorApp.ColorApp().loadColors(); // تحميل الألوان المحفوظة
  runApp(MyApp());
}

class Settings {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Add methods for setting/getting data as needed
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Adanexemple(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page3(),
      },
    );
  }
}

class Adanexemple extends StatelessWidget {
  const Adanexemple({super.key});

  ElevatedButton buildButton(
      BuildContext context, final int index, String name, String liimag) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to Page 2
        Navigator.pushNamed(
          context,
          '/page2',
          arguments: {
            'label': name,
            'indexr': index,
          },
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 10.0, // Adjust the elevation as needed
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent, // Set to transparent for no shadow
      ),
      child: Ink.image(
        image: AssetImage('images/$liimag'),
        child: Container(
          width: 160.0,
          height: 160.0,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: myColorApp.ColorApp().background.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: myColorApp.ColorApp().shado1,
                  spreadRadius: 2.0,
                  blurRadius: 1.0,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Text(
              '$name',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: myColorApp.ColorApp().Textcolor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> itemList = [
      'مواقيت الصلاة',
      'الأدعية',
      'أذان',
      'القبلة الصلاة',
      'المسبحة',
      'القرأن الكريم'
    ];
    final List<String> itemimg = [
      'adan6.png',
      'adan3.png',
      'adan1.png',
      'adan4.png',
      'adan5.png',
      'adan2.png'
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(
            'تطبيق اسلامي',
            style: TextStyle(
              fontFamily: 'font2',
              fontSize: 24,
              color: myColorApp.ColorApp().Textcolor,
            ),
          ),
          backgroundColor: myColorApp.ColorApp().background,
          iconTheme: IconThemeData(
            color: myColorApp.ColorApp().Textcolor, // Change icon color here
          ),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
          ),
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  buildButton(context, index, itemList[index], itemimg[index]),
            );
          },
        ),
        drawer: MenuLeft(),
      ),
    );
  }
}
