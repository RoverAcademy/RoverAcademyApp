import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

List<int> randArrange() {
  List<int> numbers = List.generate(12, (index) => index);
  numbers.shuffle(math.Random());
  return numbers;
}

List<dynamic> listMessagesToListJSON(List<MessagesRecord>? messages) {
  messages ??= [];

  final reversedMessages = messages.reversed.toList();

  final List<Map<String, dynamic>> jsonList = reversedMessages.map((message) {
    return {
      'role': message.role.toString().split('.').last,
      'content': message.content,
    };
  }).toList();

  return jsonList;
}

List<String> getMatchTerms(List<QuestionsRecord> terms) {
  List<String> matchTerms = [];

  // Picks out 6 random documents
  final random = math.Random();
  terms.shuffle(random);
  terms = terms.take(6).toList();

  for (var term in terms) {
    matchTerms.add(term.question); // Add the question to the list

    // Determine the correct answer based on correctAns
    String correctAnswer;
    switch (term.correctAns) {
      case 0:
        correctAnswer = term.option1;
        break;
      case 1:
        correctAnswer = term.option2;
        break;
      case 2:
        correctAnswer = term.option3;
        break;
      case 3:
        correctAnswer = term.option4;
        break;
      default:
        correctAnswer = '';
    }

    matchTerms.add(correctAnswer); // Add the correct answer to the list
  }

  return matchTerms; // Return the list of strings
}

/// Returns the highest of four numbers
int greatestNum(
  int int1,
  int int2,
  int int3,
  int int4,
) {
  // Create a function that returns the highest of 4 numbers
  return math.max(math.max(int1, int2), math.max(int3, int4));
}
