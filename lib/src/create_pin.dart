// ignore_for_file: unused_element

part of 'auth_view.dart';

class _CreatePin extends StatefulWidget {
  final PageController controller;
  final int length;
  final Widget? header;
  final Widget? headerTitle;
  final bool centertHeaderTitle;
  final Color backgroudColor;
  final Color emptyDotColor;
  final Color inputColor;
  final Color successColor;
  final Color errorColor;
  final String createPinTitle;
  final TextStyle createPinTitleTextSyle;
  final String repeatPinTitle;
  final TextStyle repeatPinTitleTextSyle;
  final String? footerTitle;
  final TextStyle? footerTitleTextSyle;
  final String? footerDescription;
  final TextStyle? footerDescriptionTextStyle;
  final TextStyle digitTextStyle;
  final Widget? deleteButton;
  final Function(String)? onPinChanged;
  final Function(InputState)? onResult;
  final InputState inputState;
  final VoidCallback? onFooterTap;
  final Duration errorDuration;
  final Duration? shakeDuration;
  final double shakeAmplitude;

  const _CreatePin({
    super.key,
    required this.controller,
    this.length = 4,
    this.header,
    this.headerTitle,
    this.centertHeaderTitle = true,
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
    this.footerTitle,
    this.footerTitleTextSyle,
    this.footerDescription,
    this.footerDescriptionTextStyle,
    this.digitTextStyle = const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w500,
    ),
    this.deleteButton,
    this.onPinChanged,
    this.onResult,
    this.onFooterTap,
    this.inputState = InputState.initial,
    this.errorDuration = const Duration(seconds: 1),
    this.shakeDuration,
    this.shakeAmplitude = 5.0,
  });

  @override
  State<_CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<_CreatePin> {
  String _correctPin = "";

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: widget.backgroudColor,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: widget.controller,
          children: [
            _PinView(
              length: widget.length,
              backgroudColor: widget.backgroudColor,
              emptyDotColor: widget.emptyDotColor,
              inputColor: widget.inputColor,
              successColor: widget.successColor,
              errorColor: widget.errorColor,
              title: widget.createPinTitle,
              titleStyle: widget.createPinTitleTextSyle,
              footerTitle: widget.footerTitle,
              footerTitleTextSyle: widget.footerTitleTextSyle,
              footerDescription: widget.footerDescription,
              footerDescriptionTextStyle: widget.footerDescriptionTextStyle,
              digitTextStyle: widget.digitTextStyle,
              onPinChanged: (value) {
                setState(
                  () => _correctPin = value,
                );

                widget.onPinChanged?.call(value);
              },
              onResult: widget.onResult,
              inputState: widget.inputState,
              deleteButton: widget.deleteButton,
              onFooterTap: widget.onFooterTap,
              errorDuration: widget.errorDuration,
              shakeDuration: widget.shakeDuration,
              shakeAmplitude: widget.shakeAmplitude,
              autoRequestBiometrics: false,
              showBiometrics: false,
            ),
            _PinView(
              length: widget.length,
              correctPin: _correctPin,
              backgroudColor: widget.backgroudColor,
              emptyDotColor: widget.emptyDotColor,
              inputColor: widget.inputColor,
              successColor: widget.successColor,
              errorColor: widget.errorColor,
              title: widget.repeatPinTitle,
              titleStyle: widget.repeatPinTitleTextSyle,
              footerTitle: widget.footerTitle,
              footerTitleTextSyle: widget.footerTitleTextSyle,
              footerDescription: widget.footerDescription,
              footerDescriptionTextStyle: widget.footerDescriptionTextStyle,
              digitTextStyle: widget.digitTextStyle,
              onPinChanged: widget.onPinChanged?.call,
              onResult: widget.onResult,
              inputState: widget.inputState,
              showBiometrics: false,
              deleteButton: widget.deleteButton,
              onFooterTap: widget.onFooterTap,
              errorDuration: widget.errorDuration,
              shakeDuration: widget.shakeDuration,
              shakeAmplitude: widget.shakeAmplitude,
              autoRequestBiometrics: false,
            ),
          ],
        ),
      );
}
