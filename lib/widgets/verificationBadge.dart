import 'package:flutter/material.dart';
import 'package:pix/ui/theme/theme.dart';

class VerificationBadge extends StatelessWidget {
  final double size;
  final Color? color;
  final bool showTooltip;
  final String? tooltipMessage;

  const VerificationBadge({
    Key? key,
    this.size = 16,
    this.color,
    this.showTooltip = true,
    this.tooltipMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? TwitterColor.dodgerBlue;
    
    Widget badge = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: size * 0.7,
      ),
    );

    if (showTooltip) {
      return Tooltip(
        message: tooltipMessage ?? 'Verified Account',
        child: badge,
      );
    }

    return badge;
  }
}

class VerificationBadgeAnimated extends StatefulWidget {
  final double size;
  final Color? color;
  final bool showTooltip;
  final String? tooltipMessage;
  final Duration animationDuration;

  const VerificationBadgeAnimated({
    Key? key,
    this.size = 16,
    this.color,
    this.showTooltip = true,
    this.tooltipMessage,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<VerificationBadgeAnimated> createState() => _VerificationBadgeAnimatedState();
}

class _VerificationBadgeAnimatedState extends State<VerificationBadgeAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final badgeColor = widget.color ?? TwitterColor.dodgerBlue;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        Widget badge = Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value * 2 * 3.14159,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: badgeColor.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: widget.size * 0.7,
              ),
            ),
          ),
        );

        if (widget.showTooltip) {
          return Tooltip(
            message: widget.tooltipMessage ?? 'Verified Account',
            child: badge,
          );
        }

        return badge;
      },
    );
  }
}

// Helper widget to show verification status in user profiles
class UserVerificationStatus extends StatelessWidget {
  final bool isVerified;
  final String userName;
  final double badgeSize;
  final TextStyle? nameStyle;
  final bool showAnimatedBadge;

  const UserVerificationStatus({
    Key? key,
    required this.isVerified,
    required this.userName,
    this.badgeSize = 16,
    this.nameStyle,
    this.showAnimatedBadge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          userName,
          style: nameStyle ?? const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (isVerified) ...[
          const SizedBox(width: 4),
          showAnimatedBadge
              ? VerificationBadgeAnimated(size: badgeSize)
              : VerificationBadge(size: badgeSize),
        ],
      ],
    );
  }
}