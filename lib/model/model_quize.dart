// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuizModel {
  String question;
  List<String> answers;
  num indexOfCorrect;
  QuizModel({
    required this.question,
    required this.answers,
    required this.indexOfCorrect,
  });

  QuizModel copyWith({
    String? question,
    List<String>? answers,
    num? indexOfCorrect,
  }) {
    return QuizModel(
      question: question ?? this.question,
      answers: answers ?? this.answers,
      indexOfCorrect: indexOfCorrect ?? this.indexOfCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answer': answers,
      'indexOfCorrect': indexOfCorrect,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      question: map['question'] as String,
      answers: List<String>.from(
        (map['answers'] as List<String>),
      ),
      indexOfCorrect: map['indexOfCorrect'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'QuizModel(question: $question, answers: $answers, indexOfCorrect: $indexOfCorrect)';

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;

    return other.question == question &&
        listEquals(other.answers, answers) &&
        other.indexOfCorrect == indexOfCorrect;
  }

  @override
  int get hashCode =>
      question.hashCode ^ answers.hashCode ^ indexOfCorrect.hashCode;
}
