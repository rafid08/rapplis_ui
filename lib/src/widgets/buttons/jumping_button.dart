import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JumpingButton extends StatefulWidget {
  const JumpingButton({
    Key? key,
    required this.child,
    this.onTap,
    this.scale=0.1,
    this.haptic=false,
    this.clipRadius,
    this.dismissKeyboard=true,
    this.bound = true,
    this.longTap = false,
    this.doubleHaptic = false,
  }) : assert(scale>=0 && scale<1), super(key: key);

  final Widget? child;
  final bool dismissKeyboard;
  final VoidCallback? onTap;
  final double scale;
  final bool haptic;
  final double? clipRadius;
  final bool bound;
  final bool longTap;
  final bool doubleHaptic;

  @override
  State<JumpingButton> createState() => _JumpingButtonState();
}

class _JumpingButtonState extends State<JumpingButton> with SingleTickerProviderStateMixin {

  double? _scale;
  late AnimationController _controller;

  late bool enabled;

  double radius = 0;

  @override
  void initState() {
    enabled = widget.onTap!=null;
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 1 - widget.scale,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant JumpingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.onTap!=oldWidget.onTap){
      enabled = widget.onTap!=null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    if(widget.clipRadius!=null)  radius = _controller.value*300;

    Widget? child = widget.child;
    if(widget.bound) child = ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);

    return Listener(
      onPointerDown: (_) {
        if(enabled){
          if(widget.dismissKeyboard) FocusManager.instance.primaryFocus?.unfocus();
          _controller.forward();
          if (widget.haptic) HapticFeedback.lightImpact();
        }
      },
      onPointerUp: (_) {
        if(enabled){
          _controller.reverse();
          if (widget.haptic && widget.doubleHaptic) HapticFeedback.lightImpact();
        }
      },
      child: GestureDetector(
        onTapDown: !widget.longTap?null:(_){
          if(enabled){
            if(widget.dismissKeyboard) FocusManager.instance.primaryFocus?.unfocus();
            _controller.forward();
            if (widget.haptic) HapticFeedback.lightImpact();
          }
        },
        onTapCancel: !widget.longTap?null:() {
          if(enabled){
            _controller.reverse();
            if (widget.haptic && widget.doubleHaptic) HapticFeedback.lightImpact();
          }
        },
        onTap: enabled&&!widget.longTap?widget.onTap:null,
        onLongPress: widget.longTap?widget.onTap:null,
        child: Transform.scale(
          scale: _scale,
          child: child,
        ),
      ),
    );
  }
}