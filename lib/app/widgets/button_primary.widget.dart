import 'package:wedding/repositories.dart';

class ButtonPrimary extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final TextStyle? textStyle;
  const ButtonPrimary({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.color = IColors.pink50,
  });

  @override
  State<ButtonPrimary> createState() => _ButtonPrimaryState();
}

class _ButtonPrimaryState extends State<ButtonPrimary> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        minimumSize: const Size.fromHeight(45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style: widget.textStyle ??
            Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
