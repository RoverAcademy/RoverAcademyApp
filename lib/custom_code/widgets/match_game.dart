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

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
import 'dart:async';
import 'dart:math' as math;

// --- MODIFIED FlipCard WIDGET ---
// Based on your provided FlipCard, with additions for programmatic control and callbacks

class ModifiedFlipCard extends StatefulWidget {
  const ModifiedFlipCard({
    Key? key,
    this.width,
    this.height,
    required this.frontWidget,
    required this.backWidget,
    this.flipAxis, // "X" or "Y" (defaults to "Y")
    this.animationDurationMs, // defaults to 500
    this.onFlip,
    this.initiallyFlipped = false,
    this.isInteractionDisabled = false, // To disable tap
  }) : super(key: key);

  final double? width;
  final double? height;
  final Widget Function() frontWidget;
  final Widget Function() backWidget;
  final String? flipAxis;
  final int? animationDurationMs;
  final void Function(bool isFrontVisible)? onFlip;
  final bool initiallyFlipped;
  final bool isInteractionDisabled;

  @override
  ModifiedFlipCardState createState() => ModifiedFlipCardState();
}

class ModifiedFlipCardState extends State<ModifiedFlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late bool _isFrontFaceVisible;

  @override
  void initState() {
    super.initState();
    _isFrontFaceVisible = !widget.initiallyFlipped;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDurationMs ?? 500),
    );

    if (widget.initiallyFlipped) {
      _controller.value = 1.0; // Start with back visible
    }

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  void didUpdateWidget(ModifiedFlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initiallyFlipped != oldWidget.initiallyFlipped) {
      // If external state demands a flip, reflect it
      if (widget.initiallyFlipped && _isFrontFaceVisible) {
        _flipCardInternal(triggerCallback: false); // Flip to back
      } else if (!widget.initiallyFlipped && !_isFrontFaceVisible) {
        _flipCardInternal(triggerCallback: false); // Flip to front
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCardInternal({bool triggerCallback = true}) {
    if (_controller.isAnimating) return;

    if (_isFrontFaceVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFrontFaceVisible = !_isFrontFaceVisible;
    if (triggerCallback) {
      widget.onFlip?.call(_isFrontFaceVisible);
    }
  }

  // Public method to trigger flip, respects isInteractionDisabled
  void flip() {
    if (widget.isInteractionDisabled) return;
    _flipCardInternal();
  }

  // Programmatic flip to front
  void flipToFront() {
    if (!_isFrontFaceVisible) {
      _flipCardInternal(
          triggerCallback: false); // Usually internal, no callback
    }
  }

  // Programmatic flip to back
  void flipToBack() {
    if (_isFrontFaceVisible) {
      _flipCardInternal(
          triggerCallback: false); // Usually internal, no callback
    }
  }

  bool get isCurrentlyFrontVisible => _isFrontFaceVisible;

  Matrix4 _getTransformMatrix() {
    final angle = _animation.value * math.pi;
    // Apply perspective to make the flip more 3D
    Matrix4 transform = Matrix4.identity()..setEntry(3, 2, 0.001);
    if (widget.flipAxis?.toLowerCase() == 'x') {
      transform.rotateX(angle);
    } else {
      transform.rotateY(angle); // Default to Y axis flip
    }
    return transform;
  }

  Widget _buildFlippingContent() {
    final bool showFront = _animation.value < 0.5;
    Widget displayWidget;

    if (showFront) {
      displayWidget = widget.frontWidget();
    } else {
      // Pre-rotate the back widget so it's correctly oriented after the main flip
      Matrix4 backRotation = Matrix4.identity();
      if (widget.flipAxis?.toLowerCase() == 'x') {
        backRotation.rotateX(math.pi);
      } else {
        backRotation.rotateY(math.pi);
      }
      displayWidget = Transform(
        alignment: Alignment.center,
        transform: backRotation,
        child: widget.backWidget(),
      );
    }
    return displayWidget;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isInteractionDisabled ? null : flip,
      child: SizedBox(
        width: widget.width ?? 180,
        height: widget.height ?? 180,
        child: Transform(
          transform: _getTransformMatrix(),
          alignment: Alignment.center,
          child: _buildFlippingContent(),
        ),
      ),
    );
  }
}

// --- ShakeWidget ---
class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.shakeCount = 3,
    this.shakeOffset = 8.0,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final int shakeCount;
  final double shakeOffset;

  @override
  ShakeWidgetState createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut, // A springy curve for shake
      ),
    );
  }

  void shake() {
    if (mounted && !_controller.isAnimating) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        if (_animation.value == 0.0 || _animation.value == 1.0) {
          // No translation if not shaking or finished
          return child!;
        }
        // A simple horizontal shake.
        // The sine wave creates oscillations, multiplied by a decaying envelope (1 - _animation.value)
        final double offsetX =
            math.sin(widget.shakeCount * 2 * math.pi * _animation.value) *
                widget.shakeOffset *
                (1 - _animation.value); // Ensure shake intensity decreases
        return Transform.translate(
          offset: Offset(offsetX, 0),
          child: child,
        );
      },
    );
  }
}

