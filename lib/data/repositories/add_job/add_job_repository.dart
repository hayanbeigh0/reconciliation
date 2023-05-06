import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reconciliation/constants/env_variable.dart';

class AddJobRepository {
  Future<Response> uploadExcel({
    required Uint8List file1Bytes,
    required Uint8List file2Bytes,
    required String file1Name,
    required String file2Name,
    required List<String> columns1,
    required List<String> columns2,
  }) async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "file1": MultipartFile.fromBytes(
        file1Bytes,
        filename: file1Name,
        contentType: MediaType("application", "vnd.ms-excel"),
      ),
      "file2": MultipartFile.fromBytes(
        file2Bytes,
        filename: file2Name,
        contentType: MediaType("application", "vnd.ms-excel"),
      ),
      "columns1": jsonEncode(columns1),
      "columns2": jsonEncode(columns2)
    });
    //  "columns1":
    //       jsonEncode(["effective from", "SI.No", "price", "billing type"]),
    //   "columns2":
    //       jsonEncode(["effective from", "SI.No", "price", "billing type"])

    Response response = await dio.post(
      "$API_URL/job/excelUpload",
      data: formData,
      onSendProgress: (count, total) {
        if (total != -1) {
          double progress = count / total * 100;
          log("Upload progress: $progress%");
          // Update the UI with the current progress
          // ...
        }
      },
    );
    log(response.statusMessage!);
    return response;
  }

  Future<Response> addjob({
    required String referenceName,
    required String sheet1Path,
    required String sheet2Path,
    required Map<String, dynamic> sheet1Mapping,
    required Map<String, dynamic> sheet2Mapping,
  }) async {
    log('Sheet 1 mapping: ${sheet1Mapping.toString()}');
    log('Sheet 2 mapping: ${sheet1Mapping.toString()}');
    log('Sheet 1 path: ${sheet1Path.toString()}');
    log('Sheet 2 path: ${sheet2Path.toString()}');
    Dio dio = Dio();
    final response = await dio.post(
      '$API_URL/job/createJob',
      data: jsonEncode({
        "ReconciliationReference": referenceName,
        "SheetOnePath": sheet1Path,
        "SheetTwoPath": sheet2Path,
        "SheetOneMapping": sheet1Mapping,
        "SheetTwoMapping": sheet2Mapping
      }),
    );
    debugPrint(response.toString());
    return response;
  }

  Future<Response> uploadFile({
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
        contentType: MediaType("application", "vnd.ms-excel"),
      ),
    });
    final response = await dio.post(
      '$API_URL/job/getExcelColumnHeaders',
      data: formData,
    );
    debugPrint(response.data.toString());
    return response;
  }

  Future<Response> checkReferenceAvailability(String value) async {
    log('Submitted');
    Dio dio = Dio();
    final response = await dio.post(
      '$API_URL/job/checkJobReferenceExist',
      data: jsonEncode({"reference": value}),
    );
    log(response.data.toString());
    return response;
  }
}
