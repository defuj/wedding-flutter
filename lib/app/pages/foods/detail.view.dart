import 'package:wedding/repositories.dart';

class MenuDetail extends StatelessWidget {
  const MenuDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<MenuDetailViewModel>(
      view: () => const _View(),
      viewModel: MenuDetailViewModel(),
    );
  }
}

class _View extends StatelessView<MenuDetailViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return const Scaffold();
  }
}
