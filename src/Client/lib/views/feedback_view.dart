import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/feedback_controller.dart';
import 'package:frontend/design/colors.dart';
import 'package:survey_kit/survey_kit.dart';

/*
  A View for displaying a survey, to collect feedback from the customers.
  If completed, the customer gets rewarded with a coupon.
 */

class FeedbackView extends StatefulWidget {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  var task = OrderedTask(id: TaskIdentifier(), steps: [
    InstructionStep(
      title: 'Service Satisfaction Survey',
      text:
          'By filling out this 5-10 minute survey you can help us improve our service and earn yourself a food-voucher for any participating airport!',
      buttonText: 'Start survey',
    ),
    QuestionStep(
      title: '1. Gender',
      text: 'Please choose the one that applies to you.',
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: 'Male', value: 'Male'),
          TextChoice(text: 'Female', value: 'Female'),
          TextChoice(text: 'Non-Binary', value: 'Non-Binary'),
        ],
      ),
    ),
    QuestionStep(
      title: '2. Age Group',
      text: 'Please tell us your age group.',
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: '< 20', value: '<20'),
          TextChoice(text: '20 - 30', value: '20-30'),
          TextChoice(text: '31 - 40', value: '31-40'),
          TextChoice(text: '41 - 50', value: '41-50'),
          TextChoice(text: '51 - 60', value: '51-60'),
          TextChoice(text: '> 60', value: '>60'),
        ],
      ),
    ),
    QuestionStep(
      title: '3. Employment',
      text: 'Which of the following describes you best?',
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: 'Student', value: 'Student'),
          TextChoice(text: 'Employed', value: 'Employed'),
          TextChoice(text: 'Self employed', value: 'Self employed'),
          TextChoice(text: 'Retired', value: 'Retired'),
          TextChoice(text: 'Not Employed', value: 'Not Employed'),
        ],
      ),
    ),
    QuestionStep(
      title: '4. Flight Frequency',
      text: 'How often do you fly?',
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: 'Once a week', value: 'Once a week'),
          TextChoice(text: '2 - 3 times a month', value: '2 - 3 times a month'),
          TextChoice(text: 'Once a month', value: 'Once a month'),
          TextChoice(text: 'A few times a year', value: 'A few times a year'),
          TextChoice(text: 'Once a year or less', value: 'Once a year or less'),
          TextChoice(
              text: 'This is my first time', value: 'This is my first time'),
        ],
      ),
    ),
    QuestionStep(
      title: '5. Wait time',
      text: 'How satisfied were you with waiting times on your last trip?',
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: 'Very Satisfied', value: 'Once a week'),
          TextChoice(text: 'Satisfied', value: '2 - 3 times a month'),
          TextChoice(text: 'Neutral', value: 'Once a month'),
          TextChoice(text: 'Unsatisfied', value: 'A few times a year'),
          TextChoice(text: 'Very Unsatisfied', value: 'Once a year or less'),
        ],
      ),
    ),
    QuestionStep(
      title: '6. Catering',
      text: 'How satisfied were you with the catering on your last trip?',
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: 'Very Satisfied', value: 'Once a week'),
          TextChoice(text: 'Satisfied', value: '2 - 3 times a month'),
          TextChoice(text: 'Neutral', value: 'Once a month'),
          TextChoice(text: 'Unsatisfied', value: 'A few times a year'),
          TextChoice(text: 'Very Unsatisfied', value: 'Once a year or less'),
        ],
      ),
    ),
    QuestionStep(
      title: '7. On-Board Entertainment',
      text:
          'How satisfied were you with the availability of the on-board entertainment service on your last trip?',
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: 'Very Satisfied', value: 'Once a week'),
          TextChoice(text: 'Satisfied', value: '2 - 3 times a month'),
          TextChoice(text: 'Neutral', value: 'Once a month'),
          TextChoice(text: 'Unsatisfied', value: 'A few times a year'),
          TextChoice(text: 'Very Unsatisfied', value: 'Once a year or less'),
        ],
      ),
    ),
    QuestionStep(
      title: '8. On-Board Entertainment',
      text: 'How satisfied were you with our on-board staff on your last trip?',
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: 'Very Satisfied', value: 'Once a week'),
          TextChoice(text: 'Satisfied', value: '2 - 3 times a month'),
          TextChoice(text: 'Neutral', value: 'Once a month'),
          TextChoice(text: 'Unsatisfied', value: 'A few times a year'),
          TextChoice(text: 'Very Unsatisfied', value: 'Once a year or less'),
        ],
      ),
    ),
    QuestionStep(
      title: '9. Cleanliness',
      text:
          'How satisfied were you with the cleanliness of the plane on your last trip?',
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: 'Very Satisfied', value: 'Once a week'),
          TextChoice(text: 'Satisfied', value: '2 - 3 times a month'),
          TextChoice(text: 'Neutral', value: 'Once a month'),
          TextChoice(text: 'Unsatisfied', value: 'A few times a year'),
          TextChoice(text: 'Very Unsatisfied', value: 'Once a year or less'),
        ],
      ),
    ),
    QuestionStep(
      title: '10. Comfort',
      text: 'How satisfied were you with the comfort of your last trip?',
      answerFormat: const SingleChoiceAnswerFormat(
        textChoices: [
          TextChoice(text: 'Very Satisfied', value: 'Once a week'),
          TextChoice(text: 'Satisfied', value: '2 - 3 times a month'),
          TextChoice(text: 'Neutral', value: 'Once a month'),
          TextChoice(text: 'Unsatisfied', value: 'A few times a year'),
          TextChoice(text: 'Very Unsatisfied', value: 'Once a year or less'),
        ],
      ),
    ),
    QuestionStep(
      title: '11. Custom Complaints',
      text: 'Anything else we need to improve on?',
      answerFormat: const TextAnswerFormat(
        maxLines: 5,
      ),
      isOptional: true,
    ),
    CompletionStep(
      title: 'You are done',
      text:
          'Thank you for filling out this survey! You can now redeem your food-voucher on the next step.',
      buttonText: 'Submit survey and show voucher',
      stepIdentifier: StepIdentifier(id: 'end'),
    ),
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Feedback'),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: SurveyKit(
                  task: task,
                  themeData: Theme.of(context).copyWith(
                      textTheme: Theme.of(context)
                          .textTheme
                          .apply(fontSizeFactor: 0.55, fontSizeDelta: 9.0),
                      colorScheme: ColorScheme.fromSwatch().copyWith(
                        onPrimary: Colors.white,
                      ),
                      primaryColor: CustomColors.MAIN_THEME,
                      backgroundColor: Colors.white,
                      appBarTheme: const AppBarTheme(
                        color: Colors.white,
                        iconTheme: IconThemeData(
                          color: CustomColors.MAIN_THEME,
                        ),
                        titleTextStyle: TextStyle(
                          color: CustomColors.MAIN_THEME,
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: CustomColors.MAIN_THEME,
                      ),
                      textSelectionTheme: const TextSelectionThemeData(
                        cursorColor: CustomColors.MAIN_THEME,
                        selectionColor: CustomColors.MAIN_THEME,
                        selectionHandleColor: CustomColors.MAIN_THEME,
                      ),
                      cupertinoOverrideTheme: const CupertinoThemeData(
                        primaryColor: CustomColors.MAIN_THEME,
                      ),
                      outlinedButtonTheme: OutlinedButtonThemeData(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(150.0, 60.0),
                          ),
                          side: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return const BorderSide(
                                  color: Colors.grey,
                                );
                              }
                              return const BorderSide(
                                color: CustomColors.MAIN_THEME,
                              );
                            },
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          textStyle: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(
                                      color: Colors.grey,
                                    );
                              }
                              return Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                    color: CustomColors.MAIN_THEME,
                                  );
                            },
                          ),
                        ),
                      )),
                  onResult: (res) async {
                    if (res.finishReason == FinishReason.COMPLETED) {
                      if (await FeedbackController.postSurveyResult(res.results
                          // with help of:
                          // https://stackoverflow.com/questions/72788282/fluetter-surveykit-how-to-serialize-surveyresult-to-json#:~:text=result.results%0A%20%20%20%20%20%20%20%20.map,r.valueIdentifier%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%7D)%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20.toList()
                          .map((step) => <String, dynamic>{
                                "id": step.id?.id,
                                "startDate": step.startDate.toIso8601String(),
                                "endDate": step.endDate.toIso8601String(),
                                "results":
                                    step.results.map((r) => <String, dynamic>{
                                          "id": r.id?.id,
                                          "result": r.result is BooleanResult
                                              ? ((r.result as BooleanResult) ==
                                                      BooleanResult.POSITIVE
                                                  ? true
                                                  : (r.result as BooleanResult) ==
                                                          BooleanResult.NEGATIVE
                                                      ? false
                                                      : null)
                                              : r.result is TimeOfDay
                                                  ? '${(r.result as TimeOfDay).hour}:${(r.result as TimeOfDay).minute}'
                                                  : r.result is DateTime
                                                      ? (r.result as DateTime)
                                                          .toIso8601String()
                                                      : r.result,
                                          "startDate":
                                              r.startDate.toIso8601String(),
                                          "endDate":
                                              r.endDate.toIso8601String(),
                                          "valueIdentifier": r.valueIdentifier,
                                        })
                              })
                          .toList()
                          .toString())) {
                        showDialog(
                            context: context,
                            builder: (c) => AlertDialog(
                                  title: Center(
                                    child: Text(
                                        'Thank you for your feedback!\n\nYour free coupon-code is:\n\n${_getRandomCoupon()}\n',
                                        textAlign: TextAlign.center),
                                  ),
                                )).then((_) => Navigator.popUntil(
                            context, ModalRoute.withName('/')));
                      } else {
                        showDialog(
                            context: context,
                            builder: (c) => const AlertDialog(
                                    title: Center(
                                  child: Text(
                                      'Something went wrong, pleas try again later'),
                                ))).then((_) => Navigator.popUntil(
                            context, ModalRoute.withName('/')));
                      }
                    } else {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    }
                  },
                ))));
  }

  String _getRandomCoupon() {
    final r = Random();
    const chars = '0123456789';
    return List.generate(7, (_) => chars[r.nextInt(chars.length)]).join();
  }
}
