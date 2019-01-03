import 'package:json_to_model/util.dart';
import 'package:test/test.dart';

void main() {
  group('util', () {
    test('convertFromSnakeCase', () {
      expect(convertFromSnakeCase('one_two_three'), 'oneTwoThree');
      expect(convertFromSnakeCase('_one_two_three_'), '_oneTwoThree_');
      expect(convertFromSnakeCase('oneTwoThree'), 'oneTwoThree');
    });
    test('convertToSnakeCase', () {
      expect(convertToSnakeCase('oneTwoThree'), 'one_two_three');
      expect(convertToSnakeCase('_oneTwoThree_'), '_one_two_three_');
      expect(convertToSnakeCase('OneTwoThree'), 'one_two_three');
      expect(convertToSnakeCase('one_two_three'), 'one_two_three');
    });
    test('capitalized', () {
      expect(capitalized('apple'), 'Apple');
      expect(capitalized('APPLE'), 'Apple');
    });
  });
}
