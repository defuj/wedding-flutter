import 'package:wedding/repositories.dart';

class InputText extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final Function(String?)? onSaved;
  final String? initialValue;
  final String? hintText;
  final int? maxLength;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? padding;
  final TextInputAction? textInputAction;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final BoxBorder? border;
  final double? width;
  final double? height;
  final TextAlign? textAlign;
  final TextEditingController? controller;
  final TextAlignVertical? textAlignVertical;
  final Widget? suffixIcon;
  final Function()? suffixAction;
  final Function()? onTap;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enabled;
  const InputText({
    super.key,
    this.onSaved,
    this.controller,
    this.textAlign = TextAlign.start,
    this.width = double.infinity,
    this.height = 50,
    this.onChanged,
    this.hintText = '',
    this.initialValue = '',
    this.maxLength = 50,
    this.keyboardType = TextInputType.text,
    this.minLines = 1,
    this.maxLines = 1,
    this.prefixIcon,
    this.textStyle,
    this.hintStyle,
    this.padding = const EdgeInsets.only(left: 14),
    this.textInputAction = TextInputAction.done,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textAlignVertical = TextAlignVertical.center,
    this.border = const Border.fromBorderSide(
      BorderSide(color: IColors.gray50),
    ),
    this.suffixIcon,
    this.suffixAction,
    this.onTap,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: widget.padding,
        decoration: const BoxDecoration(
          color: IColors.gray50,
          // borderRadius: BorderRadius.all(Radius.circular(8.0)),
          // border: widget.border,
        ),
        child: TextField(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          controller: widget.controller,
          textAlign: widget.textAlign!,
          onEditingComplete: widget.onEditingComplete,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          textAlignVertical: widget.textAlignVertical,
          style: widget.textStyle ??
              Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: IColors.gray500),
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon != null
                ? IconButton(
                    onPressed: widget.suffixAction ?? () {},
                    icon: widget.suffixIcon != null
                        ? widget.suffixIcon!
                        : const Icon(Icons.close_rounded),
                  )
                : null,
            prefixIcon: widget.prefixIcon,
            counterText: '',
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: IColors.gray400),
          ),
        ),
      ),
    );
  }
}
