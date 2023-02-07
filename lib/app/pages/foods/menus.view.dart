import 'package:wedding/repositories.dart';

class Menus extends StatelessWidget {
  const Menus({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<MenusViewModel>(
      view: () => const _View(),
      viewModel: MenusViewModel(),
    );
  }
}

class _View extends StatelessView<MenusViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [],
        ),
      ),
    );
  }
}
