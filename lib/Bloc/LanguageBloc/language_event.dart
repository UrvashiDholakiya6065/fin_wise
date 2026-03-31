abstract class LanguageEvent {}

class LoadLanguageEvent extends LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final String langCode;
  ChangeLanguageEvent(this.langCode);
}

class TranslateTextEvent extends LanguageEvent {
  final String text;
  TranslateTextEvent(this.text);
}