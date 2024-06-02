// ignore_for_file: unused_element

part of 'auth_view.dart';

class _Footer extends StatelessWidget {
  final String footerTitle;
  final TextStyle? footerTitleTextSyle;
  final VoidCallback? onTap;

  const _Footer({
    super.key,
    required this.footerTitle,
    this.footerTitleTextSyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          height: 30,
          width: 200,
          child: Center(
            child: Text(
              footerTitle,
              textAlign: TextAlign.center,
              style: footerTitleTextSyle,
            ),
          ),
        ),
      );
}
