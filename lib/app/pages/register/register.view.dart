import 'package:wedding/repositories.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<RegisterViewModel>(
      view: () => const _View(),
      viewModel: RegisterViewModel(),
    );
  }
}

class _View extends StatelessView<RegisterViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return FlutterWebFrame(
      maximumSize: Size(475, MediaQuery.of(context).size.height),
      builder: (context) => Scaffold(
        backgroundColor: IColors.pinkBackground,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Perhatian!',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: IColors.pink50,
                            fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Silahkan tambahkan data diri anda beserta anggota keluarga/lainnya, yang akan hadir',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Nama Kamu:',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  'Panggilan',
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                ),
                InkWell(
                  onTap: () => viewModel.changeMyNickName(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  hoverColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      color: IColors.gray50,
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            color: IColors.pink50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 13,
                            ),
                            margin: const EdgeInsets.only(right: 8),
                            child: const Icon(
                              Icons.person_outline_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          Expanded(
                            child: Text(viewModel.userNickname.isEmpty
                                ? 'Pilih panggilan'
                                : viewModel.userNickname),
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
                Text(
                  'Nama Lengkap',
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(height: 4),
                InputFormText(
                  initialValue: viewModel.userName,
                  height: 50,
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 0,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    if (viewModel.dataIsReady) viewModel.userName = value;
                  },
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Container(
                    height: 50,
                    color: IColors.pink50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 13,
                    ),
                    margin: const EdgeInsets.only(right: 8),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Tambah Anggota?',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 20),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: viewModel.members.length,
                  itemBuilder: (context, index) {
                    final member = viewModel.members[index];
                    return Container(
                      key: UniqueKey(),
                      margin: const EdgeInsets.only(bottom: 8),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            'Panggilan',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                          ),
                          InkWell(
                            onTap: () => viewModel.showNicknameDialog(index),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            hoverColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: IColors.gray50,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      color: IColors.pink50,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 13,
                                      ),
                                      margin: const EdgeInsets.only(right: 8),
                                      child: const Icon(
                                        Icons.person_outline_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                          viewModel.members[index].nickname ??
                                              'Pilih panggilan'),
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
                          Text(
                            'Nama Lengkap',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(height: 4),
                          InkWell(
                            onTap: () => viewModel.writeMemberName(
                                index, member.memberName ?? ''),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            hoverColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: IColors.gray50,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      color: IColors.pink50,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 13,
                                      ),
                                      margin: const EdgeInsets.only(right: 8),
                                      child: const Icon(
                                        Icons.person_outline_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(member.memberName ??
                                          'Masukan nama lengkap'),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          viewModel.removeMember(index),
                                      icon: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 2,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: IColors.black100,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    hoverColor: Colors.transparent,
                    onTap: viewModel.addNewMember,
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: IColors.pink50_,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_circle_outline_rounded,
                            color: IColors.pink50,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Tambah',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: IColors.pink50),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Waktu Kedatangan:',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 20),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pilih waktu kedatangan',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w400, color: IColors.gray800),
                ),
                const SizedBox(height: 4),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  hoverColor: Colors.transparent,
                  onTap: viewModel.showSessionList,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: IColors.black5,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            color: IColors.pink50,
                            child: const Icon(
                              Icons.access_time_rounded,
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
                                viewModel.selectedSession == 0
                                    ? 'Pilih waktu kedatangan'
                                    : viewModel.selectedSessionName,
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
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  child: ButtonPrimary(
                    text: 'Lanjut Pilih Makan',
                    onPressed: () => viewModel.chooseFoods(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
