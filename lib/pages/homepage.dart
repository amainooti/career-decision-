import 'dart:async';
import 'package:flutter/material.dart';
import 'package:career_recommendation_system/components/question_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomToast extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;

  CustomToast({
    required this.message,
    this.backgroundColor = Colors.black54,
    this.textColor = Colors.white,
  });

  @override
  _CustomToastState createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast> {
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = _createOverlayEntry();
    _showOverlay();
  }

  @override
  void dispose() {
    _overlayEntry.remove();
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 100, // Adjust position as needed
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              widget.message,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay() {
    Overlay.of(context)?.insert(_overlayEntry);
    // Remove the toast after 2.5 seconds
    Timer(Duration(milliseconds: 2500), () {
      _overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(); // Placeholder widget, actual content is added to overlay
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _startTimer();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer.cancel(); // Cancel the timer when disposing the widget
    super.dispose();
  }

  void _onScroll() {
    // You can keep this method if you still need scroll-related functionality
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      CustomToast(
        message: "You're almost there!",
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> questions = List.generate(15, (index) => QuestionTile(index: index));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: Center(child: Icon(Icons.menu, color: Colors.white)),
        title: Text(
          "Survey Data",
          style: GoogleFonts.lato(fontSize: 18.5, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 22),
            child: Icon(Icons.book, color: Colors.white),
          )
        ],
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '*  ',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: 'Fill in all questions before hitting submit',
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Questions",
              style: GoogleFonts.lato(
                fontSize: 20.5,
              ),
            ),
          ),
          //  map the data here also use the index in a row widget for it to look like 1. Question 1 info
          ...questions
        ],
      ),
    );
  }
}
