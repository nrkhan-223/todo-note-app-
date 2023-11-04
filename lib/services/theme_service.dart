import 'package:todo/consts/consts.dart';

class ThemeService {
  final _box = GetStorage();

  final _key = "isDarkMode";

  _saveThemeTOBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  ThemeMode get themes => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeTOBox(!_loadThemeFromBox());
  }
}
