import 'dart:convert';

GetAllNotesResponse notesResponseJson(String str) =>
    GetAllNotesResponse.fromJson(json.decode(str));

class GetAllNotesResponse {
  GetAllNotesResponse({
    required this.notes,
    required this.message,
  });
  late final List<Notes> notes;
  late final String message;

  GetAllNotesResponse.fromJson(Map<String, dynamic> json) {
    notes = List.from(json['notes']).map((e) => Notes.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['notes'] = notes.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Notes {
  Notes({
    required this.id,
    required this.idUser,
    required this.title,
    required this.note,
    required this.importance,
  });
  late final String id;
  late final String idUser;
  late final String title;
  late final String note;
  late final String importance;

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    idUser = json['id_user'];
    title = json['title'];
    note = json['note'];
    importance = json['importance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['id_user'] = idUser;
    _data['title'] = title;
    _data['note'] = note;
    _data['importance'] = importance;

    return _data;
  }
}
