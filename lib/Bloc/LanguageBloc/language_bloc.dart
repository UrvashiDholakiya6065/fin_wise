import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_event.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../SessionManage/shared_pref.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String apiKey = "AIzaSyXXXXXXX";
  // Cache to avoid repeated API calls
  Map<String, String> _cache = {};

  LanguageBloc() : super(LanguageState(currentLang: 'en')) {
    on<LoadLanguageEvent>(_loadLanguage);
    on<ChangeLanguageEvent>(_changeLanguage);
    on<TranslateTextEvent>(_translateText);
  }

  Future<void> _loadLanguage(
      LoadLanguageEvent event, Emitter<LanguageState> emit) async {
    final lang = await SharedPref.getLanguage();
    emit(state.copyWith(currentLang: lang));
  }

  Future<void> _changeLanguage(
      ChangeLanguageEvent event, Emitter<LanguageState> emit) async {
    await SharedPref.setLanguage(event.langCode);
    _cache.clear(); // clear cache when language changes
    emit(state.copyWith(currentLang: event.langCode));
  }
  //
  // Future<void> _translateText(
  //     TranslateTextEvent event, Emitter<LanguageState> emit) async {
  //   final lang = state.currentLang;
  //
  //   if (lang == 'en') {
  //     emit(state.copyWith(translatedText: event.text));
  //     return;
  //   }
  //
  //   if (_cache.containsKey(event.text)) {
  //     emit(state.copyWith(translatedText: _cache[event.text]));
  //     return;
  //   }
  //
  //   try {
  //     final url = Uri.parse(
  //         "https://translation.googleapis.com/language/translate/v2?key=$apiKey");
  //
  //     final response = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "q": event.text,
  //         "source": "en",
  //         "target": lang,
  //         "format": "text",
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final translated = data['data']['translations'][0]['translatedText'];
  //       _cache[event.text] = translated;
  //       emit(state.copyWith(translatedText: translated));
  //     } else {
  //       print("Google Translate API Error: ${response.body}");
  //       emit(state.copyWith(translatedText: event.text));
  //     }
  //   } catch (e) {
  //     print("Translation Exception: $e");
  //     emit(state.copyWith(translatedText: event.text));
  //   }
  // }
  Future<void> _translateText(
      TranslateTextEvent event, Emitter<LanguageState> emit) async {

    final lang = state.currentLang;

    if (lang == 'en') {
      emit(state.copyWith(
        translations: {
          ...state.translations,
          event.text: event.text,
        },
      ));
      return;
    }

    if (_cache.containsKey(event.text)) {
      emit(state.copyWith(
        translations: {
          ...state.translations,
          event.text: _cache[event.text]!,
        },
      ));
      return;
    }

    try {
      final url = Uri.parse(
          "https://translation.googleapis.com/language/translate/v2?key=$apiKey");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "q": event.text,
          "source": "en",
          "target": lang,
        }),
      );

      final data = jsonDecode(response.body);
      final translated = data['data']['translations'][0]['translatedText'];

      _cache[event.text] = translated;

      emit(state.copyWith(
        translations: {
          ...state.translations,
          event.text: translated,
        },
      ));
    } catch (e) {
      emit(state.copyWith(
        translations: {
          ...state.translations,
          event.text: event.text,
        },
      ));
    }
  }
}