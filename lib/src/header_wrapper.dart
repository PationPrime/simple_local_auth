// ignore_for_file: unused_element

part of 'auth_view.dart';

class _HeaderWrapper extends StatelessWidget implements PreferredSizeWidget {
  final Size? size;
  final Widget child;

  const _HeaderWrapper({
    super.key,
    this.size,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static const _kDefaultAppBarHeight = 80.0;

  @override
  Size get preferredSize =>
      size ?? const Size.fromHeight(_kDefaultAppBarHeight);
}
