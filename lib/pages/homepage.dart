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
    Overlay.of(context).insert(_overlayEntry);
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

  late List<String> questions;
  late List<Widget> questionTiles = [];
  late List<String?> response = List.filled(15, null); // Initialize with nulls
  int _selectedStreamIndex = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _startTimer();

    // Initialize the list of questions
    questions = [
      "What was your class 10 percentage?",
      "What was your stream?",
      "What was your class 11 percentage?",
      "What was your class 12 percentage?",
      "Interested in drawing/arts?",
      "Interested in sports?",
      "Were you good in playing any sport?",
      "Did you like coding when you were in 11th?",
      "Rate your patriotism on a scale from 1-100",
      "Rate your communication skills from 1-100",
      "Do you like singing/dancing?",
      "Rate your reading & writing skills",
      "Rate your negotiating skills from 1-100",
      "What is your hobby?",
      "Which field you are pursuing right now?"
    ];

    // Generate list of QuestionTile widgets
    questionTiles = List.generate(
      questions.length,
          (index) => buildQuestionTile(index),
    );
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

  Widget buildQuestionTile(int index) {
    late Widget inputWidget;
    // Determine input widget based on index
    if (index == 0 || index == 2 || index == 3 || index == 8 || index == 9 || index == 12) {
      inputWidget = TextField(
        keyboardType: TextInputType.number, // Specify numeric keyboard type
        onChanged: (value) {
          // Handle text field value change
          // You can convert the value to int or double here
          // For example:
          // int numericValue = int.tryParse(value) ?? 0;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.percent_outlined),
          border: OutlineInputBorder(),
        ),
      );
    } else if (index == 1) {
      // Radio buttons for stream
      inputWidget = Column(
        children: [
          RadioListTile<int>(
            onChanged: (int? value) {
              setState(() {
                _selectedStreamIndex = value ?? 1; // Update selected stream index
                print(_selectedStreamIndex);
              });
            },
            title: Text("Science(PCM)"),
            value: 1,
            groupValue: _selectedStreamIndex,
          ),
          RadioListTile<int>(
            onChanged: (int? value) {
              setState(() {
                _selectedStreamIndex = value ?? 1; // Update selected stream index
                print(_selectedStreamIndex);

              });
            },
            title: Text("Science(PCMB)"),
            value: 2,
            groupValue: _selectedStreamIndex,
          ),
          RadioListTile<int>(
            onChanged: (int? value) {
              setState(() {
                _selectedStreamIndex = value ?? 1; // Update selected stream index
                print(_selectedStreamIndex);

              });
            },
            title: Text("Arts/Humanities"),
            value: 3,
            groupValue: _selectedStreamIndex,
          ),
          RadioListTile<int>(
            onChanged: (int? value) {
              setState(() {
                _selectedStreamIndex = value ?? 1; // Update selected stream index
                print(_selectedStreamIndex);

              });
            },
            title: Text("Commerce"),
            value: 4,
            groupValue: _selectedStreamIndex,
          ),
          RadioListTile<int>(
            onChanged: (int? value) {
              setState(() {
                _selectedStreamIndex = value ?? 1; // Update selected stream index
                print(_selectedStreamIndex);

              });
            },
            title: Text("Science(PCB)"),
            value: 5,
            groupValue: _selectedStreamIndex,
          ),
        ],
      );
    } else if (index == 4 || index == 5 || index == 6 || index == 7 || index == 10 || index == 11) {
      // Yes/No radio buttons for specific indices
      inputWidget = Column(
        children: [
          RadioListTile<String>(
            onChanged: (String? value) {
              setState(() {
                response[index] = value; // Update the response list with the selected value
              });
            },
            title: Text("Yes"),
            value: "Yes",
            groupValue: response[index], // Use response[index] as the groupValue
          ),
          RadioListTile<String>(
            onChanged: (String? value) {
              setState(() {
                response[index] = value;
              });
            },
            title: Text("No"),
            value: "No",
            groupValue: response[index], // Use response[index] as the groupValue
          ),
        ],
      );
    } else if (index == 13) {
      // Radio buttons for specific options
      inputWidget = TextField(
        decoration: InputDecoration(
          hintText: "Example ~Bowling",
          border: OutlineInputBorder(),
        ),
      );

    } else if (index == 14) {
      // TextField for index 14
      inputWidget = TextField(
        decoration: InputDecoration(
          hintText: "Example ~Engineering",
          border: OutlineInputBorder(),
        ),
      );
    } else {
      // TextField for other indices
      inputWidget = TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      );
    }

    return QuestionTile(question: questions[index], index: index, inputWidget: inputWidget);
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(22.0),
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
                    style: GoogleFonts.lato(
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
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Questions",
              style: GoogleFonts.lato(
                fontSize: 24.5,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          for (int index = 0; index < questions.length; index++)
            buildQuestionTile(index),

          // Add a submit button that saves as CSV file
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 12),
            child: MaterialButton(
              onPressed: () {
                print("Submit as CSV");
              },
              color: Colors.deepPurple,
              padding: EdgeInsets.symmetric(vertical: 22),
              child: Text(
                "Submit",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

