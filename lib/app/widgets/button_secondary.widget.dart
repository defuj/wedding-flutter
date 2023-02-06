import 'package:wedding/repositories.dart';

class ButtonSecondary extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  const ButtonSecondary(
      {super.key, required this.text, required this.onPressed, this.textStyle});

  @override
  State<ButtonSecondary> createState() => _ButtonSecondaryState();
}

class _ButtonSecondaryState extends State<ButtonSecondary> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        shadowColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        selectedRowColor: Colors.transparent,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          backgroundColor: IColors.black5,
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
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black45),
        ),
      ),
    );
  }
}
