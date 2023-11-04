import 'consts.dart';

class Themes {
  static final light = ThemeData(
    cardColor: Colors.white,
    primaryColor: Colors.white,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    cardColor: Colors.black,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeaderStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey);
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey);
}

TextStyle get headerStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold));
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[800]);
}
