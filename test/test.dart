import 'package:json_to_model/type_model.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'dart:io';


void main() {
  group("description", () {
    test("description", () {
      final file = File('test/mock_data.json').readAsStringSync();
      final Map<String, dynamic> jsondata = json.decode(file);
      final tm = covertToObjectModel('SimpleClass',jsondata);
      print(tm.show());
    });
  });
}
