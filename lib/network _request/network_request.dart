import 'dart:convert';
import 'dart:io';
//import 'dart:io';
import 'package:http/http.dart' as http;
//import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// Future<String?> generateDataset() async {
//   TextEditingController promptController = TextEditingController();
//   TextEditingController rowsController = TextEditingController();

//   var url = 'https://api.autogon.ai/api/v1/services/generate-data/';
//   var body = jsonEncode({
//     'prompt': promptController.text,
//     'rows': int.tryParse(rowsController.text),
//   });

//   var apiKey = 'iSFkCENJ.bhycYF1qOGFldcXITLLvwgnoqSU2pcxe';

//   var response = await http.post(Uri.parse(url), body: body, headers: {
//     'Content-Type': 'application/json',
//     'X-Aug-Key': apiKey,
//   });

//   if (response.statusCode == 200) {
//     var data = jsonDecode(response.body);
//     if (data['status'] == true) {
//       return data['message'];
//     } else {
//       print(response.body);
//       throw Exception('Failed to generate data: ${data['message']}');
//     }
//   } else {
//     print(response.body);
//     throw Exception('Failed to fetch data');
//   }

//   //Make dataset link downloadab
// }

Future<String?> generateDataUrl(TextEditingController promptController,
    TextEditingController rowsController) async {
  var url = 'https://api.autogon.ai/api/v1/services/generate-data/';
  var body = jsonEncode({
    'prompt': promptController.text,
    'rows': int.tryParse(rowsController.text),
  });

  var apiKey =
      'EFnjXe1p.3F7SbrtWEfJsxntIxENe7czicIwCo2po'; // Replace with your actual API key

  var response = await http.post(
    Uri.parse(url),
    body: body,
    headers: {
      'Content-Type': 'application/json',
      'X-Aug-Key': apiKey,
    },
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data['status'] == true) {
      print(data['message']); // Print success message for debugging
      var datasetUrl = data['message'];

      return datasetUrl;
    } else {
      print(response.body); // Print error message for debugging
      return null; // Indicate error or missing URL
    }
  } else {
    print(
        'Error generating dataset: ${response.statusCode}'); // Print error status code
    return null; // Indicate error
  }
}

Future<void> downloadFileFromUrl(String url) async {
  try {
    final fileResponse = await http.get(Uri.parse(url));
    if (fileResponse.statusCode != 200) {
      print('File not downloaded: Status code ${fileResponse.statusCode}');
      throw Exception(
          'Failed to download file: Status code ${fileResponse.statusCode}');
    }
    final directory = await getApplicationDocumentsDirectory();

    final filePath = '${directory.path}/dataset.csv';

    final file = File(filePath);
    await file.writeAsBytes(fileResponse.bodyBytes);
    print('Download complete! File saved to: $filePath');
  } on Exception catch (e) {
    print('Error downloading file: $e');
  }
}
