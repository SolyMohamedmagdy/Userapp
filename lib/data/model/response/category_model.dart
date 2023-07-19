class CategoryModel {
  late int _id;
  late String _name;
  late String _image;
  late int _parentId;
  late int _position;
  late int _status;
  late String _createdAt;
  late String _updatedAt;

  CategoryModel({
    int id = 0,
    String name = '',
    String image = '',
    int parentId = 0,
    int position = 0,
    int status = 0,
    String createdAt = '',
    String updatedAt = '',
  }) {
    this._id = id;
    this._name = name;
    this._image = image;
    this._parentId = parentId;
    this._position = position;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  String get name => _name;
  String get image => _image;
  int get parentId => _parentId;
  int get position => _position;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  CategoryModel.fromJson(Map<String, dynamic>? json) {
    _id = json?['id'] ?? 0;
    _name = json?['name'] ?? '';
    _image = json?['image'] ?? '';
    _parentId = json?['parent_id'] ?? 0;
    _position = json?['position'] ?? 0;
    _status = json?['status'] ?? 0;
    _createdAt = json?['created_at'] ?? '';
    _updatedAt = json?['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['image'] = this._image;
    data['parent_id'] = this._parentId;
    data['position'] = this._position;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
