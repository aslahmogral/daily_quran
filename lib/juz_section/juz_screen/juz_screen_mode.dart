import 'package:daily_quran/juz_section/juz_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart';

class JuzScreenModel with ChangeNotifier {
  List<Widget> finalList = [];
  Map juzMap = {};
  PageController pageController = PageController(initialPage: 0);
  var currentPageAkaCurrentAyah = 0;
  late int juzNumber;
  double progressIndicator = 0.0;
  double total = 0.0;

  JuzScreenModel(juzNumber) {
    juzMap = getSurahAndVersesFromJuz(juzNumber);
    this.juzNumber = juzNumber;
    // juzMap.forEach((key, value) {
    //   // finalList.add(Text(basmala));
    //   for (int i = value[0]; i <= value[1]; i++) {
    //     finalList.add(Text(getVerse(key, i)));
    //   }
    // });
  }

  void initMethod(int? previousVerse, int juzNumber) {
    if (previousVerse != null) {
      // currentPageAkaCurrentAyah = previousVerse;
      this.juzNumber = juzNumber;
    }
    pageController = PageController(initialPage: currentPageAkaCurrentAyah);
    pageController.addListener(() {
      currentPageAkaCurrentAyah = pageController.page!.toInt();
      notifyListeners();
    });
  }

  vibrateOnButtonClick() {
    // Clipboard.setData(ClipboardData(text: ''));
    HapticFeedback.lightImpact();
  }

  void onForwardButtonClicked() {
    vibrateOnButtonClick();
    print(currentPageAkaCurrentAyah);

    pageController.nextPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  void onBackwardButtonClicked() {
    print('hi');
    vibrateOnButtonClick();
    pageController.previousPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  void onExitButtonClicked(context, JuzProgressProvider juzProgressModel) {
    var progress = pageController.page!.toDouble() / total;
    juzProgressModel.updateJuzData(
      juzNumber,progress
    );
    Navigator.  pop(
      context,
    );
    print('exit');
  }
}