import '../../consts/consts.dart';

Widget commonButton2({onPress, color, textColor, String? title,context}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        backgroundColor: color,
        padding: const EdgeInsets.all(10),
      ),
      onPressed: onPress,
      child: title!.text.color(textColor).bold.make())
      .box
      .width(300)
      .height(50)
      .rounded
      .make();
}
