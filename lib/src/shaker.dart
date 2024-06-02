part of 'auth_view.dart';

class Shaker extends StatefulWidget {
  final Widget child;
  final bool animate;
  final int shakeCount;
  final Duration duration;
  final double amplitude;

  const Shaker({
    super.key,
    required this.child,
    this.animate = false,
    this.shakeCount = 3,
    this.duration = const Duration(milliseconds: 50),
    this.amplitude = 10.0,
  });

  @override
  State<Shaker> createState() => _ShakerState();
}

class _ShakerState extends State<Shaker> with SingleTickerProviderStateMixin {
  late final AnimationController _shakeAnimationController;
  late final Animation<double> _shakeAnimation;

  int _currentShake = 0;

  void _initAnimation() {
    _shakeAnimationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _shakeAnimation = Tween(
      begin: 0.0,
      end: widget.amplitude,
    ).animate(
      _shakeAnimationController,
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _shakeAnimationController.reverse().whenComplete(
              () {
                if (_currentShake < widget.shakeCount) {
                  _shakeAnimationController.forward();
                  _currentShake++;
                } else {
                  _currentShake = 0;
                }
              },
            );
          }
        },
      );
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant Shaker oldWidget) {
    if (widget.animate) {
      _shakeAnimationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _shakeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (buildContext, child) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          padding: EdgeInsets.only(
            left: _currentShake % 2 == 0
                ? _shakeAnimation.value + widget.amplitude
                : widget.amplitude - _shakeAnimation.value,
            right: _currentShake % 2 == 0
                ? widget.amplitude - _shakeAnimation.value
                : _shakeAnimation.value + widget.amplitude,
          ),
          child: widget.child,
        ),
      );
}
