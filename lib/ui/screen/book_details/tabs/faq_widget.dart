import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:collection/collection.dart';

class FaqWidget extends StatefulWidget {
  final CourseDetailResponse response;

  const FaqWidget(this.response) : super();

  @override
  State<StatefulWidget> createState() {
    return FaqWidgetState();
  }
}

class FaqWidgetState extends State<FaqWidget> {
  List<QuizBean> quizDataList = [];

  @override
  void initState() {
    super.initState();
    quizDataList = widget.response.quizes;
  }

  @override
  Widget build(BuildContext context) {
    if (quizDataList.isEmpty || quizDataList == null) {
      return Container(
        child: Center(
          child: Text(
            'الدورة لا تحتوي على اختبار',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: HexColor.fromHex('#2f3c6e')),
          ),
        ),
      );
    }
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: quizDataList.length,
              itemBuilder: (context, index1) {
                var item = quizDataList[index1];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 14, top: 5),
                      child: Text(
                        item.title,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: HexColor.fromHex('#2f3c6e'),
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: item.questions.length,
                          itemBuilder: (context, index2) {
                            var question = item.questions[index2];
                            return Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, right: 14),
                                      child: Text(
                                        question.title,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: question.answers.length,
                                          itemBuilder: (context, index3) {
                                            return question.type ==
                                                    'multi_choice'
                                                ? Directionality(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[100]),
                                                      child: CheckboxListTile(
                                                        dense: true,
                                                        value: question
                                                                .answers[index3]
                                                                .selectedValueCheckbox[
                                                            index3],
                                                        title: Text(
                                                          question
                                                              .answers[index3]
                                                              .text,
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        onChanged: (bool val) {
                                                          setState(() {
                                                            question
                                                                    .answers[index3]
                                                                    .selectedValueCheckbox[
                                                                index3] = val;
                                                          });
                                                        },
                                                        activeColor: mainColor,
                                                      ),
                                                    ),
                                                  )
                                                : Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .grey[100]),
                                                        child: RadioListTile(
                                                          dense: true,
                                                          value: index3,
                                                          groupValue: question
                                                              .selectedSingle,
                                                          title: Text(
                                                            question
                                                                .answers[index3]
                                                                .text,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          onChanged: (val) {
                                                            setState(() {
                                                              question.selectedSingle =
                                                                  val;
                                                            });
                                                          },
                                                          activeColor:
                                                              mainColor,
                                                        )),
                                                  );
                                          }),
                                    ),
                                  ],
                                ));
                          }),
                    ),
                  ],
                );
              }),
        )),
        Container(
          width: 100,
          margin: EdgeInsets.only(top: 10),
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minWidth: 50,
            height: 30,
            child: Text('إرسال'),
            onPressed: () {
              validateQuiz();
            },
            color: mainColor,
            textColor: Colors.white,
          ),
        )
      ],
    );
  }

  /* validateQuiz() async {
    int score = 0, total_question = quizDataList.length;
    for (int i = 0; i < quizDataList.length; i++) {
      if (quizDataList[i].type == 'multi_choice') {
        var value = quizDataList[i].selectedValueCheckbox;
        var ans = quizDataList[i].listCorrect;
        Function isListEqual = const ListEquality().equals;
        if (isListEqual(value, ans)) score++;
      } else {
        if (quizDataList[i].selectedValue == quizDataList[i].correct) score++;
      }
    }
    await showDialog(
        context: context, builder: (_) => SuccessDialog(score, total_question));
  } */

  validateQuiz() async {
    int score = 0, total_question = 0;
    for (int i = 0; i < quizDataList.length; i++) {
      var quiz = quizDataList[i];
      total_question += quiz.questions.length;
      for (int j = 0; j < quiz.questions.length; j++) {
        var question = quiz.questions[j];
        if (question.type == 'multi_choice') {
          var selectedCheckboxData, finalAnswerData;
          for (int k = 0; k < question.answers.length; k++) {
            selectedCheckboxData = question.answers[k].selectedValueCheckbox;
            finalAnswerData = question.answers[k].listCorrect;
          }
          Function isListEqual = const ListEquality().equals;
          if (isListEqual(selectedCheckboxData, finalAnswerData)) score++;
        } else {
          var index;
          for (int n = 0; n < question.answers.length; n++) {
            if (question.answers[n].isTrue == 1) {
              index = n;
            }
          }
          if (index == question.selectedSingle) score++;
        }
      }
    }
    await showDialog(
        context: context, builder: (_) => SuccessDialog(score, total_question));
  }
}

class SuccessDialog extends StatelessWidget {
  final int score, total_question;

  SuccessDialog(this.score, this.total_question);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'نتيجتك النهائية هي:',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 22),
          ),
          Text(
            score.toString() + '/' + total_question.toString(),
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: 28,
                color: HexColor.fromHex('#2f3c6e'),
                fontWeight: FontWeight.bold),
          ),
          Container(
              height: 30,
              width: 100,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'حسنا',
                  textDirection: TextDirection.rtl,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: mainColor,
                textColor: Colors.white,
              ))
        ],
      ),
    ));
  }
}

/* @JsonSerializable()
class Quiz {
  int selectedValue, correct, questionIndex;
  String type;
  List<bool> listCorrect = new List<bool>();
  List<bool> selectedValueCheckbox = new List<bool>();
}

@JsonSerializable()
class Quizes {
  String quiz_title;
  List<Questions> questions = new List();
}

@JsonSerializable()
class Questions {
  String question_title, question_type;
  List<Answers> answers = new List();
}

@JsonSerializable()
class Answers {
  int selectedValue, correct;
  String answer_title;
  List<bool> listCorrect = new List<bool>();
  List<bool> selectedValueCheckbox = new List<bool>();
} */
