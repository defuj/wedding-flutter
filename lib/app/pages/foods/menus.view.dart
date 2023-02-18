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
    return FlutterWebFrame(
      maximumSize: const Size(475, 1080),
      builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 28,
                  ),
                  decoration: const BoxDecoration(
                    color: IColors.pinkBackground,
                    image: DecorationImage(
                      image: AssetImage('assets/images/hero.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Silahkan Pilih Menu,\n${capitalize(viewModel.userName)}',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: IColors.black100,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24),
                          ),
                        ),
                      ),
                      InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            Get.toNamed('/cart');
                          },
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Stack(
                              children: [
                                const Center(
                                  child: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 30,
                                    color: IColors.black100,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Visibility(
                                    visible: viewModel.cartCount != 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: IColors.pink50,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      width: 24,
                                      height: 24,
                                      child: Center(
                                        child: Text(
                                          viewModel.cartCount.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .overline!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 35,
                  color: IColors.pinkBackground,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.categories.length,
                    itemBuilder: (context, index) {
                      final category = viewModel.categories[index];
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          viewModel.categorySelected = category;
                          viewModel.getMenus();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: category.categoryID ==
                                    viewModel.categorySelected.categoryID
                                ? IColors.pink50
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                category.categoryIcon!,
                                width: 24,
                                height: 24,
                                color: category.categoryID ==
                                        viewModel.categorySelected.categoryID
                                    ? Colors.white
                                    : IColors.pink50,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                category.categoryName ?? '-',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: category.categoryID ==
                                              viewModel
                                                  .categorySelected.categoryID
                                          ? Colors.white
                                          : IColors.pink50,
                                      fontWeight: category.categoryID ==
                                              viewModel
                                                  .categorySelected.categoryID
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: !viewModel.isLoading,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    width: double.infinity,
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: [
                        for (var i = 0; i < viewModel.menus.length; i++)
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            hoverColor: Colors.transparent,
                            onTap: () =>
                                viewModel.loadMenuDetail(viewModel.menus[i]),
                            child: Container(
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1 / 0.9,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      child: Image.network(
                                        viewModel.menus[i].menuCoverPicture!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          color: IColors.black10,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6.2),
                                  Text(
                                    viewModel.menus[i].menuName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: IColors.green800,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8.2),
                                  Row(
                                    children: [
                                      Text(
                                        'Selengkapnya',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: IColors.pink50,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: IColors.pink50,
                                        size: 14,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: viewModel.isLoading,
              child: const Center(
                child: CircularProgressIndicator(color: IColors.pink50),
              ),
            ),
            Visibility(
              visible: viewModel.menus.isEmpty && !viewModel.isLoading,
              child: Container(
                margin: const EdgeInsets.only(top: 200),
                height: MediaQuery.of(context).size.height - 200,
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/foods.svg',
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        'Tidak ada menu tersedia untuk kategori ini',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: IColors.black100,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
