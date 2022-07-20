import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';

import '../../../res/constants.dart';
import '../../../utils/shared_preference_manager.dart';

abstract class LanguageEvent {
  const LanguageEvent();
}

class English extends LanguageEvent {}

class Arabic extends LanguageEvent {}

class LanguageBloc extends Bloc<LanguageEvent, Language> {

  static String getSelectedLanguage() {
    return PreferenceManager.instance.getString(PREFS_LANG) == 'en' ||
        PreferenceManager.instance.getString(PREFS_LANG) == ''
        ? 'en'
        : 'ar';
  }


  LanguageBloc(Language initialState) : super(initialState) {
    on<English>(_setEnglish);
    on<Arabic>(_setArabic);
  }

  _setEnglish(English english, Emitter<Language> lang) {
    if (state == Language.ARABIC) {
      lang(Language.ENGLISH);
    }
  }

  _setArabic(Arabic arabic, Emitter<Language> lang) {
    if (state == Language.ENGLISH) {
      lang(Language.ARABIC);
    }
  }
}
