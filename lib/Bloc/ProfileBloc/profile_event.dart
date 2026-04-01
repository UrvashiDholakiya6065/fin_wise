
 class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {
  final String lang;
  LoadProfileEvent(this.lang);
}

class TranslateNameEvent extends ProfileEvent {
  final String name;
  final String lang;
  TranslateNameEvent(this.name, this.lang);
}