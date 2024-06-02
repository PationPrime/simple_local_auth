// ignore_for_file: unused_element

part of 'auth_view.dart';

class _Numpad extends StatelessWidget {
  final bool showBiometrics;
  final Widget? biometricsWidget;
  final Widget? deleteButton;
  final TextStyle? digitTextStyle;
  final double minWidth;
  final double maxWidth;
  final Function(String)? onTap;
  final VoidCallback? onBiometricsTap;

  const _Numpad({
    super.key,
    this.showBiometrics = true,
    this.biometricsWidget,
    this.deleteButton,
    this.digitTextStyle,
    this.minWidth = 300,
    this.maxWidth = 300,
    this.onTap,
    this.onBiometricsTap,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 7,
          spacing: 35,
          children: [
            for (int i = 1; i < 13; i++)
              _Digit(
                onTap: i == 10
                    ? showBiometrics
                        ? onBiometricsTap?.call
                        : null
                    : () => onTap?.call(
                          i == 11
                              ? "0"
                              : i == 12
                                  ? ""
                                  : "$i",
                        ),
                child: i == 10
                    ? showBiometrics
                        ? biometricsWidget
                        : null
                    : i == 12
                        ? deleteButton
                        : Text(
                            i == 11 ? "0" : "$i",
                            style: digitTextStyle,
                          ),
              ),
          ],
        ),
      );
}
