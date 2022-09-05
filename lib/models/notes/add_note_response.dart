import 'dart:convert';

AddNoteResponse addNoteResponseJSON(String str) =>
    AddNoteResponse.fromJson(json.decode(str));

class AddNoteResponse {
  AddNoteResponse({
    required this.message,
  });
  late final String message;

  AddNoteResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    return _data;
  }
}
