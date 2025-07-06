// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math'; // For random number generation

class PuzzleQuiz extends StatefulWidget {
  const PuzzleQuiz({
    super.key,
    this.width,
    this.height, // This parameter will be used to define the overall height of the widget
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
    required this.onAnswerCallback,
    required this.imageUrl,
    this.puzzleColumns = 4,
    this.puzzleRows = 4,
    this.pieceSpacing = 2.0,
    this.pieceBorderRadius = 4.0,
    this.puzzleContentFlex = 2, // Relative size for the puzzle area
    this.qaContentFlex = 3, // Relative size for the question/answer area
    this.puzzleFrameWidthPercentage =
        0.9, // New parameter for puzzle frame width as percentage
    this.qaWidthPercentage =
        0.9, // New parameter for Q&A section width as percentage
    this.initialPiecesToReveal = 11, // Number of pieces to reveal at the start
  });

  final double? width;
  final double? height; // Overall height constraint for the custom widget
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
  final Future<dynamic> Function(bool isCorrect) onAnswerCallback;
  final String imageUrl;
  final int puzzleColumns;
  final int puzzleRows;
  final double pieceSpacing;
  final double pieceBorderRadius;
  final int puzzleContentFlex;
  final int qaContentFlex;
  final double puzzleFrameWidthPercentage; // New parameter
  final double qaWidthPercentage; // New parameter
  final int initialPiecesToReveal; // New parameter for initial reveals

  @override
  State<PuzzleQuiz> createState() => _PuzzleQuizState();
}

class _PuzzleQuizState extends State<PuzzleQuiz> {
  late Set<int> _revealedPieces;
  String? _selectedAnswerText;
  bool? _isCorrectAnswer;
  late Random _random; // Instantiate Random once

  @override
  void initState() {
    super.initState();
    _revealedPieces = {};
    _random = Random(); // Initialize Random
    // Reveal initial pieces based on the parameter
    _revealMultipleRandomPieces(widget.initialPiecesToReveal);
  }

  // Helper method to reveal multiple pieces
  void _revealMultipleRandomPieces(int count) {
    final totalPieces = widget.puzzleColumns * widget.puzzleRows;
    for (int i = 0; i < count; i++) {
      if (_revealedPieces.length < totalPieces) {
        int randomPieceIndex;
        do {
          randomPieceIndex = _random.nextInt(totalPieces); // Use the instance
        } while (_revealedPieces.contains(randomPieceIndex));
        _revealedPieces.add(randomPieceIndex);
      } else {
        break; // All pieces revealed, stop trying to add more
      }
    }
  }

  // Original method to reveal one piece, called after a correct answer
  void _revealRandomPiece() {
    final totalPieces = widget.puzzleColumns * widget.puzzleRows;
    if (_revealedPieces.length < totalPieces) {
      int randomPieceIndex;
      do {
        randomPieceIndex = _random.nextInt(totalPieces); // Use the instance
      } while (_revealedPieces.contains(randomPieceIndex));
      setState(() {
        _revealedPieces.add(randomPieceIndex);
      });
    } else {
      // All pieces are revealed, puzzle is complete
    }
  }

