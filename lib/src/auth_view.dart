// ignore_for_file: unused_element, depend_on_referenced_packages

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:simple_local_auth/src/constants.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

part 'numpad.dart';
part 'footer.dart';
part 'header_wrapper.dart';
part 'pin_view.dart';
part 'enums.dart';
part 'animated_dot.dart';
part 'shaker.dart';
part 'default_header.dart';
part 'create_pin.dart';
part 'digit.dart';

class LocalAuthView extends StatefulWidget {
  final int length;
  final String? correctPin;
  final Color backgroudColor;
  final Color emptyDotColor;
  final Color inputColor;
  final Color successColor;
  final Color errorColor;
  final String createPinTitle;
  final TextStyle createPinTitleTextSyle;
  final String repeatPinTitle;
  final TextStyle repeatPinTitleTextSyle;
  final String enterPinTitle;
  final TextStyle enterPinTitleTextSyle;
  final String? footerTitle;
  final TextStyle? footerTitleTextSyle;
  final String? footerDescription;
  final TextStyle? footerDescriptionTextStyle;
  final String? forgotPinCloseButtonTitle;
  final TextStyle? forgotPinCloseButtonTitleTextStyle;
  final String? forgotPinSubmitButtonTitle;
  final TextStyle? forgotPinSubmitButtonTitleTextStyle;
  final Widget? forgotPinWidget;
  final Widget? header;
  final Widget? headerTitle;
  final bool centertHeaderTitle;
  final TextStyle digitTextStyle;
  final Widget? biometryWidget;
  final Widget? deleteButton;
  final Function(String)? onPinChanged;
  final Function(InputState)? onResult;
  final InputState inputState;
  final String biometricsUsageDescription;
  final String biometricsCancelTitle;
  final String localizedBiometricsDenyReason;
  final VoidCallback? onFooterTap;
  final PageType pageType;
  final Duration errorDuration;
  final Duration? shakeDuration;
  final double shakeAmplitude;
  final bool autoRequestBiometrics;

  LocalAuthView({
    super.key,
    this.length = 4,
    this.correctPin,
    this.backgroudColor = Colors.white,
    this.emptyDotColor = const Color.fromARGB(255, 197, 197, 197),
    this.inputColor = Colors.black,
    this.successColor = Colors.green,
    this.errorColor = Colors.red,
    this.createPinTitle = "",
    this.createPinTitleTextSyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    this.repeatPinTitle = "",
    this.repeatPinTitleTextSyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    this.enterPinTitle = "",
    this.enterPinTitleTextSyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    this.footerTitle,
    this.footerTitleTextSyle,
    this.footerDescription,
    this.footerDescriptionTextStyle,
    this.forgotPinCloseButtonTitle,
    this.forgotPinCloseButtonTitleTextStyle,
    this.forgotPinSubmitButtonTitle,
    this.forgotPinSubmitButtonTitleTextStyle,
    this.forgotPinWidget,
    this.header,
    this.headerTitle,
    this.centertHeaderTitle = true,
    this.digitTextStyle = const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w500,
    ),
    this.biometryWidget,
    this.deleteButton,
    this.onPinChanged,
    this.onResult,
    this.pageType = PageType.enterPin,
    required this.biometricsUsageDescription,
    required this.biometricsCancelTitle,
    required this.localizedBiometricsDenyReason,
    this.onFooterTap,
    this.inputState = InputState.initial,
    this.errorDuration = const Duration(seconds: 1),
    this.shakeDuration,
    this.shakeAmplitude = 5.0,
    this.autoRequestBiometrics = false,
  })  : assert(
          header is! Widget || headerTitle is! Widget,
        ),
        assert(
          forgotPinWidget is! Widget ||
              (footerTitle is! String &&
                  footerTitleTextSyle is! TextStyle &&
                  footerDescription is! String &&
                  footerDescriptionTextStyle is! TextStyle &&
                  forgotPinCloseButtonTitle is! String &&
                  forgotPinCloseButtonTitleTextStyle is! TextStyle &&
                  forgotPinSubmitButtonTitle is! String &&
                  forgotPinSubmitButtonTitleTextStyle is! TextStyle),
        ),
        assert(
          () {
            if (pageType.isCreate && correctPin is String) {
              throw FlutterError(
                "correctPin available for PageType.enterPin only",
              );
            }

            return true;
          }(),
        ),
        assert(
          () {
            if (pageType.isCreate && autoRequestBiometrics) {
              throw FlutterError(
                "autoRequestBiometrics available for PageType.enterPin only",
              );
            }

            return true;
          }(),
        );

  @override
  State<LocalAuthView> createState() => _LocalAuthViewState();
}

