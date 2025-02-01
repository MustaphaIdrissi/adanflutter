import 'package:flutter/material.dart';
import 'package:adan/Theme/colorapp.dart' as myColorApp;

class MenuLeft extends StatefulWidget {
  const MenuLeft({Key? key});

  @override
  State<MenuLeft> createState() => _MenuLeftState();
}

class _MenuLeftState extends State<MenuLeft> {
  late TextEditingController _searchController;
  //late ColorApp myColorApp;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void _handleItemTap(int index) {
    setState(() {
      selectedIndex = index - 1;
    });
    Navigator.pushNamed(
      context,
      index == 0 ? '/' : '/page2',
      arguments: {
        'label': _getLabelText(index),
        'indexr': index - 1,
      },
    );
  }

  String _getLabelText(int index) {
    switch (index) {
      case 0:
        return 'الرئيسية';
      case 1:
        return 'مواقيت الصلاة';
      case 2:
        return 'الأدعية';
      case 3:
        return 'أذان';
      case 4:
        return 'القبلة للصلاة';
      case 5:
        return 'المسبحة';
      case 6:
        return 'القرأن الكريم';
      case 7:
        return 'الاعدادات';
      case 8:
        return 'حول التطبيق';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Drawer(
          surfaceTintColor: Color.fromARGB(255, 81, 7, 255),
          backgroundColor: Color.fromARGB(255, 30, 6, 248),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(1.0)),
          ),
          elevation: 10,
          child: ListView(
            
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: myColorApp.ColorApp().background,
                 
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: myColorApp.ColorApp().Textcolor,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  fillColor: myColorApp.ColorApp().background2,
                  filled: true,
                  border: OutlineInputBorder(),
                  iconColor:myColorApp.ColorApp().Textcolor,
                  prefixIcon: Icon(Icons.search), // إضافة أيقونة البحث
                ),
                onChanged: (text) {
                  // Handle search query change
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 9,
                itemBuilder: (context, index) {
                  return ListTile(
                    selected: true,
                    selectedTileColor: myColorApp.ColorApp().background2,
                    title: Text(
                      _getLabelText(index),
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'font2',
                        color: myColorApp.ColorApp().Textcolor,
                      ),
                    ),
                    onTap: () => _handleItemTap(index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
