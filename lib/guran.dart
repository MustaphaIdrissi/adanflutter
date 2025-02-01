import 'package:adan/menuquran.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Qurana extends StatelessWidget {
  final String nbpage;

  const Qurana({
    Key? key,
    required this.nbpage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuranGallery(nbpage: nbpage),
    );
  }
}

class QuranGallery extends StatefulWidget {
  final String nbpage;

  const QuranGallery({
    Key? key,
    required this.nbpage,
  }) : super(key: key);

  @override
  _QuranGalleryState createState() => _QuranGalleryState();
}

class _QuranGalleryState extends State<QuranGallery> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _isVisible = false;
  bool _isDrawerVisible = false;
Timer? _hideTimer;
  @override
  void initState() {
    super.initState();
    int initialPage = int.tryParse(widget.nbpage) ?? 1;
    _currentPage = initialPage - 1; // Zero-based index
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
     _hideTimer?.cancel(); // إلغاء المؤقت عند إلغاء الشاشة
    super.dispose();
  }
  void _toggleDrawer() {
    setState(() {
      _isDrawerVisible = !_isDrawerVisible; // التبديل بين إظهار وإخفاء القائمة الجانبية
    });

    // إعادة تشغيل المؤقت لإخفاء القائمة بعد 0.5 ثانية
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _isDrawerVisible = false; // إخفاء القائمة الجانبية بعد 0.5 ثانية
      });
    });
  }
  void _showControls() {
    setState(() {
      
      _isVisible = true;
      _isDrawerVisible = true; // c
      
    });
     _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  void _hideControls() {
    setState(() {
      _isVisible = false;
      _isDrawerVisible = false; // إخفاء القائمة الجانبية
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
  if (_isVisible) {
    _hideControls();
  } else {
    _showControls();
  }
},// عرض الأزرار والقائمة عند لمس الشاشة
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 687, // Total number of pages
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    var orientation = MediaQuery.of(context).orientation;
                    return orientation == Orientation.portrait
                        ? Image.asset(
                            'quran/page${(index + 1).toString().padLeft(3, '0')}.png',
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                          )
                        : SingleChildScrollView(
                            child: Image.asset(
                              'quran/page${(index + 1).toString().padLeft(3, '0')}.png',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
          // القائمة الجانبية
          AnimatedPositioned(
           
             duration: const Duration(milliseconds: 500),
            left: _isDrawerVisible ? 0 : -250, // عرض القائمة أو إخفاؤها
            top: 0,
            bottom: 0,
            child: Visibility(
                visible: _isVisible,
                child:  Container(
              width: 250,
              color: Colors.blueGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text("الفهرس المصحف "),
                    onTap: () {
                     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Menuquran()),  // إضافة الانتقال إلى Menuquran
    );
                    },
                  ),
                  ListTile(
                    title: const Text("القائمة 2"),
                    onTap: () {
                      // تنفيذ إجراء
                    },
                  ),
                  ListTile(
                    title: const Text("القائمة 3"),
                    onTap: () {
                      // تنفيذ إجراء
                    },
                  ),
                ],
              ),
            ),
            ),
          ),
          // الأزرار السفلية
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
             duration: const Duration(milliseconds: 500),
              child: Visibility(
                visible: _isVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _currentPage > 0
                          ? () => _goToPage(_currentPage - 1)
                          : null,
                      child: const Text("السابق"),
                    ),
                    Text("الصفحة: ${_currentPage + 1}"),
                    ElevatedButton(
                      onPressed: _currentPage < 686
                          ? () => _goToPage(_currentPage + 1)
                          : null,
                      child: const Text("التالي"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToPage(int page) {
    setState(() {
      _currentPage = page;
      _pageController.jumpToPage(_currentPage);
    });
  }
}