class _LocalAuthViewState extends State<LocalAuthView> {
  final _pageController = PageController();

  void _nextPage() {
    if (!_pageController.hasClients) {
      return;
    }

    if (_pageController.page?.floor() == 0) {
      _pageController
          .nextPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
          )
          .whenComplete(() => setState(() {}));
    }
  }

  void _previousPage() {
    if (!_pageController.hasClients) {
      return;
    }

    if (_pageController.page?.floor() == 1) {
      _pageController
          .previousPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
          )
          .whenComplete(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: widget.backgroudColor,
        appBar: _HeaderWrapper(
          child: widget.header ??
              (widget.headerTitle is Widget
                  ? _DefaultHeader(
                      title: widget.headerTitle,
                      centerTitle: widget.centertHeaderTitle,
                      showLeading: widget.pageType.isCreate &&
                          _pageController.hasClients &&
                          _pageController.page?.floor() == 1,
                      onLeadingTap: _previousPage,
                    )
                  : const SizedBox()),
        ),
        body: widget.pageType.isCreate
            ? _CreatePin(
                length: widget.length,
                header: widget.header,
                headerTitle: widget.headerTitle,
                centertHeaderTitle: widget.centertHeaderTitle,
                backgroudColor: widget.backgroudColor,
                emptyDotColor: widget.emptyDotColor,
                inputColor: widget.inputColor,
                successColor: widget.successColor,
                errorColor: widget.errorColor,
                createPinTitle: widget.createPinTitle,
                createPinTitleTextSyle: widget.createPinTitleTextSyle,
                repeatPinTitle: widget.repeatPinTitle,
                repeatPinTitleTextSyle: widget.repeatPinTitleTextSyle,
                footerTitle: widget.footerTitle,
                footerTitleTextSyle: widget.footerTitleTextSyle,
                footerDescription: widget.footerDescription,
                footerDescriptionTextStyle: widget.footerDescriptionTextStyle,
                digitTextStyle: widget.digitTextStyle,
                deleteButton: widget.deleteButton,
                onPinChanged: (value) {
                  widget.onPinChanged?.call(value);

                  if (value.length == widget.length) {
                    _nextPage();
                  }
                },
                onResult: widget.onResult,
                onFooterTap: widget.onFooterTap,
                inputState: widget.inputState,
                errorDuration: widget.errorDuration,
                shakeDuration: widget.shakeDuration,
                shakeAmplitude: widget.shakeAmplitude,
                controller: _pageController,
              )
            : _PinView(
                length: widget.length,
                correctPin: widget.correctPin,
                backgroudColor: widget.backgroudColor,
                emptyDotColor: widget.emptyDotColor,
                inputColor: widget.inputColor,
                successColor: widget.successColor,
                errorColor: widget.errorColor,
                title: widget.enterPinTitle,
                titleStyle: widget.enterPinTitleTextSyle,
                footerTitle: widget.footerTitle,
                footerTitleTextSyle: widget.footerTitleTextSyle,
                footerDescription: widget.footerDescription,
                footerDescriptionTextStyle: widget.footerDescriptionTextStyle,
                forgotPinCloseButtonTitle: widget.forgotPinCloseButtonTitle,
                forgotPinCloseButtonTitleTextStyle:
                    widget.forgotPinCloseButtonTitleTextStyle,
                forgotPinSubmitButtonTitle: widget.forgotPinSubmitButtonTitle,
                forgotPinSubmitButtonTitleTextStyle:
                    widget.forgotPinSubmitButtonTitleTextStyle,
                forgotPinWidget: widget.forgotPinWidget,
                header: widget.header,
                headerTitle: widget.headerTitle,
                centertHeaderTitle: widget.centertHeaderTitle,
                digitTextStyle: widget.digitTextStyle,
                biometryWidget: widget.biometryWidget,
                deleteButton: widget.deleteButton,
                onPinChanged: widget.onPinChanged,
                onResult: widget.onResult,
                biometricsUsageDescription: widget.biometricsUsageDescription,
                biometricsCancelTitle: widget.biometricsCancelTitle,
                localizedBiometricsDenyReason:
                    widget.localizedBiometricsDenyReason,
                onFooterTap: widget.onFooterTap,
                inputState: widget.inputState,
                showBiometrics: true,
                errorDuration: widget.errorDuration,
                shakeDuration: widget.shakeDuration,
                shakeAmplitude: widget.shakeAmplitude,
                autoRequestBiometrics: widget.autoRequestBiometrics,
              ),
      );
}
