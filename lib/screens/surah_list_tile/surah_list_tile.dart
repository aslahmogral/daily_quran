import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';
import 'package:quran/quran.dart' as quran;
import 'package:yasin_mulk_waqiya/screens/surah_list_tile/surah_list_tile_model.dart';

class SurahListTile extends StatefulWidget {
  final surahNumber;
  // final previousVerse;
  const SurahListTile({
    super.key,
    required this.surahNumber,
  });

  @override
  State<SurahListTile> createState() => _SurahListTileState();
}

class _SurahListTileState extends State<SurahListTile> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => surahListTieModel(widget.surahNumber)),
      ],
      child: Consumer<surahListTieModel>(builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
              onTap: () async {
                await model.onListTileClicked(context, model);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors
                      .primaryColor, // Optional: Set the background color
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          '${widget.surahNumber}',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: AppColors.seconderyColor,
                      ),
                      title: Text(
                        quran.getSurahName(widget.surahNumber),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      trailing: typeOfChipMethod(model.progressOfSurah,model)),
                ),
              )),
        );
      }),
    );
  }

 

  Widget typeOfChipMethod(String result,surahListTieModel model) {
    if (result == 'continue') {
      var rverses = quran.getVerseCount(widget.surahNumber) - model.previousVerse;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$rverses verses left ",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 8,
          ),
          Chip(
            label: Text(
              'continue',
            ),
            backgroundColor: Colors.yellow,
          ),
        ],
      );
    } else if (result == 'completed') {
      return Chip(
        label: Text(
          'completed',
        ),
        backgroundColor: Colors.green,
      );
    } else {
      return Chip(
        label: Text(
          'Read',
        ),
        backgroundColor: Colors.red,
      );
    }
    // return finalString;
  }
}