class Quote {
  String? _text;
  String? _author;

  Quote({String? text, String? author}) {
    if (text != null) {
      _text = text;
    }
    if (author != null) {
      _author = author;
    }
  }

  String? get text => _text;
  set text(String? text) => _text = text;
  String? get author => _author;
  set author(String? author) => _author = author;

  Quote.fromJson(Map<String, dynamic> json) {
    _text = json['text'];
    _author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = _text;
    data['author'] = _author;
    return data;
  }
}