import 'package:json_to_model/util.dart';
import 'package:test/test.dart';

void main() {
  group("util", () {
    test("convertFromSnakeCase", () {
      expect(convertFromSnakeCase("one_two_three"), 'oneTwoThree');
      expect(convertFromSnakeCase("_one_two_three_"), '_oneTwoThree_');
    });
    test("capitalized", () {
      expect(capitalized("apple"), 'Apple');
      expect(capitalized("APPLE"), 'Apple');
    });
  });
}
