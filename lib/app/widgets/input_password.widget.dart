import 'package:wedding/repositories.dart';

class InputPassword extends StatefulWidget {
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
  const InputPassword({
    super.key,
    this.onSaved,
    this.controller,
    this.textAlign = TextAlign.start,
    this.width = double.infinity,
    this.height = 50,
    this.onChanged,
    this.hintText = 'Masukan Kata Sandi',
    this.initialValue = '',
    this.maxLength = 50,
    this.keyboardType = TextInputType.visiblePassword,
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
  });

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  final _obscureText = true.obs;
  void changeVisibility() {
    _obscureText.value = !_obscureText.value;
  }

  var errorText = ''.obs;

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
          //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
          //   border: Border.fromBorderSide(
          //     BorderSide(color: IColors.black10),
          //   ),
        ),
        child: Obx(
          () => TextFormField(
            controller: widget.controller,
            textAlign: widget.textAlign!,
            onFieldSubmitted: widget.onFieldSubmitted,
            onEditingComplete: widget.onEditingComplete,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            textAlignVertical: widget.textAlignVertical,
            initialValue: widget.initialValue,
            obscureText: _obscureText.value,
            obscuringCharacter: '*',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: IColors.gray500),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () => changeVisibility(),
                icon: Icon(
                  _obscureText.value
                      ? Icons.visibility_outlined
                      : Icons.visibility,
                  color: _obscureText.value
                      ? IColors.neutral60
                      : IColors.neutral10,
                ),
              ),
              prefixIcon: widget.prefixIcon,
              counterText: '',
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: IColors.gray400),
            ),
          ),
        ),
      ),
    );
  }
}
