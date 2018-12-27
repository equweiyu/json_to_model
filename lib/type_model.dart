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

JsonModel _covertToJsonModel(String name, dynamic obj) {
  JsonModel model;
  if (obj is Map<String, dynamic>) {
    model = ObjectModel(
        obj.entries.map((f) => _covertToJsonModel(f.key, f.value)).toList());
  } else if (obj is List) {
    model = ArrayModel(_covertToJsonModel(name, obj.first));
  } else {
    model = PairModel(obj);
  }
  model.key = name;
  return model;
}

ObjectModel covertToObjectModel(String name, dynamic obj) {
  return _covertToJsonModel(name, obj);
}
