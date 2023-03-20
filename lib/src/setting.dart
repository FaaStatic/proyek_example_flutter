import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Setting extends StatefulWidget {
  const Setting({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<Setting> createState() => _SettingState();
}

List<String> genderList = <String>["Laki-Laki", "Perempuan"];
List<String> checkBoxList = <String>["Ibadah", "Masak", "Makan", "Kerja", "Tidur"];
List<String> multipleChoice = <String>["Dart", "Kotlin", "TypeScript", "Java"];

class _SettingState extends State<Setting> with RestorationMixin {
  String _stateGender = genderList.first;

  bool _stateChoice1 = false;
  bool _stateChoice2 = false;
  bool _stateChoice3 = false;
  bool _stateChoice4 = false;

  String _answer = "";

  int _textState = 0;
  final textControlled = TextEditingController();

  DateTime _dateState = DateTime.now();

  @override
  void initState() {
    setState(() {
      _dateState = DateTime.now();
    });
    textControlled.addListener(() {
      setState(() {
        if (textControlled.text.trim().isEmpty) {
          _textState = 0;
        } else {
          _textState = int.parse(textControlled.text);
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    textControlled.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  String result(int value) {
    String temp = (value * value).toString();
    if (value == 0) {
      return "0";
    } else {
      return temp;
    }
  }

  final RestorableDateTime _restoreDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _dateTimePicker = RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _restoreDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime(2022, 01, 01),
          firstDate: DateTime(2022),
          lastDate: DateTime(2050),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _restoreDate.value = newSelectedDate;
        setState(() {
          _dateState = newSelectedDate;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_restoreDate.value.day}/${_restoreDate.value.month}/${_restoreDate.value.year}'),
        ));
      });
    }
  }

  @override
  void didUpdateWidget(covariant Setting oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  // TODO: implement restorationId
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_restoreDate, 'selected_date');
    registerForRestoration(_dateTimePicker, 'date_picker_route_future');
  }

  bool valueBox(int index) {
    switch (index) {
      case 0:
        {
          return _stateChoice1;
        }
      case 1:
        {
          return _stateChoice2;
        }
      case 2:
        {
          return _stateChoice3;
        }
      case 3:
        {
          return _stateChoice4;
        }
      default:
        {
          return false;
        }
    }
  }

  void setStateChekBox(int index) {
    switch (index) {
      case 0:
        {
          setState(() {
            _stateChoice1 = !_stateChoice1;
          });
          break;
        }
      case 1:
        {
          setState(() {
            _stateChoice2 = !_stateChoice2;
          });
          break;
        }
      case 2:
        {
          setState(() {
            _stateChoice3 = !_stateChoice3;
          });
          break;
        }
      case 3:
        {
          setState(() {
            _stateChoice4 = !_stateChoice4;
          });
          break;
        }
      default:
        {
          break;
        }
    }
  }

  void checkAnswer() {
    if (_answer == multipleChoice.first) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Jawabanmu Benar!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Jawabanmu Salah!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ini Settings",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'FiraSans',
            ),
          ),
          leading: IconButton(
              onPressed: () {
                context.go("/");
              },
              icon: const FaIcon(
                FontAwesomeIcons.arrowLeft,
                size: 16,
                color: Colors.black,
              )),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.circleInfo,
                      size: 16,
                      color: Colors.black,
                    ))
              ],
            )
          ],
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24),
          scrollDirection: Axis.vertical,
          restorationId: widget.restorationId,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Ini Settings",
                style: TextStyle(
                    fontFamily: 'FiraSans',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Center(
                  child: Container(
                    width: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white38, borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextField(
                      controller: textControlled,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.white12,
                        border: InputBorder.none,
                        labelText: "Isi Angka",
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffE2E2E2), width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Center(
                  child: Container(
                    width: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white38, borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      'Result ${result(_textState)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: "FiraSans",
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Center(
                  child: Container(
                    width: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white38, borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      DateFormat.yMMMMd().format(_dateState),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: "FiraSans",
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        _dateTimePicker.present();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          )),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Open Date Picker",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "FiraSans"),
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _dateTimePicker.present();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )),
                    child: DropdownButton<String>(
                      value: _stateGender,
                      icon: const FaIcon(
                        FontAwesomeIcons.chevronDown,
                        size: 14,
                        color: Colors.black,
                      ),
                      elevation: 16,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      dropdownColor: Colors.blueAccent,
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      style: const TextStyle(fontFamily: "FiraSans", color: Colors.black),
                      onChanged: (String? value) {
                        setState(() {
                          _stateGender = value!;
                        });
                      },
                      items: genderList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: checkBoxList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              checkBoxList[index],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: "FiraSans",
                              ),
                            ),
                            Checkbox(
                              value: valueBox(index),
                              onChanged: (bool? value) {
                                setStateChekBox(index);
                              },
                              checkColor: Colors.blueGrey,
                            ),
                          ],
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: SizedBox(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Bahasa Yang digunakan pada flutter adalah bahasa?",
                        style: TextStyle(
                          fontFamily: "FiraSans",
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: multipleChoice.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile(
                                  title: Text(
                                    multipleChoice[index],
                                    style: const TextStyle(
                                      fontFamily: "FiraSans",
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  value: multipleChoice[index],
                                  groupValue: _answer,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _answer = value!;
                                    });
                                  });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            checkAnswer();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          child: const Text(
                            "Check Jawaban",
                            style: TextStyle(
                                fontSize: 12, color: Colors.white, fontFamily: "FiraSans"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Balik Home",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
