import 'dart:async';

import 'package:flutter/material.dart';

class KFButton extends StatefulWidget {
  final Widget? child;
  final Function? onTap;
  final Function? onLongTap;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;
  final bool effect;
  final bool forbidFastClick;
  final Duration forbidFastClickTime;
  final Function? onForbidFastClick;
  const KFButton({
    Key? key,
    this.onTap,
    this.onLongTap,
    this.child,
    this.alignment,
    this.padding,
    this.color= const Color(0x00000000),
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.clipBehavior=Clip.none,
    this.forbidFastClickTime= const Duration(milliseconds: 1500),
    this.effect = false,
    this.forbidFastClick=false,
    this.onForbidFastClick
  }) : super(key: key);

  @override
  _KFButtonState createState() => _KFButtonState();
}

class _KFButtonState extends State<KFButton> with TickerProviderStateMixin {
  bool _isChangeAlpha = false;

  AnimationController? _controller;
  late Animation _animation;
  double effectTarget = 0.8;
  bool _isClickEnable = true;
  Timer? _timer;
  DateTime? _lastDateTime;
  @override
  void initState() {
    _controller = AnimationController(value: 1, vsync: this);
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOutCubic,
    );
    _animation.addListener(() {
      setState(() {});
    });
    if(widget.effect){
      effectTarget = 0.4;
    }
    super.initState();
  }

  bool _tapDown = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = const Duration(milliseconds: 50);
    Duration showDuration = const Duration(milliseconds: 660);

    return GestureDetector(
      onTap: () async {
        if (widget.forbidFastClick) {
          if (_lastDateTime == null) {
            widget.onTap?.call();
            setState(() {
              _lastDateTime = DateTime.now();
            });
          } else {
            var _currentDateTime = DateTime.now();
            Duration _duration = _currentDateTime.difference(_lastDateTime!);
            if (_duration.inMilliseconds > widget.forbidFastClickTime.inMilliseconds) {
              widget.onTap?.call();
            }else{
              widget.onForbidFastClick?.call();
            }
            setState(() {
              _lastDateTime = DateTime.now();
            });
          }
        } else {
          widget.onTap?.call();
        }
      },
      onLongPress: widget.onLongTap == null
          ? null
          : () async {
        await Future.delayed(const Duration(milliseconds: 100));
        widget.onLongTap!();
      },
      onTapDown: (detail) async {
        _tapDown = true;
        _isChangeAlpha = true;
        await _controller!.animateTo(effectTarget, duration: duration);
        if (!_tapDown) {
          await _controller!.animateTo(1, duration: showDuration);
        }
        _tapDown = false;
        _isChangeAlpha = false;
      },
      onTapUp: (detail) async {
        _tapDown = false;
        if (_isChangeAlpha == true) {
          return;
        }
        await _controller!.animateTo(1, duration: showDuration);
        _isChangeAlpha = false;
      },
      onTapCancel: () async {
        _tapDown = false;
        _controller!.value = 1;
        _isChangeAlpha = false;
      },
      child: Opacity(
        opacity: _animation.value,
        child: Container(
          alignment: widget.alignment,
          padding: widget.padding,
          color:widget.decoration==null?widget.color:null,
          decoration: widget.decoration,
          foregroundDecoration: widget.foregroundDecoration,
          width: widget.width,
          height: widget.height,
          constraints: widget.constraints,
          margin: widget.margin,
          transform: widget.transform,
          transformAlignment: widget.transformAlignment,
          clipBehavior: widget.clipBehavior,
          child: widget.child,
        ),
      ),
    );
  }
}
