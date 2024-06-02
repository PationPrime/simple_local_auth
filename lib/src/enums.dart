part of 'auth_view.dart';

enum PageType {
  createPin,
  enterPin,
}

extension PageTypeExt on PageType {
  bool get isCreate => this == PageType.createPin;
  bool get isEnter => this == PageType.enterPin;
}

enum InputState {
  initial,
  progress,
  success,
  error,
}

extension InputStateExt on InputState {
  bool get isInital => this == InputState.initial;
  bool get isProgress => this == InputState.progress;
  bool get isSuccess => this == InputState.success;
  bool get isError => this == InputState.error;
}