  void _handleAnswer(String selectedAnswerText, int selectedAnswerIndex) async {
    if (_selectedAnswerText != null) return; // Prevent multiple selections

    setState(() {
      _selectedAnswerText = selectedAnswerText;
      _isCorrectAnswer = (selectedAnswerIndex == widget.correctAnswerIndex);
    });

    await Future.delayed(const Duration(milliseconds: 700));

    if (_isCorrectAnswer!) {
      _revealRandomPiece(); // Reveal one more piece on correct answer
    }

    await widget.onAnswerCallback(_isCorrectAnswer!);

    setState(() {
      _selectedAnswerText = null;
      _isCorrectAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double overallWidgetHeight = widget.height ?? (screenHeight * 0.70);

    // Calculate actual widths based on percentages of screen width
    final double puzzleActualWidth =
        screenWidth * widget.puzzleFrameWidthPercentage;
    final double qaActualWidth = screenWidth * widget.qaWidthPercentage;

    // The overall widget width should encompass both
    final double overallWidgetWidth = max(puzzleActualWidth, qaActualWidth);

    // Account for SizedBox heights to ensure flexible heights are accurate
    // totalFlexibleHeight is the height available for puzzle and QA *after* fixed spacing
    final double totalFlexibleHeight =
        overallWidgetHeight - 12.0 - 20.0; // 12.0 (top) + 20.0 (middle)

    final double puzzleAreaHeight = totalFlexibleHeight *
        (widget.puzzleContentFlex /
            (widget.puzzleContentFlex + widget.qaContentFlex));
    final double qaAreaHeight = totalFlexibleHeight *
        (widget.qaContentFlex /
            (widget.puzzleContentFlex + widget.qaContentFlex));

    final double pieceWidth = puzzleActualWidth / widget.puzzleColumns;
    final double pieceHeight = puzzleAreaHeight / widget.puzzleRows;

    final double innerPieceWidth = pieceWidth - (widget.pieceSpacing * 2);
    final double innerPieceHeight = pieceHeight - (widget.pieceSpacing * 2);

    final totalPieces = widget.puzzleColumns * widget.puzzleRows;
    final bool puzzleIsComplete = _revealedPieces.length == totalPieces;

    return Container(
      width:
          overallWidgetWidth, // Set overall widget width to the max of the two
      height: overallWidgetHeight,
      alignment: Alignment
          .center, // Center the content horizontally if overall width is larger
      child: Column(
        children: [
          const SizedBox(height: 12.0),
          Expanded(
            flex: widget.puzzleContentFlex,
            child: Align(
              // Use Align to center the puzzle horizontally
              alignment: Alignment.center,
              child: Container(
                width:
                    puzzleActualWidth, // Use the calculated puzzleActualWidth
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius:
                      BorderRadius.circular(widget.pieceBorderRadius * 2),
                  border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate, width: 1),
                ),
                child: Stack(
                  children: List.generate(totalPieces, (index) {
                    final int row = index ~/ widget.puzzleColumns;
                    final int col = index % widget.puzzleColumns;

                    return Positioned(
                      left: col * pieceWidth + widget.pieceSpacing,
                      top: row * pieceHeight + widget.pieceSpacing,
                      width: innerPieceWidth,
                      height: innerPieceHeight,
                      child: AnimatedOpacity(
                        opacity: _revealedPieces.contains(index) ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius:
                                BorderRadius.circular(widget.pieceBorderRadius),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 0.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: _revealedPieces.contains(index)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      widget.pieceBorderRadius),
                                  child: Stack(
                                    // Reverted to Stack for image positioning
                                    children: [
                                      Positioned(
                                        // These offsets are relative to the *full* image
                                        left: -(col * pieceWidth),
                                        top: -(row * pieceHeight),
                                        child: Image.network(
                                          widget.imageUrl,
                                          // The image itself must be scaled to the full puzzle's dimensions.
                                          // The Positioned widget then shifts this larger image.
                                          width: puzzleActualWidth,
                                          height: puzzleAreaHeight,
                                          fit: BoxFit
                                              .cover, // Ensures the image fills, potentially cropping
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              Center(
                                                  child: Icon(
                                                      Icons.broken_image,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          if (puzzleIsComplete) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Puzzle Complete! You\'ve won!',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          // This SizedBox provides fixed spacing between the puzzle and the Q&A
          const SizedBox(height: 20),
          Expanded(
            flex: widget.qaContentFlex,
            child: Align(
              alignment: Alignment.center, // Center the Q&A horizontally
              child: Container(
                // Wrap Q&A content in a Container to apply width
                width: qaActualWidth, // Apply the Q&A specific width
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          widget.question,
                          style: FlutterFlowTheme.of(context).titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(widget.answers.length, (index) {
                        final answer = widget.answers[index];
                        Color? buttonColor;
                        if (_selectedAnswerText != null) {
                          if (answer == _selectedAnswerText) {
                            buttonColor = _isCorrectAnswer!
                                ? FlutterFlowTheme.of(context).success
                                : FlutterFlowTheme.of(context).error;
                          } else if (index == widget.correctAnswerIndex &&
                              _isCorrectAnswer == false) {
                            // CORRECTED: When user chose wrong, highlight the correct answer with success color
                            buttonColor = FlutterFlowTheme.of(context).success;
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 20.0),
                          child: InkWell(
                            onTap: _selectedAnswerText == null
                                ? () => _handleAnswer(answer, index)
                                : null,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: buttonColor ??
                                    FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: buttonColor == null
                                      ? FlutterFlowTheme.of(context).alternate
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 20),
                              child: Text(
                                answer,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: buttonColor != null
                                          ? Colors.white
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                    ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
