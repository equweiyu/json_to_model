import 'package:json_to_model/util.dart';

class ObjectModel extends JsonModel {
  final List<JsonModel> items;

  ObjectModel(this.items);

  String show({String className = 'Simple'}) {
    StringConvert classNameShow =
        (f) => firstUpperCase(convertFromSnakeCase(f));
    StringConvert listShow = (f) => '[$f]';

    String Function(String key, String typeName) parameterShow =
        (key, typeName) => '  let $key: $typeName';

    String Function(String className, String classBody) classShow =
        (name, body) {
      return 'class $name {\n$body\n}';
    };

    String Function(JsonModel model) valueTypeNameShow = (f) {
      if (f is ObjectModel) {
        return classNameShow(f.valueTypeName);
      } else if (f is ArrayModel) {
        return listShow(classNameShow(f.valueTypeName));
      } else {
        return classNameShow(f.valueTypeName);
      }
    };
    StringConvert keyShow = (f) => convertFromSnakeCase(f);

    String res = classShow(
        classNameShow(className),
        items
            .map((f) => parameterShow(keyShow(f.key), valueTypeNameShow(f)))
            .join('\n'));

    for (var item in items) {
      if (item is ObjectModel) {
        res += '\n' + item.show(className: item.valueTypeName);
      }
      if (item is ArrayModel) {
        if (item.show().isNotEmpty) {
          res += '\n' + item.show();
        }
      }
    }

    return res;
  }

  @override
  String get valueTypeName => this.key;
}

class ArrayModel extends JsonModel {
  final JsonModel item;

  ArrayModel(this.item);

  String show() {
    if (item is ObjectModel) {
      return (item as ObjectModel).show(className: valueTypeName);
    } else {
      return '';
    }
  }

  @override
  String get valueTypeName => item.valueTypeName;
}

class PairModel extends JsonModel {
  final dynamic value;
  PairModel(this.value);
  @override
  String get valueTypeName => value.runtimeType.toString();
}

abstract class JsonModel {
  String key;
  String get valueTypeName;
}

JsonModel _covertToJsonModel(dynamic obj, String name) {
  JsonModel model;
  if (obj is Map<String, dynamic>) {
    model = ObjectModel(
        obj.entries.map((f) => _covertToJsonModel(f.value, f.key)).toList());
  } else if (obj is List) {
    model = ArrayModel(_covertToJsonModel(obj.first, name));
  } else {
    model = PairModel(obj);
  }
  model.key = name;
  return model;
}

ObjectModel convertToObjectModel(dynamic obj, {String name = 'default'}) {
  return _covertToJsonModel(obj, name);
}

typedef String StringConvert(String string);
