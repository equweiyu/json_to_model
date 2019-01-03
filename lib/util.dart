/// [JSONEncoder](https://github.com/apple/swift-corelibs-foundation/blob/e49beda4e4bd49e8ab541015d78b82a0a1957bc5/Foundation/JSONEncoder.swift)
String convertFromSnakeCase(String stringKey) {
  if (stringKey.isEmpty) {
    return stringKey;
  }
  // Find the first non-underscore character
  final firstNonUnderscore = stringKey.indexOf(RegExp(r'[^_]'));
  if (firstNonUnderscore < 0) {
    // Reached the end without finding an _
    return stringKey;
  }
  // Find the last non-underscore character
  final lastNonUnderscore = stringKey.lastIndexOf(RegExp(r'[^_]'));

  final keyRange = StringRange(firstNonUnderscore, lastNonUnderscore + 1);
  final leadingUnderscoreRange = StringRange(0, firstNonUnderscore);
  final trailingUnderscoreRange = StringRange(lastNonUnderscore + 1);

  final components = substringByRange(stringKey, keyRange).split('_');

  String joinedString;

  if (components.length == 1) {
    // No underscores in key, leave the word as is - maybe already camel cased
    joinedString = components.first;
  } else {
    joinedString = components[0].toLowerCase() +
        components.sublist(1).map((f) => capitalized(f)).join();
  }
  final leading = substringByRange(stringKey, leadingUnderscoreRange);
  final trailing = substringByRange(stringKey, trailingUnderscoreRange);
  return leading + joinedString + trailing;
}

String convertToSnakeCase(String stringKey) {
  if (stringKey.isEmpty) {
    return stringKey;
  }
  List<String> words = [];
  var wordStart = 0;

  var uppercase = stringKey.indexOf(RegExp(r'[A-Z]'), wordStart + 1);
  while (uppercase >= 0) {
    words.add(stringKey.substring(wordStart, uppercase).toLowerCase());
    wordStart = uppercase;
    uppercase = stringKey.indexOf(RegExp(r'[A-Z]'), wordStart + 1);
  }
  words.add(stringKey.substring(wordStart).toLowerCase());
  return words.join('_');
}

String substringByRange(String string, StringRange range) =>
    string.substring(range.startIndex, range.endIndex);

String capitalized(String string) =>
    string[0].toUpperCase() + string.substring(1).toLowerCase();

class StringRange {
  final int startIndex;
  final int endIndex;

  StringRange(this.startIndex, [this.endIndex]);
}
