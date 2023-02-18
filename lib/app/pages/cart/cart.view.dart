import 'package:wedding/repositories.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<CartViewModel>(
      view: () => const _View(),
      viewModel: CartViewModel(),
    );
  }
}

class _View extends StatelessView<CartViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return const Scaffold();
  }
}
