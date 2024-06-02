// ignore_for_file: unused_element

part of 'auth_view.dart';

class _Digit extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;

  const _Digit({
    super.key,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(1000),
      onTap: onTap,
      splashColor: const Color(
        0xFF000000,
      ).withOpacity(
        0.1,
      ),
      highlightColor: Colors.transparent,
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
