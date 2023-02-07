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
    return Scaffold(
      backgroundColor: IColors.pinkBackground,
      appBar: appBar(
        title: 'Silahkan lanjutkan registrasi',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Kamu:',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w600, color: IColors.gray800),
              ),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_rounded,
                    color: IColors.pink50,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.userName,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color: IColors.gray800,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'open-sans'),
                        ),
                        Text(
                          viewModel.phoneNumber,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: IColors.gray800,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'open-sans'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Tambah Anggota:',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w600, color: IColors.gray800),
              ),
              //   for (var index = 0; index < viewModel.members.length; index++)
              //     Container(
              //       margin: const EdgeInsets.only(top: 8),
              //       width: double.infinity,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Nama Lengkap',
              //             textAlign: TextAlign.start,
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodyText2!
              //                 .copyWith(color: Colors.black),
              //           ),
              //           const SizedBox(height: 4),
              //           InputText(
              //             suffixAction: () => viewModel.removeMember(index),
              //             suffixIcon: Container(
              //               padding: const EdgeInsets.symmetric(
              //                 horizontal: 2,
              //                 vertical: 2,
              //               ),
              //               decoration: BoxDecoration(
              //                 color: IColors.black100,
              //                 borderRadius: BorderRadius.circular(16),
              //               ),
              //               child: const Icon(
              //                 Icons.close_rounded,
              //                 color: Colors.white,
              //                 size: 14,
              //               ),
              //             ),
              //             height: 44,
              //             padding: const EdgeInsets.only(
              //               left: 0,
              //               right: 0,
              //             ),
              //             keyboardType: TextInputType.name,
              //             textInputAction: TextInputAction.done,
              //             onChanged: (value) =>
              //                 viewModel.updateMemberName(value, index),
              //             hintText: 'Masukkan nama lengkap',
              //             initialValue: viewModel.members[index].memberName,
              //             prefixIcon: Container(
              //               color: IColors.pink50,
              //               padding: const EdgeInsets.symmetric(
              //                 horizontal: 12,
              //                 vertical: 13,
              //               ),
              //               margin: const EdgeInsets.only(right: 8),
              //               child: const Icon(
              //                 Icons.person_outline_rounded,
              //                 color: Colors.white,
              //                 size: 18,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewModel.members.length,
                itemBuilder: (context, index) {
                  final member = viewModel.members[index];
                  final controller =
                      TextEditingController(text: member.memberName);
                  return Container(
                    key: UniqueKey(),
                    margin: const EdgeInsets.only(top: 8),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Lengkap',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 4),
                        InputText(
                          controller: controller,
                          suffixAction: () => viewModel.removeMember(index),
                          suffixIcon: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: IColors.black100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                          height: 44,
                          padding: const EdgeInsets.only(
                            left: 0,
                            right: 0,
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) =>
                              viewModel.updateMemberName(value, index),
                          hintText: 'Masukkan nama lengkap',
                          prefixIcon: Container(
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
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: InkWell(
                  onTap: viewModel.addNewMember,
                  child: Container(
                    width: 180,
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
                          'Tambah Anggota',
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
                    fontWeight: FontWeight.w600, color: IColors.gray800),
              ),
              const SizedBox(height: 6),
              Text(
                'Pilih waktu kedatangan',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w400, color: IColors.gray800),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: viewModel.showSessionList,
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
                              viewModel.selectedSession.isEmpty
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
                height: 44,
                child: ButtonPrimary(
                  text: 'Lajut Pilih Makan',
                  onPressed: () => viewModel.chooseFoods(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
