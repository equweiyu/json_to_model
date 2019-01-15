import 'package:json_to_model/type_model.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  group("ObjectModel", () {
    test("default converter", () {
      final file = File('test/mock_data.json').readAsStringSync();
      final Map<String, dynamic> jsondata = json.decode(file);
      final tm = convertToObjectModel(jsondata);
      final res = File('test/Simple.swift').readAsStringSync();
      expect(tm.show(),res);
    });
  });
}
