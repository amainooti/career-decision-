import 'dart:async';
import 'package:career_recommendation_system/components/question_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
  late List<TextEditingController> textControllers =
  List.generate(15, (index) => TextEditingController());

  String _selectedStreamIndex = "Science(PCM)";

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
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    // You can keep this method if you still need scroll-related functionality
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(hours: 1), (timer) {
      print("You're almost there!");
    });
  }

  Widget buildQuestionTile(int index) {
    late Widget inputWidget;
    // Determine input widget based on index
    if (index == 0 ||
        index == 2 ||
        index == 3 ||
        index == 8 ||
        index == 9 ||
        index == 11 ||
        index == 12) {
      inputWidget = TextField(
        controller: textControllers[index],
        keyboardType: TextInputType.number, // Specify numeric keyboard type
        onChanged: (value) {
          // Handle text field value change
          setState(() {
            response[index] = value.isNotEmpty
                ? value
                : null; // Update the response list with the text field value or null if empty
          });
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
          RadioListTile<String>(
            onChanged: (String? value) {
              setState(() {
                _selectedStreamIndex =
                    value ?? "Science(PCM)"; // Update selected stream index
                response[index] =
                    value ?? "Science(PCM)"; // Update the response list with the selected value
                print(_selectedStreamIndex);
              });
            },
            title: Text("Science(PCM)"),
            value: "Science(PCM)",
            groupValue: _selectedStreamIndex,
          ),
          RadioListTile<String>(
            onChanged: (String? value) {
              setState(() {
                _selectedStreamIndex =
                    value ?? "Science(PCMB)"; // Update selected stream index
                response[index] =
                    value ?? "Science(PCMB)"; // Update the response list with the selected value
                print(_selectedStreamIndex);
              });
            },
            title: Text("Science(PCMB)"),
            value: "Science(PCMB)",
            groupValue: _selectedStreamIndex,
          ),
          RadioListTile<String>(
            onChanged: (String? value) {
              setState(() {
                _selectedStreamIndex =
                    value ?? "Arts/Humanities"; // Update selected stream index
                response[index] =
                    value ?? "Arts/Humanities"; // Update the response list with the selected value
                print(_selectedStreamIndex);
              });
            },
            title: Text("Arts/Humanities"),
            value: "Arts/Humanities",
            groupValue: _selectedStreamIndex,
          ),
          RadioListTile<String>(
            onChanged: (String? value) {
              setState(() {
                _selectedStreamIndex =
                    value ?? "Commerce"; // Update selected stream index
                response[index] =
                    value ?? "Commerce"; // Update the response list with the selected value
                print(_selectedStreamIndex);
              });
            },
            title: Text("Commerce"),
            value: "Commerce",
            groupValue: _selectedStreamIndex,
          ),
          RadioListTile<String>(
            onChanged: (String? value) {
              setState(() {
                _selectedStreamIndex =
                    value ?? "Science(PCB)"; // Update selected stream index
                response[index] =
                    value ?? "Science(PCB)"; // Update the response list with the selected value
                print(_selectedStreamIndex);
              });
            },
            title: Text("Science(PCB)"),
            value: "Science(PCB)",
            groupValue: _selectedStreamIndex,
          ),
        ],
      );
    } else if (index == 4 ||
        index == 5 ||
        index == 6 ||
        index == 7 ||
        index == 10) {
      // Yes/No radio buttons for specific indices
      inputWidget = Column(
        children: [
          RadioListTile<String>(
            onChanged: (String? value) {
              setState(() {
                response[index] =
                    value; // Update the response list with the selected value
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
    } else if
    (index == 13) {
      // Radio buttons for specific options
      inputWidget = TextField(
        onChanged: (value) {
          setState(() {
            response[index] =
            value.isNotEmpty ? value : null; // Update the response list with the text field value or null if empty
          });
        },
        controller: textControllers[index],
        decoration: InputDecoration(
          hintText: "Example ~Bowling",
          border: OutlineInputBorder(),
        ),
      );
    }  else {
      // TextField for other indices
      inputWidget = TextField(
        onChanged: (value) {
          setState(() {
            response[index] =
            value.isNotEmpty ? value : null; // Update the response list with the text field value or null if empty
          });
        },
        controller: textControllers[index],
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      );
    }

    return QuestionTile(
        question: questions[index], index: index, inputWidget: inputWidget);
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
                    text:
                    'Fill in all questions before hitting submit',
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
            padding:
            const EdgeInsets.symmetric(vertical: 25.0, horizontal: 12),
            child: MaterialButton(
              onPressed: () async {
                bool allFilled = true;
                for (var answer in response) {
                  if (answer == null) {
                    allFilled = false;
                    break;
                  }
                }
                if (allFilled) {
                  // All fields are filled, proceed with submitting data
                  print("Submitted as Array");
                  // Print out the list of responses
                  print(response);

                  // List<List<dynamic>> rows = [
                  //   questions,
                  //   response.map((value) => value ?? "").toList()
                  // ];
                  // await _saveAsCSV(rows);
                } else {
                  // Show error message
                  print("Please fill in all questions!");
                  print("There was an Error");
                }
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

// Future<void> _saveAsCSV(List<List<dynamic>> rows) async {
//   String csv = const ListToCsvConverter().convert(rows);
//   final directory = await getApplicationDocumentsDirectory();
//   final path = '${directory.path}/survey_data.csv';
//   File file = File(path);
//   await file.writeAsString(csv);
//   print('CSV file saved to $path');
// }
}

