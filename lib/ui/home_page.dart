import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:todo/consts/consts.dart';
import 'package:todo/ui/view_task.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/button_2.dart';
import 'package:todo/ui/widgets/task_tile.dart';
import '../controller/task_controller.dart';
import '../services/notification_services.dart';
import '../services/theme_service.dart';
import 'add_task_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var notifyhelper;
  bool change = true;
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    _taskController.getTasks();
    notifyhelper = NotifyHelper();
    notifyhelper.initializeNotification();
    //android
    notifyhelper.requestAndroidPermissions();
    //ios
    notifyhelper.requestIOSPermissions();
    // TODO: implement initState
    super.initState();
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 2),
      height: task.isCompleted == 1
          ? context.screenHeight * 0.25
          : context.screenHeight * 0.32,
      color:
          Get.isDarkMode ? darkgray : CupertinoColors.systemGroupedBackground,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:
                  Get.isDarkMode ? Colors.white12 : CupertinoColors.systemGrey5,
            ),
          ),
          25.heightBox,
          Visibility(
            visible: task.isCompleted == 1 ? false : true,
            child: commonButton2(
              context: context,
              onPress: () {
                _taskController.taskCompleted(task.id!);
                Get.back();
              },
              color: blue,
              title: "Task Completed",
              textColor: white,
            ),
          ),
          10.heightBox,
          commonButton2(
            context: context,
            onPress: () {
              _taskController.delete(task);
              Get.back();
            },
            color: red,
            title: "Delete Task",
            textColor: white,
          ),
          const Spacer(),
          commonButton2(
            context: context,
            onPress: () {
              Get.back();
            },
            color: Get.isDarkMode ? Colors.white70 : Colors.black87,
            title: "Close",
            textColor: Colors.red,
          ),
          20.heightBox
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: change ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: change ? Colors.white : Colors.black,
        elevation: 0.0,
        leading: Icon(
          change ? Icons.nightlight_outlined : Icons.sunny,
          //Icons.sunny,
          color: change ? Colors.black : Colors.white,
          //color: Colors.redAccent,
        ).onTap(() {
          setState(() {
            Get.isDarkMode ? change = true : change = false;
          });

          ThemeService().switchTheme();
          Get.appUpdate();
          notifyhelper.displayNotification(
            title: "Theme changed",
            body:
                Get.isDarkMode ? "Activated light mode" : "Activated dark mode",
          );
        }),
        actions: const [
          CircleAvatar(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: subHeaderStyle,
                      ),
                      Text(
                        "Today",
                        style: headerStyle,
                      )
                    ],
                  ),
                  commonButton(
                      onPress: () async {
                        await Get.to(() => const AddTask());
                        _taskController.getTasks();
                      },
                      color: blue,
                      textColor: Colors.white,
                      title: "+ Add Task")
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 20),
              child: DatePicker(
                DateTime.now(),
                height: 95,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: primarycolr,
                selectedTextColor: Colors.white,
                dateTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                dayTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                monthTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                onDateChange: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
            ),
            15.heightBox,
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _taskController.taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Task task = _taskController.taskList[index];
                    //  print(task.toJson());
                    Key? key;
                    if (task.repeat == 'Daily') {
                      DateTime date =
                          DateFormat.jm().parse(task.startTime.toString());
                      var myTime = DateFormat('hh:mm').format(date);
                      notifyhelper.scheduledNotification(
                          int.parse(myTime.toString().split(":")[0]),
                          int.parse(myTime.toString().split(":")[1]),
                          task);
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                TaskTile(task).onTap(() {
                                  Get.to(ViewTask(
                                    color: task.color,
                                    title: task.title,
                                    date: task.date,
                                    note: task.note,
                                  ));
                                })
                              ],
                            ).onLongPress(() {
                              _showBottomSheet(context, task);
                            }, key),
                          ),
                        ),
                      );
                    }
                    if (task.date == DateFormat.yMd().format(_selectedDate)) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                TaskTile(task).onTap(() {
                                  Get.to(ViewTask(
                                    color: task.color,
                                      title: task.title,
                                      date: task.date,
                                      note: task.note));
                                })
                              ],
                            ).onLongPress(() {
                              _showBottomSheet(context, task);
                            }, key),
                          ),
                        ),
                      );
                    } else {
                      return const Center();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
