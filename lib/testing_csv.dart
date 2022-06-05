import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FileWeb extends StatefulWidget {
  FileWeb({Key? key}) : super(key: key);

  @override
  State<FileWeb> createState() => _FileWebState();
}

class _FileWebState extends State<FileWeb> {
  String uploadFilename = "";
  Uint8List? csvFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text('File: $uploadFilename'),
              ElevatedButton(
                  onPressed: () async {
                    final results = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['csv'],
                    );

                    csvFile = results!.files.first.bytes;
                    //print(csvFile);

                    // print(imgFile);

                    uploadFilename = results.files.first.name;
                    print(uploadFilename);

                    sendFile(csvFile, uploadFilename);

                    setState(() {});
                  },
                  child: const Text('CSV Take'))
            ],
          ),
        ),
      ),
    );
  }

  sendFile(file, uploadFilename) {
    var url = Uri.parse("http://................");
    var request = http.MultipartRequest("POST", url);

    var token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mjk1YWYwMjA0NjMwYjQzZjM2MjMzMGIiLCJpYXQiOjE2NTQ0MDExODV9.48Wta1PI8zRER8N51DL2KbWvC0BToEZDkmfcOBvBrCU';

    request.files.add(http.MultipartFile.fromBytes('file', file,
        filename: "$uploadFilename.csv"));

    request.headers.addAll({"Authorization": "Bearer $token"});

    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Uploaded!");
      }
    });
  }
}
