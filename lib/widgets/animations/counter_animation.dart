import 'package:flutter/material.dart';

class CounterAnimation extends StatefulWidget {
  final double target;
  final String suffix;
  final String prefix;
  final Duration duration;
  final TextStyle? style;

  const CounterAnimation({
    super.key,
    required this.target,
    this.suffix = '',
    this.prefix = '',
    this.duration = const Duration(milliseconds: 2000),
    this.style,
  });

  @override
  State<CounterAnimation> createState() => _CounterAnimationState();
}

class _CounterAnimationState extends State<CounterAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: 0, end: widget.target).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final value = _animation.value;
        final display = widget.target >= 1000
            ? (value / 1000).toStringAsFixed(0)
            : value.toStringAsFixed(0);
        final suffix = widget.target >= 1000 ? 'K${widget.suffix}' : widget.suffix;
        return Text(
          '${widget.prefix}$display$suffix',
          style: widget.style,
        );
      },
    );
  }
}
