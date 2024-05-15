//import 'package:dataset_generator/colors/app_colors.dart';
import 'package:dataset_generator/network%20_request/network_request.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class DataGeneratorHome extends StatefulWidget {
  const DataGeneratorHome({super.key});

  @override
  State<DataGeneratorHome> createState() => _DataGeneratorHomeState();
}

class _DataGeneratorHomeState extends State<DataGeneratorHome> {
  TextEditingController promptController = TextEditingController();
  TextEditingController rowsController = TextEditingController();
  late String datasetUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Create a Dataset',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: promptController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Prompt',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: rowsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Rows',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      String? url = await generateDataUrl(
                          promptController, rowsController);
                      setState(() {
                        datasetUrl = url.toString();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Data generated successfully'),
                        ),
                      );
                    } catch (e) {
                      print('Error: $e');
                      print('Data generation failed');
                    }
                  },
                  child: const Text('Generate Data'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    if (datasetUrl != null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Dataset URL'),
                            content: SelectableText(datasetUrl),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please generate data first'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Show Dataset Url'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Powered by Autogon © 2023 Autogon',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
