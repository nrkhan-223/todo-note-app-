import '../../consts/consts.dart';

Widget commonButton({onPress, color, textColor, String? title}) {
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
      .width(100)
      .height(50)
      .rounded
      .make();
}
