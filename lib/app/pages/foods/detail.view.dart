import 'package:wedding/repositories.dart';

Widget _buildChip(
    {required MemberModel member,
    required BuildContext context,
    required Function() onDelete}) {
  return Chip(
    onDeleted: onDelete,
    deleteIcon: const Icon(
      Icons.close_rounded,
      color: Colors.black,
      size: 16,
    ),
    deleteButtonTooltipMessage: 'Hapus',
    deleteIconColor: Colors.black,
    labelPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    label: Text(
      member.memberName!,
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
    ),
    backgroundColor: IColors.pink50_,
    elevation: 0,
    shadowColor: Colors.black,
  );
}

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        context: context,
        title: 'Detail Menu',
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          carouselSliderHome(banner: viewModel.banners),
          const SizedBox(height: 16),
          Wrap(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: IColors.pink50_,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Sisa : ${viewModel.menu.menuStock}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: IColors.black100, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${viewModel.menu.menuName}',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ingredients:',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              viewModel.menu.menuDesc!.isEmpty ? '-' : viewModel.menu.menuDesc!,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Untuk Siapa Aja?',
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            hoverColor: Colors.transparent,
            onTap: () => viewModel.showMemberList(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: IColors.black5,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        color: IColors.pink50,
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: Text(
                            'Pilih Anggota',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: IColors.gray800),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: IColors.gray800,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: [
                for (var i = 0; i < viewModel.memberSelected.length; i++)
                  _buildChip(
                    context: context,
                    member: viewModel.memberSelected[i],
                    onDelete: () =>
                        viewModel.deleteMember(viewModel.memberSelected[i]),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Catatan :',
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InputText(
              height: 80,
              maxLength: 500,
              maxLines: 50,
              minLines: 5,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
              hintText: 'Masukan Catatan',
              onChanged: (value) => viewModel.note = value,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '*Kasih nama untuk catatan, cth: Yusup: pedas',
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: IColors.gray400),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 56,
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ButtonPrimary(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
              text: 'Masukan Ke Keranjang',
              onPressed: () => viewModel.checkStock(),
            ),
          ),
        ],
      ),
    );
  }
}
