part of 'auth_view.dart';

class _PinView extends StatefulWidget {
  final int length;
  final String? correctPin;
  final Color backgroudColor;
  final Color emptyDotColor;
  final Color inputColor;
  final Color successColor;
  final Color errorColor;
  final String title;
  final TextStyle titleStyle;
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
  final String? biometricsUsageDescription;
  final String? biometricsCancelTitle;
  final String localizedBiometricsDenyReason;
  final VoidCallback? onFooterTap;
  final InputState inputState;
  final bool showBiometrics;
  final Duration errorDuration;
  final Duration? shakeDuration;
  final double shakeAmplitude;
  final bool autoRequestBiometrics;

  const _PinView({
    required this.length,
    this.correctPin,
    required this.backgroudColor,
    required this.emptyDotColor,
    required this.inputColor,
    required this.successColor,
    required this.errorColor,
    this.title = "",
    required this.titleStyle,
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
    required this.digitTextStyle,
    this.biometryWidget,
    this.deleteButton,
    this.onPinChanged,
    this.onResult,
    this.biometricsUsageDescription,
    this.biometricsCancelTitle,
    this.localizedBiometricsDenyReason = " ",
    this.onFooterTap,
    required this.inputState,
    required this.showBiometrics,
    this.errorDuration = const Duration(seconds: 1),
    this.shakeDuration,
    required this.shakeAmplitude,
    required this.autoRequestBiometrics,
  }) : assert(
          header is! Widget || headerTitle is! Widget,
        );

  @override
  State<_PinView> createState() => __PinViewState();
}

class __PinViewState extends State<_PinView> {
  final _auth = LocalAuthentication();
  late InputState _pinInputState;
  bool _biometricsAreAvailable = false;
  String _pin = "";

  bool _biometricsRequested = false;

  void _udpateInputState(
    InputState state, {
    bool rebuild = true,
  }) {
    _pinInputState = state;

    widget.onResult?.call(
      _pinInputState,
    );

    if (state.isError) {
      Future.delayed(
        const Duration(seconds: 1),
        () => _clearPin(),
      );
    }

    if (rebuild) setState(() {});
  }

  void _onPinChanged(String value) {
    if (_pin.length == widget.length) {
      return;
    }

    if (value.isEmpty && _pin.isNotEmpty) {
      _pin = _pin.substring(0, _pin.length - 1);
      _udpateInputState(
        InputState.progress,
      );
    } else if (_pin.length < widget.length) {
      _pin = _pin + value;
      _udpateInputState(
        InputState.progress,
      );
    }

    if (_pin.isEmpty) {
      _udpateInputState(
        InputState.initial,
        rebuild: false,
      );
    } else if (_pin.length == widget.length && widget.correctPin is String) {
      _udpateInputState(
        _pin == widget.correctPin ? InputState.success : InputState.error,
        rebuild: false,
      );
    }

    widget.onPinChanged?.call(_pin);
  }

  void _clearPin() {
    _udpateInputState(
      InputState.initial,
      rebuild: false,
    );

    setState(
      () => _pin = "",
    );
  }

  void _toggleBiometricsRequested(bool value) => setState(
        () => _biometricsRequested = value,
      );

  FutureOr<void> _requestBiometricsAuth() async {
    _toggleBiometricsRequested(true);

    try {
      final didAuthenticate = await _auth.authenticate(
        localizedReason: widget.localizedBiometricsDenyReason,
        authMessages: [
          AndroidAuthMessages(
            signInTitle: widget.biometricsUsageDescription,
            cancelButton: widget.biometricsCancelTitle,
          ),
          IOSAuthMessages(
            cancelButton: widget.biometricsCancelTitle,
          ),
        ],
      );

      _toggleBiometricsRequested(false);

      _udpateInputState(
        didAuthenticate ? InputState.success : InputState.error,
      );
    } catch (e) {
      _toggleBiometricsRequested(false);
    }
  }

  Future<void> _checkForBiometrics() async {
    final availableBiometrics = await _auth.getAvailableBiometrics();

    final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;

    final isDeviceSupported = await _auth.isDeviceSupported();

    final canAuthenticate = canAuthenticateWithBiometrics || isDeviceSupported;

    setState(
      () => _biometricsAreAvailable =
          availableBiometrics.isNotEmpty && canAuthenticate,
    );
  }

  @override
  void initState() {
    super.initState();

    _checkForBiometrics();

    if (widget.autoRequestBiometrics) {
      _requestBiometricsAuth();
    }
    _udpateInputState(widget.inputState);
  }

  @override
  void didUpdateWidget(covariant _PinView oldWidget) {
    if (oldWidget.inputState == widget.inputState) {
      return;
    }

    if (widget.inputState.isInital) {
      _clearPin();
    }

    _udpateInputState(
      widget.inputState,
      rebuild: false,
    );

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: widget.backgroudColor,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    widget.title,
                    style: widget.titleStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Shaker(
                    amplitude: widget.shakeAmplitude,
                    duration: widget.shakeDuration ??
                        Duration(
                          milliseconds:
                              (widget.errorDuration.inMilliseconds * 0.02)
                                  .toInt(),
                        ),
                    animate: _pinInputState.isError,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < widget.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7.5,
                            ),
                            child: _AnimatedDot(
                              animate: _pinInputState.isSuccess ||
                                  _pinInputState.isError ||
                                  (_pin.isNotEmpty && i == _pin.length - 1),
                              color: _pinInputState.isError
                                  ? widget.errorColor
                                  : _pinInputState.isSuccess
                                      ? widget.successColor
                                      : _pin.isNotEmpty && i < _pin.length
                                          ? widget.inputColor
                                          : widget.emptyDotColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  _Numpad(
                    onTap: _onPinChanged,
                    showBiometrics: widget.showBiometrics,
                    onBiometricsTap: _requestBiometricsAuth,
                    biometricsWidget: !_biometricsAreAvailable
                        ? null
                        : widget.biometryWidget ??
                            SvgPicture.asset(
                              package: LocalAuthConsts.packageName,
                              LocalAuthConsts.biometricsIconAssetPath,
                            ),
                    deleteButton: widget.deleteButton ??
                        SvgPicture.asset(
                          package: LocalAuthConsts.packageName,
                          LocalAuthConsts.deleteIconAssetPath,
                        ),
                    digitTextStyle: widget.digitTextStyle,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (widget.footerTitle is String)
                    _Footer(
                      footerTitle: widget.footerTitle!,
                      footerTitleTextSyle: widget.footerTitleTextSyle,
                      onTap: widget.onFooterTap,
                    ),
                  if (widget.forgotPinWidget is Widget) widget.forgotPinWidget!,
                  const SizedBox(
                    height: 42,
                  ),
                ],
              ),
            ),
            Positioned(
              child: RepaintBoundary(
                child: AnimatedOpacity(
                  opacity: _biometricsRequested ? 1 : 0,
                  duration: const Duration(milliseconds: 100),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Container(),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
