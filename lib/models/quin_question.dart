// import 'dart:convert';
//
// List<QnizQuestion> qnizQuestionFromJson(String str) => List<QnizQuestion>.from(json.decode(str).map((x) => QnizQuestion.fromJson(x)));
//
// String qnizQuestionToJson(List<QnizQuestion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class QnizQuestion {
//   QnizQuestion({
//     this.id,
//     this.question,
//     this.options,
//     this.answerIndex,
//   });
//
//   int? id;
//   String? question;
//   String? options;
//   int? answerIndex;
//
//   factory QnizQuestion.fromJson(Map<String, dynamic> json) => QnizQuestion(
//     id: json["id"],
//     question: json["question"],
//     options: json["options"],
//     answerIndex: json["answer_index"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "question": question,
//     "options": options,
//     "answer_index": answerIndex,
//   };
// }

import 'dart:convert';

List<QnizQuestion> qnizQuestionFromJson(String str) => List<QnizQuestion>.from(json.decode(str).map((x) => QnizQuestion.fromJson(x)));

String qnizQuestionToJson(List<QnizQuestion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QnizQuestion {
  QnizQuestion({
    this.id,
    this.question,
    this.options,
    this.answerIndex,
  });

  int? id;
  String? question;
  List<String>? options;
  int? answerIndex;

  factory QnizQuestion.fromJson(Map<String, dynamic> json) => QnizQuestion(
    id: json["id"],
    question: json["question"],
    options: List<String>.from(json["options"].map((x) => x)),
    answerIndex: json["answer_index"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "options": List<dynamic>.from(options!.map((x) => x)),
    "answer_index": answerIndex,
  };
}