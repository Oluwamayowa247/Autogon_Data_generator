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
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment:
      //         MainAxisAlignment.spaceBetween, // Space items evenly
      //     children: [
      //       Image.asset(
      //         'lib/image/autogon_logo.jpg',
      //         height: 50,
      //         width: 50,
      //       ),
      //       const Text(
      //         'Autogon Data Generator',
      //         style: TextStyle(
      //           color: Colors.black,
      //           fontSize: 24,
      //         ),
      //       ),
      //     ],
      //   ),
      //   backgroundColor: Colors.orange[300], // Consider a warmer orange shade
      //   elevation: 0,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align content horizontally
          children: [
            const Text(
              'Create a Dataset',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, // Add emphasis
              ),
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
              mainAxisAlignment: MainAxisAlignment.center, // Center buttons
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
                    primary: Colors.orange[300], // Match app bar color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 20), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // ignore: unnecessary_null_comparison
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
      bottomNavigationBar: const Text(
        '', // Remove empty bottom navigation bar (optional)
      ),
    );
  }
}
