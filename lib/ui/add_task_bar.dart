import 'package:intl/intl.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
import '../consts/consts.dart';
import '../controller/task_controller.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:40 am";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColor = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  getDateFromUser() async {
    DateTime? pickData = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2123));
    if (pickData != null) {
      setState(() {
        _selectedDate = pickData;
      });
    } else {
      SnackBar(content: "Error".text.make());
    }
  }

  _getTimeFromUser({required bool isTimeStarted}) async {
    var pickTime = await _showTimePicker();
    String formatTime = pickTime.format(context);
    if (pickTime == null) {
    } else if (isTimeStarted == true) {
      setState(() {
        _startTime = formatTime;
      });
    } else if (isTimeStarted == false) {
      setState(() {
        _endTime = formatTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }

  _validationData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "ALl fields are required !",
          colorText: Colors.red,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white70,
          barBlur: 2,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  _addTaskToDb() async {
    await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        isCompleted: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        elevation: 0.0,
        leading: Icon(
          Icons.arrow_back_ios_new,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ).onTap(() {
          Get.back();
        }),
        actions: const [
          CircleAvatar(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headerStyle,
              ),
              TextInputField(
                title: "Title",
                hint: "Enter your Title here",
                max: false,
                controller: _titleController,
              ),
              TextInputField(
                title: "Note",
                hint: "Enter your Note here",
                max: true,
                controller: _noteController,
              ),
              TextInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                max: false,
                widget: IconButton(
                    onPressed: () {
                      getDateFromUser();
                    },
                    icon: const Icon(Icons.calendar_today_outlined)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: TextInputField(
                    title: "Start Time",
                    max: false,
                    hint: _startTime,
                    widget: IconButton(
                        onPressed: () {
                          //  _getTimeFromUSer(isStartTime: true);
                          _getTimeFromUser(isTimeStarted: true);
                        },
                        icon: const Icon(Icons.access_time)),
                  )),
                  10.widthBox,
                  Expanded(
                      child: TextInputField(
                    title: "End Time",
                    max: false,
                    hint: _endTime,
                    widget: IconButton(
                        onPressed: () {
                          // _getTimeFromUSer(isStartTime: false);
                          _getTimeFromUser(isTimeStarted: false);
                        },
                        icon: const Icon(Icons.access_time)),
                  ))
                ],
              ),
              TextInputField(
                max: false,
                hint: "$_selectedRemind minutes early",
                title: "Remind Me",
                widget: DropdownButton(
                  isDense: true,
                  underline: Container(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRemind = int.parse(value!);
                    });
                  },
                ),
              ),
              TextInputField(
                max: false,
                hint: _selectedRepeat,
                title: "Remind Me",
                widget: DropdownButton(
                  underline: Container(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRepeat = value!;
                    });
                  },
                ),
              ),
              15.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: titleStyle,
                      ),
                      10.heightBox,
                      Wrap(
                        children: List<Widget>.generate(7, (int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: index == 0
                                  ? green
                                  : index == 1
                                      ? blue
                                      : index == 2
                                          ? yellow
                                          : index == 3
                                              ? pink
                                              : index == 4
                                                  ? red
                                                  : index == 5
                                                      ? green2
                                                      : darkgray,
                              child: _selectedColor == index
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      weight: 50,
                                    )
                                  : Container(),
                            ).onTap(() {
                              setState(() {
                                _selectedColor = index;
                              });
                            }),
                          );
                        }),
                      )
                    ],
                  ),
                  commonButton(
                      color: blue,
                      textColor: Colors.white,
                      title: "Create Task",
                      onPress: () {
                        _addTaskToDb();
                        _validationData();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