// --- GameTile Data Class (Helper for MatchGame) ---
class GameTile {
  final int id; // Unique ID for the tile position
  final String
      term; // The term on the back of the tile (either a question or an answer)
  final String pairId; // NEW: Identifier to link a question to its answer
  bool isFlipped; // Is the tile currently showing its back?
  bool isMatched; // Has this tile been successfully matched?
  bool isVisible; // Used for fade-out effect
  final GlobalKey<ModifiedFlipCardState> flipCardKey;
  final GlobalKey<ShakeWidgetState> shakeKey;

  GameTile({
    required this.id,
    required this.term,
    required this.pairId, // Now required
    this.isFlipped = false,
    this.isMatched = false,
    this.isVisible = true,
    required this.flipCardKey,
    required this.shakeKey,
  });
}

/// --- MatchGame WIDGET ---
class MatchGame extends StatefulWidget {
  const MatchGame({
    super.key,
    this.width,
    this.height,
    this.terms, // Expected: List of 12 strings (6 Q/A pairs)
    this.coverImage, // URL or asset path for tile front
    this.gridCrossAxisCount, // e.g., 3 for 3 columns
    this.tileAspectRatio, // e.g., 1.0 for square tiles
    this.onGameOver, // Callback for Game Over event
  });

  final double? width;
  final double? height;
  final List<String>? terms;
  final String? coverImage;
  final int? gridCrossAxisCount;
  final double? tileAspectRatio;
  // onGameOver now accepts game statistics and is NOT nullable
  final Future<dynamic> Function(String formattedTime, int totalSeconds)?
      onGameOver;

  @override
  State<MatchGame> createState() => _MatchGameState();
}

class _MatchGameState extends State<MatchGame> {
  // Default terms now represent 6 Q/A pairs (12 elements total)
  static const List<String> _defaultTerms = [
    "Question 1",
    "Answer 1",
    "Question 2",
    "Answer 2",
    "Question 3",
    "Answer 3",
    "Question 4",
    "Answer 4",
    "Question 5",
    "Answer 5",
    "Question 6",
    "Answer 6",
  ];

  late List<String> _actualTerms; // This will hold the 12 Q/A strings
  List<GameTile> _gameTiles = [];
  List<int> _selectedTileIndices = [];

  int _score = 0;
  int _pairsFound = 0;
  final int _totalPairs = 6; // Still 6 pairs, but now Q/A pairs

  Stopwatch _stopwatch = Stopwatch();
  Timer? _displayTimer;
  String _elapsedTime = "00:00";
  int _elapsedSeconds = 0; // Store total seconds

  bool _isInitializing = true;
  bool _processingMatch = false;
  bool _gameOver = false; // Keep track of game over state internally

  @override
  void initState() {
    super.initState();
    _initializeGame(); // Call _initializeGame once when the widget is created
  }

  @override
  void didUpdateWidget(covariant MatchGame oldWidget) {
    super.didUpdateWidget(oldWidget);

    // This is the crucial part: Check if the terms have changed.
    bool termsChanged = false;
    if (widget.terms?.length != oldWidget.terms?.length) {
      termsChanged = true;
    } else if (widget.terms != null && oldWidget.terms != null) {
      // Check if any element is different
      for (int i = 0; i < widget.terms!.length; i++) {
        if (widget.terms![i] != oldWidget.terms![i]) {
          termsChanged = true;
          break;
        }
      }
    } else if (widget.terms == null && oldWidget.terms != null ||
        widget.terms != null && oldWidget.terms == null) {
      // One was null and the other wasn't (e.g., terms were null, now they're not)
      termsChanged = true;
    }

    // Re-initialize the game only if the terms have changed and we are not currently initializing.
    if (mounted && termsChanged && !_isInitializing) {
      _initializeGame();
    }
  }

