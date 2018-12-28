import 'package:json_to_model/type_model.dart';
import 'package:json_to_model/util.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  group("ObjectModel", () {
    test("default converter", () {
      final file = File('test/mock_data.json').readAsStringSync();
      final Map<String, dynamic> jsondata = json.decode(file);
      final tm = convertToObjectModel(jsondata);
      print(tm.show());
    });
    test("user converter", () {
      final file = File('test/mock_data.json').readAsStringSync();
      final Map<String, dynamic> jsondata = json.decode(file);
      final tm = convertToObjectModel(jsondata, converter: convertFromSnakeCase);
      print(tm.show());
    });
  });
}
