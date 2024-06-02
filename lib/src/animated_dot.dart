// ignore_for_file: unused_element

part of 'auth_view.dart';

class _AnimatedDot extends StatefulWidget {
  final bool animate;
  final Color color;

  const _AnimatedDot({
    super.key,
    required this.color,
    required this.animate,
  });

  @override
  State<_AnimatedDot> createState() => __AnimatedDotState();
}

class __AnimatedDotState extends State<_AnimatedDot>
    with TickerProviderStateMixin {
  late final AnimationController _scaleAnimationController;
  late final Animation<double> _scaleAnimation;

  void _initAnimation() {
    _scaleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
      lowerBound: 0.4,
      upperBound: 1.0,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant _AnimatedDot oldWidget) {
    if (widget.animate) {
      _scaleAnimationController.forward().whenComplete(
            _scaleAnimationController.reverse,
          );
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: 22,
          width: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
      );
}