  void _initializeGame() {
    setState(() {
      _isInitializing = true; // Set flag to true
      _gameOver = false; // Reset game over state
    });

    List<String> sourceTerms = widget.terms ?? _defaultTerms;

    // Ensure we have exactly 12 terms (6 pairs)
    if (sourceTerms.length != _totalPairs * 2) {
      print(
          "Warning: 'terms' list must contain 12 elements (6 Q/A pairs). Using default terms.");
      _actualTerms = List.from(_defaultTerms);
    } else {
      _actualTerms = List.from(sourceTerms);
    }

    // Create a list of objects that hold both the term and its pairId
    List<Map<String, String>> pairedContents = [];
    for (int i = 0; i < _actualTerms.length; i += 2) {
      String pairId =
          'pair_${i ~/ 2}'; // Generate unique ID for each pair (0, 1, 2, ...)
      pairedContents
          .add({'term': _actualTerms[i], 'pairId': pairId}); // Question
      pairedContents
          .add({'term': _actualTerms[i + 1], 'pairId': pairId}); // Answer
    }

    pairedContents.shuffle(math.Random()); // Shuffle the Q/A pairs together

    _gameTiles = List.generate(
      _totalPairs * 2, // Still 12 tiles
      (index) => GameTile(
        id: index,
        term: pairedContents[index]['term']!,
        pairId: pairedContents[index]['pairId']!, // Assign the generated pairId
        flipCardKey: GlobalKey<ModifiedFlipCardState>(),
        shakeKey: GlobalKey<ShakeWidgetState>(),
      ),
    );

    _selectedTileIndices.clear();
    _score = 0;
    _pairsFound = 0;
    _processingMatch = false;

    _stopwatch.reset();
    _elapsedTime = "00:00";
    _elapsedSeconds = 0; // Reset seconds
    _displayTimer?.cancel();

    // Ensure all state updates are captured for the initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isInitializing = false; // Set flag to false after initialization
        });
      }
    });
  }

  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }
    _displayTimer?.cancel(); // Cancel any existing timer
    _displayTimer = Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      if (!_stopwatch.isRunning) {
        timer.cancel();
      }
      if (mounted) {
        setState(() {
          // Update _elapsedSeconds as well
          _elapsedSeconds = _stopwatch.elapsed.inSeconds;
          _elapsedTime = _formatDuration(_stopwatch.elapsed);
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  // NEW: A base widget to provide the consistent card frame
  Widget _buildCardFrame({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context)
            .secondaryBackground, // The fill color inside the border
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.red, // The red border
          width: 2,
        ),
      ),
      child: child,
    );
  }

  // MODIFIED: _buildCoverImageContent now only handles the image itself
  Widget _buildCoverImageContent() {
    if (widget.coverImage == null || widget.coverImage!.isEmpty) {
      return Center(
          child: Icon(Icons.image_search,
              color: FlutterFlowTheme.of(context).primaryBackground, size: 40));
    }
    if (widget.coverImage!.toLowerCase().startsWith('http://') ||
        widget.coverImage!.toLowerCase().startsWith('https://')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          widget.coverImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey,
              child: Icon(Icons.error_outline, color: Colors.white, size: 30)),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          widget.coverImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey,
              child: Icon(Icons.error_outline, color: Colors.white, size: 30)),
        ),
      );
    }
  }

  // MODIFIED: _buildTermContent now only handles the text itself
  Widget _buildTermContent(String term) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          term,
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                color: FlutterFlowTheme.of(context)
                    .primaryText, // Assuming this is a good contrast for your card fill
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  void _onTileFlipped(int index, bool isNowFrontVisible) {
    if (_isInitializing || _gameOver || _processingMatch) return;

    GameTile currentTile = _gameTiles[index];
    if (currentTile.isMatched) {
      return;
    }

    if (!_stopwatch.isRunning) {
      _startTimer();
    }

    bool tileJustFlippedToBack = !isNowFrontVisible;

    if (tileJustFlippedToBack) {
      if (_selectedTileIndices.length < 2 &&
          !_selectedTileIndices.contains(index)) {
        _selectedTileIndices.add(index);
        currentTile.isFlipped = true;
      } else {
        currentTile.flipCardKey.currentState?.flipToFront();
      }
    } else {
      if (_selectedTileIndices.contains(index)) {
        _selectedTileIndices.remove(index);
      }
      currentTile.isFlipped = false;
    }

    setState(() {});

    if (_selectedTileIndices.length == 2) {
      _processingMatch = true;
      setState(() {});
      _checkForMatch();
    }
  }

  void _checkForMatch() {
    if (_selectedTileIndices.length != 2) {
      _processingMatch = false;
      setState(() {});
      return;
    }

    final int index1 = _selectedTileIndices[0];
    final int index2 = _selectedTileIndices[1];
    final GameTile tile1 = _gameTiles[index1];
    final GameTile tile2 = _gameTiles[index2];

    if (tile1.pairId == tile2.pairId && tile1.id != tile2.id) {
      // Match found (Q/A pair)
      setState(() {
        tile1.isMatched = true;
        tile2.isMatched = true;
        _score += 10;
        _pairsFound++;
        _selectedTileIndices.clear(); // Clear immediately
        _processingMatch = false; // Release processing lock
      });

      // NEW: Add a short delay before starting the fade-out
      Future.delayed(Duration(milliseconds: 600), () {
        // See matched cards for 0.6 seconds
        if (!mounted) return;
        setState(() {
          tile1.isVisible = false;
          tile2.isVisible = false;
        });

        // Check for game over AFTER the fade-out logic has been initiated
        if (_pairsFound == _totalPairs) {
          _gameOver = true;
          _stopwatch.stop();
          _displayTimer?.cancel();
          widget.onGameOver?.call(_elapsedTime, _elapsedSeconds);
        }
      });
    } else {
      // No match
      Future.delayed(Duration(milliseconds: 500), () {
        if (!mounted) return;
        tile1.shakeKey.currentState?.shake();
        tile2.shakeKey.currentState?.shake();

        Future.delayed(Duration(milliseconds: 800), () {
          if (!mounted) return;
          tile1.flipCardKey.currentState?.flipToFront();
          tile2.flipCardKey.currentState?.flipToFront();

          tile1.isFlipped = false;
          tile2.isFlipped = false;

          _selectedTileIndices.clear();
          _processingMatch = false;
          if (mounted) setState(() {});
        });
      });
    }
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _displayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return Center(
          child: CircularProgressIndicator(
              color: FlutterFlowTheme.of(context).primary));
    }

    final crossAxisCount = widget.gridCrossAxisCount ?? 3;
    final tileAspectRatio = widget.tileAspectRatio ?? 1.0;

    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Score and Timer Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Score: $_score',
                  style: FlutterFlowTheme.of(context).headlineSmall,
                ),
                Text(
                  _elapsedTime,
                  style: FlutterFlowTheme.of(context).headlineSmall,
                ),
              ],
            ),
          ),
          // Game Grid (only visible if not game over)
          if (!_gameOver)
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: tileAspectRatio,
                ),
                itemCount: _gameTiles.length,
                itemBuilder: (context, index) {
                  final tile = _gameTiles[index];
                  bool interactionDisabled = tile.isMatched ||
                      _processingMatch || // Disable all if processing match
                      _gameOver ||
                      (tile.isFlipped && !_selectedTileIndices.contains(index));

                  return AnimatedOpacity(
                    opacity: tile.isVisible ? 1.0 : 0.0,
                    // MODIFIED: Increased fade out duration
                    duration: Duration(milliseconds: 700), // Slower fade-out
                    child: tile.isVisible
                        ? ShakeWidget(
                            key: tile.shakeKey,
                            child: ModifiedFlipCard(
                              key: tile.flipCardKey,
                              // Front side: card frame + image content
                              frontWidget: () => _buildCardFrame(
                                child: _buildCoverImageContent(),
                              ),
                              // Back side: card frame + text content
                              backWidget: () => _buildCardFrame(
                                child: _buildTermContent(tile.term),
                              ),
                              onFlip: (isFrontVisible) =>
                                  _onTileFlipped(index, isFrontVisible),
                              initiallyFlipped: tile.isFlipped,
                              isInteractionDisabled: interactionDisabled,
                            ),
                          )
                        : SizedBox.shrink(), // If not visible, show empty space
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
