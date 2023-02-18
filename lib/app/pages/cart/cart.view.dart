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
    return FlutterWebFrame(
      maximumSize: Size(475, MediaQuery.of(context).size.height),
      builder: (context) => Scaffold(
        backgroundColor: IColors.pinkBackground,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: IColors.pink50,
          title: Text(
            'Keranjang',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Get.toNamed('/menus');
            },
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: viewModel.cart.isNotEmpty,
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ButtonPrimary(
              text: 'Selesaikan Proses Pemesanan',
              onPressed: () => viewModel.submitMenu(),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: viewModel.cart.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/svg/main.svg',
                          width: 24,
                          height: 24,
                          color: IColors.pink50,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Main Course',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: IColors.pink50,
                                  fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                itemCount: viewModel.cart
                    .where((element) => element.menu!.categoryID == '2')
                    .toList()
                    .length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final menu = viewModel.cart
                      .where((element) => element.menu!.categoryID == '2')
                      .toList()[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                menu.menu!.menuCoverPicture ?? '',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/no_image_placeholder.png',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menu.menu!.menuName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: viewModel.mainCourseNotSelected.isNotEmpty,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Peringatan',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: IColors.pink50,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${viewModel.mainCourseNotSelected} Belum meilih ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Main Course',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: IColors.pink50),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: viewModel.cart.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/svg/appetizer.svg',
                          width: 24,
                          height: 24,
                          color: IColors.pink50,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Appetizer',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: IColors.pink50,
                                  fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                itemCount: viewModel.cart
                    .where((element) => element.menu!.categoryID == '1')
                    .toList()
                    .length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final menu = viewModel.cart
                      .where((element) => element.menu!.categoryID == '1')
                      .toList()[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                menu.menu!.menuCoverPicture ?? '',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/no_image_placeholder.png',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menu.menu!.menuName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${menu.members!.length} orang memilih',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    children: [
                                      for (var member in menu.members!)
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 8, bottom: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: IColors.pink50_,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            member.memberName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit_note_rounded,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: viewModel.appetizerNotSelected.isNotEmpty,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Peringatan',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: IColors.pink50,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${viewModel.appetizerNotSelected} Belum meilih ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Appetizer',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: IColors.pink50),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: viewModel.cart.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/svg/dessert.svg',
                          width: 24,
                          height: 24,
                          color: IColors.pink50,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Dessert',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: IColors.pink50,
                                  fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: viewModel.dessertNotSelected.isNotEmpty,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Peringatan',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: IColors.pink50,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${viewModel.dessertNotSelected} Belum meilih ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Dessert',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: IColors.pink50),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: viewModel.cart.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/svg/drink.svg',
                          width: 24,
                          height: 24,
                          color: IColors.pink50,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Drink',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: IColors.pink50,
                                  fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: viewModel.drinkNotSelected.isNotEmpty,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Peringatan',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: IColors.pink50,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${viewModel.drinkNotSelected} Belum meilih ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Drink',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: IColors.pink50),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: viewModel.cart.isEmpty,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  height: MediaQuery.of(context).size.height - 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/foods.svg',
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        'Keranjangnya masih kosong, Silahkan tambahkan menu terlebih dahulu!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: IColors.black100,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
