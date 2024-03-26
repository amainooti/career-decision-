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
  late List<String?> response = List.filled(14, null); // Initialize with nulls
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
          print("Question $index, Value: $value");
          setState(() {
            response[index] = value.isNotEmpty
                ? value
                : null; // Update the response list with the text field value or null if empty
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.percent_outlined),
          border: OutlineInputBorder(),
          errorText: (index == 0 ||
              index == 2 ||
              index == 3 ||
              index == 8 ||
              index == 9 ||
              index == 11 ||
              index == 12) &&
              response[index] != null &&
              (int.tryParse(response[index]!) == null ||
                  int.parse(response[index]!) < 20)
              ? 'Score should be greater than or equal to 20'
              : (index == 0 ||
              index == 2 ||
              index == 3 ||
              index == 8 ||
              index == 9 ||
              index == 11 ||
              index == 12) &&
              response[index] != null &&
              int.parse(response[index]!) > 100
              ? 'Score should be less than or equal to 100'
              : null,
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
                    value ??
                        "Science(PCM)"; // Update the response list with the selected value
                print("Question $index, Value: $value");
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
                    value ??
                        "Science(PCMB)"; // Update the response list with the selected value
                print("Question $index, Value: $value");
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
                    value ??
                        "Arts/Humanities"; // Update the response list with the selected value
                print("Question $index, Value: $value");
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
                    value ??
                        "Commerce"; // Update the response list with the selected value
                print("Question $index, Value: $value");
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
                    value ??
                        "Science(PCB)"; // Update the response list with the selected value
                print("Question $index, Value: $value");
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
                print("Question $index, Value: $value");
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
                print("Question $index, Value: $value");
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
        onChanged: (value) {
          setState(() {
            response[index] = value.isNotEmpty
                ? value
                : null; // Update the response list with the text field value or null if empty
            print("Question $index, Value: $value");
          });
        },
        controller: textControllers[index],
        decoration: InputDecoration(
          hintText: "Example ~Bowling",
          border: OutlineInputBorder(),
          errorText: response[index] == null ? 'Please enter a value' : null,
        ),
      );
    } else {
      // TextField for other indices
      inputWidget = TextField(
        onChanged: (value) {
          setState(() {
            response[index] = value.isNotEmpty
                ? value
                : null; // Update the response list with the text field value or null if empty
            print("Question $index, Value: $value");
          });
        },
        controller: textControllers[index],
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          errorText: response[index] == null ? 'Please enter a value' : null,

        ),
      );
    }

    return QuestionTile(
      question: questions[index],
      index: index,
      inputWidget: inputWidget,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
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
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 12),
            child: MaterialButton(
              onPressed: () async {
                bool allFilled = true;
                List<int> unfilledQuestions = [];
                for (int i = 0; i < response.length; i++) {
                  if (response[i] == null ||
                      (response[i] is String && response[i]!.isEmpty)) {
                    allFilled = false;
                    unfilledQuestions.add(i + 1);
                  }
                }
                // Inside the onPressed callback of your submit button
                if (allFilled) {
                  // All fields are filled, proceed with submitting data
                  print("Submitted as Array");
                  // Print out the list of responses
                  print(response);
                  String recommendation = calculateRecommendation(response);
                  print("Recommendation: $recommendation");

                  // Display recommendation as a widget with an icon
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AlertDialog(
                          title: Text("Recommendation 🤖"),
                          content: Row(
                            children: [
                              Icon(Icons.check, color: Colors.green),
                              SizedBox(width: 10),
                              Text(recommendation),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text("Close"),
                            ),
                          ],
                        ),
                  );
                } else {
                  // Show error message
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AlertDialog(
                          title: Text("Error ❌"),
                          content: Text("Please fill in all questions!"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text("Close"),
                            ),
                          ],
                        ),
                  );
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

  String calculateRecommendation(List<String?> responses) {
    // Extract relevant responses for easier access
    String stream = responses[1] ?? ""; // Stream selection
    int? class12Percentage = int.tryParse(responses[3] ?? ""); // Class 12 percentage
    String? hobby = responses[13]; // Hobby

    // Regular expressions to match hobby patterns
    RegExp engineeringRegex = RegExp(
        r"(engineer|engineering|mechanic|machine|robot|robotics|electronic|mechanical|aeronautics|aircraft)",
        caseSensitive: false);
    RegExp medicalRegex = RegExp(
        r"(medical|medicine|doctor|hospital|clinic|surgeon|physician|biomedical|biotech)",
        caseSensitive: false);
    RegExp lawRegex = RegExp(
        r"(law|lawyer|legal|court|justice|attorney|advocate)",
        caseSensitive: false);
    RegExp businessRegex = RegExp(
        r"(business|finance|economics|trade|market|investment|entrepreneur)",
        caseSensitive: false);
    RegExp artsRegex =
    RegExp(r"(art|artist|paint|painting|draw|drawing|music|dance|singer|dancing)",
        caseSensitive: false);
    RegExp politicalScienceRegex = RegExp(
        r"(political science|politics|government|political|public administration)",
        caseSensitive: false);

    // Check if hobby matches certain patterns
    bool hobbyInvolvesEngineering = engineeringRegex.hasMatch(hobby ?? "");
    bool hobbyInvolvesMedical = medicalRegex.hasMatch(hobby ?? "");
    bool hobbyInvolvesLaw = lawRegex.hasMatch(hobby ?? "");
    bool hobbyInvolvesBusiness = businessRegex.hasMatch(hobby ?? "");
    bool hobbyInvolvesArts = artsRegex.hasMatch(hobby ?? "");
    bool hobbyInvolvesPoliticalScience =
    politicalScienceRegex.hasMatch(hobby ?? "");

    // Additional conditions for more specific recommendations
    if (stream == "Science(PCMB)") {
      // For PCMB stream
      if (class12Percentage != null && class12Percentage >= 80 &&
          hobbyInvolvesMedical) {
        // Very high score in class 12 and hobby involves medical
        return "Medicine";
      } else if (class12Percentage != null && class12Percentage >= 70 &&
          hobbyInvolvesEngineering) {
        // High score in class 12 and hobby involves engineering
        return "Aeronautics";
      } else {
        // Recommend other science-related fields
        return "Biotech or Env Science";
      }
    } else if (stream == "Science(PCB)") {
      // For PCB stream
      if (class12Percentage != null && class12Percentage >= 80 &&
          hobbyInvolvesMedical) {
        // Very high score in class 12 and hobby involves medical
        return "Medicine";
      } else {
        // Recommend other medical science-related fields
        return "Biomedical Engineering";
      }
    } else if (stream == "Science(PCM)") {
      // For PCM stream
      if (class12Percentage != null && class12Percentage >= 70 &&
          hobbyInvolvesEngineering) {
        // High score in class 12 and hobby involves engineering
        return "Engineering";
      } else {
        // Recommend engineering without specifying a field
        return "Engineering";
      }
    } else if (stream == "Commerce") {
      // For Commerce stream
      if (class12Percentage != null && class12Percentage >= 70 &&
          hobbyInvolvesBusiness) {
        // High score in class 12 and hobby involves business
        return "Finance";
      } else {
        // Recommend business-related fields
        return "Business Administration";
      }
    } else if (stream == "Arts/Humanities") {
      // For Arts/Humanities stream
      if (class12Percentage != null && class12Percentage >= 70 &&
          hobbyInvolvesLaw) {
        // High score in class 12 and hobby involves law
        return "Law";
      } else if (class12Percentage != null && class12Percentage >= 70 &&
          hobbyInvolvesPoliticalScience) {
        // High score in class 12 and hobby involves political science
        return "Political Science";
      } else {
        // Recommend other arts-related fields
        return "Sociology or History";
      }
    } else {
      return "Not determined";
    }
  }





}
// Future<void> _saveAsCSV(List<List<dynamic>> rows) async {
//   String csv = const ListToCsvConverter().convert(rows);
//   final directory = await getApplicationDocumentsDirectory();
//   final path = '${directory.path}/survey_data.csv';
//   File file = File(path);
//   await file.writeAsString(csv);
//   print('CSV file saved to $path');
// }


