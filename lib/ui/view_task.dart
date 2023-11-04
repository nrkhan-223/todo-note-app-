import '../consts/consts.dart';

class ViewTask extends StatelessWidget {
  final String? title;
  final String? note;
  final String? date;
  final int? color;

  const ViewTask(
      {super.key,
      required this.title,
      required this.date,
      required this.note,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
          backgroundColor: color == 0
              ? green
              : color == 1
                  ? blue
                  : color == 2
                      ? yellow
                      : color == 3
                          ? pink
                          : color == 4
                              ? red
                              : color == 5
                                  ? green2
                                  : darkgray,
          leadingWidth: context.screenWidth,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios_new,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                    onPressed: () {
                      Get.back();
                    }),
                WidthBox(context.screenWidth / 4.5),
                title!.text
                    .size(23)
                    .color( Colors.white)
                    .semiBold
                    .make()
              ],
            ),
          )),
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Column(children: [
          Center(child: "Hello".text.size(32).bold.make()),
          15.heightBox,
          Center(
              child: "You have a new reminder"
                  .text
                  .size(15)
                  .color(Get.isDarkMode ? Colors.white70 : Colors.grey)
                  .make()),
          40.heightBox,
          Center(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: context.screenHeight / 1.65,
                width: context.screenWidth - 50,
                decoration: BoxDecoration(
                  color: color == 0
                      ? green
                      : color == 1
                          ? blue
                          : color == 2
                              ? yellow
                              : color == 3
                                  ? pink
                                  : color == 4
                                      ? red
                                      : color == 5
                                          ? green2
                                          : darkgray,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      15.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            img10,
                            scale: 14,
                            color: Colors.white,
                          ),
                          20.widthBox,
                          "Title"
                              .text
                              .size(35)
                              .color(
                                 Colors.white,
                              )
                              .make()
                        ],
                      ),
                      10.heightBox,
                      title!.text
                          .size(22)
                          .color(
                             Colors.white,
                          )
                          .make(),
                      20.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            img11,
                            scale: 14,
                            color:  Colors.white,
                          ),
                          20.widthBox,
                          "Description"
                              .text
                              .size(35)
                              .color(
                                Colors.white,
                              )
                              .make()
                        ],
                      ),
                      10.heightBox,
                      note!.text
                          .size(18)
                          .color(
                        Colors.white,
                      )
                          .make(),
                      20.heightBox,

                      Row(
                        children: [
                          Image.asset(
                            img9,
                            scale: 14,
                            color:  Colors.white,
                          ),
                          20.widthBox,
                          "Date"
                              .text
                              .size(35)
                              .color(
                                Colors.white,
                              )
                              .make()
                        ],
                      ),
                      10.heightBox,
                      date!.text
                          .size(22)
                          .color(
                        Colors.white,
                      )
                          .make(),
                    ],
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
