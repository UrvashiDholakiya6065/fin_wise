class LanguageState {
  final String currentLang;
  final Map<String, String> translations;

  LanguageState({
    required this.currentLang,
    this.translations = const {},
  });

  LanguageState copyWith({
    String? currentLang,
    Map<String, String>? translations,
  }) {
    return LanguageState(
      currentLang: currentLang ?? this.currentLang,
      translations: translations ?? this.translations,
    );
  }
}