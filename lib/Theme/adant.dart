import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // For handling file system paths
import 'package:http/http.dart' as http; // For HTTP requests
import 'dart:convert'; // For JSON encoding

class AdantPage extends StatelessWidget {
  String? selectedCity;
  String? selectedCountry;

  Future<void> fetchAndReplaceFile(String city, String country) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/prayer_times.json';
      final file = File(filePath);

      // Check if the file exists and delete it if present
      if (await file.exists()) {
        await file.delete();
      }
   final response = await http.post(
        Uri.parse('http://localhost:8080/adan/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'city': city, 'country': country}),
      );

      if (response.statusCode == 200) {
        // Save the new file locally
        await file.writeAsString(response.body);
      } else {
        throw Exception('Failed to fetch data from server');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختيار المدينة',
            style: TextStyle(fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختر المدينة:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'أدخل اسم المدينة',
              ),
              onChanged: (value) {
                selectedCity = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              'أو اختر من القائمة:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 'Azrou', child: Text('ازرو')),
                DropdownMenuItem(value: 'Fes', child: Text('فاس')),
                DropdownMenuItem(value: 'Rabat', child: Text('الرباط')),
              ],
              onChanged: (value) {
                selectedCity = value;
              },
              hint: Text('اختر مدينة'),
            ),
            SizedBox(height: 20),
            Text(
              'اختر الدولة:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 'Maroc', child: Text('المغرب')),
                DropdownMenuItem(value: 'France', child: Text('فرنسة')),
                DropdownMenuItem(value: 'Espagne', child: Text('اسبانيا')),
              ],
              onChanged: (value) {
                selectedCountry = value;
              },
              hint: Text('اختر الدولة'),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedCity != null && selectedCountry != null) {
                    fetchAndReplaceFile(selectedCity!, selectedCountry!);
                  } else {
                    print('Please select both city and country');
                  }
                },
                child: Text('تأكيد', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
