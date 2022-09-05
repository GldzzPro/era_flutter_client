import 'dart:convert';

AddNoteRequestModel addNoteRequestJSON(String str) =>
    AddNoteRequestModel.fromJson(json.decode(str));

class AddNoteRequestModel {
  AddNoteRequestModel({
    required this.idUser,
    required this.title,
    required this.note,
    required this.importance,
  });
  late final String idUser;
  late final String title;
  late final String note;
  late final String importance;

  AddNoteRequestModel.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    title = json['title'];
    note = json['note'];
    importance = json['importance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_user'] = idUser;
    _data['title'] = title;
    _data['note'] = note;
    _data['importance'] = importance;
    return _data;
  }
}
