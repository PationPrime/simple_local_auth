// ignore_for_file: unused_element

part of 'auth_view.dart';

class _DefaultHeader extends StatelessWidget {
  final bool showLeading;
  final VoidCallback? onLeadingTap;
  final Widget? title;
  final bool centerTitle;

  const _DefaultHeader({
    super.key,
    this.title,
    this.showLeading = true,
    this.onLeadingTap,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: centerTitle,
        leading: !showLeading
            ? null
            : GestureDetector(
                onTap: onLeadingTap,
                child: Container(
                  height: 47,
                  width: 47,
                  color: Colors.transparent,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFFB3B8BD),
                  ),
                ),
              ),
        title: title,
      );
}
