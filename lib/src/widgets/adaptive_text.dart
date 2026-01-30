import 'package:flutter/widgets.dart';

import '../extensions/num_ext.dart';

/// A text widget that automatically scales based on screen size.
///
/// ```dart
/// AdaptiveText(
///   'Hello World',
///   style: TextStyle(fontSize: 16), // This will scale automatically
/// )
/// ```
class AdaptiveText extends StatelessWidget {
  /// Creates an adaptive text widget.
  const AdaptiveText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.scaleText = true,
  });

  /// The text to display.
  final String data;

  /// Text style. Font size will be scaled if [scaleText] is true.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Maximum number of lines.
  final int? maxLines;

  /// Alternative text for accessibility.
  final String? semanticsLabel;

  /// Whether to scale the font size. Default is true.
  final bool scaleText;

  @override
  Widget build(BuildContext context) {
    AdaptiveContext.setContext(context);

    final effectiveStyle = style ?? const TextStyle();
    final scaledStyle = scaleText && effectiveStyle.fontSize != null
        ? effectiveStyle.copyWith(fontSize: effectiveStyle.fontSize!.asp)
        : effectiveStyle;

    return Text(
      data,
      style: scaledStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
    );
  }
}

/// A rich text widget that automatically scales based on screen size.
class AdaptiveRichText extends StatelessWidget {
  /// Creates an adaptive rich text widget.
  const AdaptiveRichText(
    this.textSpan, {
    super.key,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.scaleText = true,
  });

  /// The text span to display.
  final InlineSpan textSpan;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  final bool softWrap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// Maximum number of lines.
  final int? maxLines;

  /// Whether to scale the font size. Default is true.
  final bool scaleText;

  InlineSpan _scaleSpan(InlineSpan span) {
    if (span is TextSpan) {
      final style = span.style;
      final scaledStyle = scaleText && style?.fontSize != null
          ? style!.copyWith(fontSize: style.fontSize!.asp)
          : style;

      return TextSpan(
        text: span.text,
        style: scaledStyle,
        children: span.children?.map(_scaleSpan).toList(),
        recognizer: span.recognizer,
        mouseCursor: span.mouseCursor,
        onEnter: span.onEnter,
        onExit: span.onExit,
        semanticsLabel: span.semanticsLabel,
        locale: span.locale,
        spellOut: span.spellOut,
      );
    }
    return span;
  }

  @override
  Widget build(BuildContext context) {
    AdaptiveContext.setContext(context);

    final scaledSpan = scaleText ? _scaleSpan(textSpan) : textSpan;

    return RichText(
      text: scaledSpan,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
