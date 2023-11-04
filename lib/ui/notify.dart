import '../consts/consts.dart';

class Notify extends StatelessWidget {
  final String? label;

  const Notify({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[600] : Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: Get.isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              Get.back();
            }),
        title: label
            .toString()
            .split("|")[0]
            .text
            .color(Get.isDarkMode ? Colors.white : Colors.black)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Get.isDarkMode ? Colors.white : Colors.grey[600]),
            child: Center(
              child: label
                  .toString()
                  .split("|")[1]
                  .text
                  .size(27)
                  .color(Get.isDarkMode ? Colors.white : Colors.black)
                  .make(),
            ),
          ),
        ),
      ),
    );
  }
}
