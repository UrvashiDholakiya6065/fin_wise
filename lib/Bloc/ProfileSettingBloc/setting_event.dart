abstract class SettingsEvent {}

class ToggleSwitchEvent extends SettingsEvent {
  final int index;
  final bool value;

  ToggleSwitchEvent(this.index, this.value);
}