import 'package:flutter/material.dart';

/// Implementation of [Card] using the new [MaterialStateProperty] for handling
/// and reacting to user interactions.
class InteractiveCard extends StatefulWidget {
  const InteractiveCard({
    Key? key,
    this.color,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
  }) : super(key: key);

  final MaterialStateProperty<Color>? color;

  final MaterialStateProperty<Color>? shadowColor;

  final MaterialStateProperty<double>? elevation;

  final MaterialStateProperty<ShapeBorder>? shape;

  final bool borderOnForeground;

  final Clip? clipBehavior;

  final EdgeInsetsGeometry? margin;

  final bool semanticContainer;

  final Widget? child;

  @override
  _InteractiveCardState createState() => _InteractiveCardState();
}

class _InteractiveCardState extends State<InteractiveCard> {
  final Set<MaterialState> _states = <MaterialState>{};

  void _updateState(MaterialState state, bool value) {
    value ? _states.add(state) : _states.remove(state);
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _updateState(MaterialState.pressed, true);
    });
  }

  void _handleTapCancel() {
    setState(() {
      _updateState(MaterialState.pressed, false);
    });
  }

  void _handleTap() {
    setState(() {
      _updateState(MaterialState.pressed, false);
    });
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _updateState(MaterialState.hovered, isHovered);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CardTheme cardTheme = CardTheme.of(context);

    return Semantics(
      container: widget.semanticContainer,
      child: Container(
        margin: widget.margin ?? cardTheme.margin ?? const EdgeInsets.all(4.0),
        child: Material(
          type: MaterialType.card,
          shadowColor: widget.shadowColor?.resolve(_states) ??
              cardTheme.shadowColor ??
              theme.shadowColor,
          color: widget.color?.resolve(_states) ??
              cardTheme.color ??
              theme.cardColor,
          elevation:
              widget.elevation?.resolve(_states) ?? cardTheme.elevation ?? 1.0,
          shape: widget.shape?.resolve(_states) ??
              cardTheme.shape ??
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
          borderOnForeground: widget.borderOnForeground,
          clipBehavior:
              widget.clipBehavior ?? cardTheme.clipBehavior ?? Clip.none,
          child: MouseRegion(
            onExit: (_) => _handleHover(false),
            onHover: (_) => _handleHover(true),
            child: GestureDetector(
              onTapDown: _handleTapDown,
              onTap: _handleTap,
              onTapCancel: _handleTapCancel,
              child: Semantics(
                explicitChildNodes: !widget.semanticContainer,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardButtonColor extends MaterialStateColor {
  const CardButtonColor() : super(_defaultColor);

  static const int _defaultColor = 0xFFF44336;
  static const int _pressedColor = 0xFFFFFFFF;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}

class CardBorder extends RoundedRectangleBorder
    implements MaterialStateProperty<RoundedRectangleBorder> {
  const CardBorder() : super(borderRadius: _defaultValue);

  static const _defaultValue = const BorderRadius.all(Radius.circular(12.0));

  @override
  RoundedRectangleBorder resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0));
    } else {
      return RoundedRectangleBorder(borderRadius: _defaultValue);
    }
  }
}
