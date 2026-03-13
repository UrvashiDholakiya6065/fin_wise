abstract class OnboardingEvent {}

class ChangeIndexEvent extends OnboardingEvent {
  final int index;
  ChangeIndexEvent(this.index);
}

class NextEvent extends OnboardingEvent {}