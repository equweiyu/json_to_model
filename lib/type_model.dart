class ObjectModel extends JsonModel {
  final List<JsonModel> items;

  ObjectModel(this.items);
  String show({String className = 'Simple'}) {
    return 'class $className {\n' + parameterList() + '\n}';
  }

  //TODO:这里可以传入一个函数模板 (key,valueTypeName) => parameterShow
  String parameterList() {
    return items.map((f) => '  ' + f.key + ':' + f.valueTypeName).join('\n');
  }

  @override
  String get valueTypeName => this.key;
}

class ArrayModel extends JsonModel {
  final JsonModel item;

  ArrayModel(this.item);

  @override
  String get valueTypeName => '[${item.valueTypeName}]';
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

JsonModel _covertToJsonModel(
    dynamic obj, String name, String Function(String) converter) {
  JsonModel model;
  if (obj is Map<String, dynamic>) {
    model = ObjectModel(obj.entries
        .map((f) => _covertToJsonModel(f.value, f.key, converter))
        .toList());
  } else if (obj is List) {
    model = ArrayModel(_covertToJsonModel(obj.first, name, converter));
  } else {
    model = PairModel(obj);
  }
  model.key = converter(name);
  return model;
}

ObjectModel convertToObjectModel(dynamic obj,
    {String name = 'default', String Function(String) converter}) {
  final defaultConverter = (String f) => f;
  return _covertToJsonModel(obj, name, converter ?? defaultConverter);
}
