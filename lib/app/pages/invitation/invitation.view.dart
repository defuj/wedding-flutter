import 'package:wedding/repositories.dart';

class Invitation extends StatelessWidget {
  const Invitation({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<InvitationViewModel>(
      view: () => const _View(),
      viewModel: InvitationViewModel(),
    );
  }
}

class _View extends StatelessView<InvitationViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return Scaffold(
      backgroundColor: IColors.pinkBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpGrid(
              width: MediaQuery.of(context).size.width,
              children: [
                SpGridItem(
                  xs: 0,
                  sm: 0,
                  md: 4,
                  lg: 4,
                  child: Positioned.fill(
                    left: 0,
                    top: 0,
                    child: Image.asset('assets/images/component-1.png'),
                  ),
                ),
                SpGridItem(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  xs: 12,
                  sm: 12,
                  md: 4,
                  lg: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 40,
                              left: 10,
                              right: 10,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/sample.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/images/component-9.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'RSVP is a must/ Wajib Reservasi',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 200,
                        height: edgeByWidth(
                          context: context,
                          xs: 40,
                          sm: 40,
                          md: 50,
                          lg: 50,
                          xl: 50,
                        ),
                        child: ButtonPrimary(
                          textStyle:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                  color: Colors.white,
                                  fontSize: edgeByWidth(
                                    context: context,
                                    xs: 16,
                                    sm: 16,
                                    md: 16,
                                    lg: 20,
                                    xl: 20,
                                  ),
                                  fontWeight: FontWeight.w400),
                          text: 'RSVP / Reservasi',
                          onPressed: () => viewModel.enterReservation(),
                        ),
                      ),
                    ],
                  ),
                ),
                SpGridItem(
                  xs: 0,
                  sm: 0,
                  md: 4,
                  lg: 4,
                  child: Positioned.fill(
                    right: 0,
                    top: 0,
                    child: Image.asset('assets/images/component-2.png'),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: viewModel.userName.isNotEmpty,
              child: Center(
                child: SpGrid(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: edgeByWidth(
                      context: context,
                      xs: 16,
                      sm: 16,
                      md: 16,
                      lg: 120,
                      xl: 120,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  children: [
                    SpGridItem(
                      xs: 0,
                      sm: 0,
                      md: 1,
                      lg: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 100),
                            child: Image.asset('assets/images/component-7.png'),
                          ),
                        ],
                      ),
                    ),
                    SpGridItem(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      xs: 12,
                      sm: 12,
                      md: 10,
                      lg: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Dear, ',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: IColors.pink50,
                                      fontWeight: FontWeight.w400,
                                      fontSize: edgeByWidth(
                                        context: context,
                                        xs: 16,
                                        sm: 16,
                                        md: 24,
                                        lg: 32,
                                        xl: 32,
                                      ),
                                    ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            viewModel.userName,
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: edgeByWidth(
                                      context: context,
                                      xs: 40,
                                      sm: 40,
                                      md: 45,
                                      lg: 56,
                                      xl: 56,
                                    )),
                          ),
                          const SizedBox(height: 11),
                          Visibility(
                            visible: viewModel.userAddress.isNotEmpty,
                            child: Text(
                              viewModel.userAddress,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: edgeByWidth(
                                        context: context,
                                        xs: 16,
                                        sm: 16,
                                        md: 18,
                                        lg: 22,
                                        xl: 22,
                                      )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SpGridItem(
                      xs: 0,
                      sm: 0,
                      md: 1,
                      lg: 1,
                      child: Positioned.fill(
                        left: 0,
                        top: 0,
                        child: Image.asset('assets/images/component-8.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SpGrid(
              margin: const EdgeInsets.only(top: 56),
              width: MediaQuery.of(context).size.width,
              children: [
                SpGridItem(
                  xs: 0,
                  sm: 0,
                  md: 3,
                  lg: 3,
                  child: Positioned.fill(
                    left: 0,
                    top: 0,
                    child: Image.asset('assets/images/component-3.png'),
                  ),
                ),
                SpGridItem(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  xs: 12,
                  sm: 12,
                  md: 6,
                  lg: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'You’re invited to the wedding of:',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: IColors.pink50,
                            fontSize: edgeByWidth(
                              context: context,
                              xs: 18,
                              sm: 18,
                              md: 35,
                              lg: 40,
                              xl: 40,
                            ),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Muhammad Syauqi Alsunni, S.Sos.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.black,
                            fontSize: edgeByWidth(
                              context: context,
                              xs: 40,
                              sm: 40,
                              md: 45,
                              lg: 56,
                              xl: 56,
                            ),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'The son of  (Alm) H. Djoni Darwin &  Hj. Susy Kemala',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: edgeByWidth(
                              context: context,
                              xs: 16,
                              sm: 16,
                              md: 18,
                              lg: 22,
                              xl: 22,
                            ),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '&',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: IColors.pink50,
                            fontSize: edgeByWidth(
                              context: context,
                              xs: 40,
                              sm: 40,
                              md: 45,
                              lg: 56,
                              xl: 56,
                            ),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Puti Kayo Gebriecya, B.Sc.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.black,
                            fontSize: edgeByWidth(
                              context: context,
                              xs: 40,
                              sm: 40,
                              md: 45,
                              lg: 56,
                              xl: 56,
                            ),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'The daughter of dr. Amnur Rajo Kayo, M.K.M & Haslinda, SE',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: edgeByWidth(
                              context: context,
                              xs: 16,
                              sm: 16,
                              md: 18,
                              lg: 22,
                              xl: 22,
                            ),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SpGridItem(
                  xs: 0,
                  sm: 0,
                  md: 3,
                  lg: 3,
                  child: Positioned.fill(
                    right: 0,
                    top: 0,
                    child: Image.asset('assets/images/component-4.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 56),
            SpGrid(
              spacing: 24,
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: edgeByWidth(
                  context: context,
                  xs: 16,
                  sm: 16,
                  md: 16,
                  lg: 120,
                  xl: 120,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              children: [
                SpGridItem(
                  xs: 12,
                  sm: 12,
                  md: 6,
                  lg: 6,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Marriage Ceremony/Akad Nikah',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                  color: Colors.black,
                                  fontSize: edgeByWidth(
                                    context: context,
                                    xs: 20,
                                    sm: 20,
                                    md: 24,
                                    lg: 32,
                                    xl: 32,
                                  ),
                                  fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Thursday, 2 March  2023',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: edgeByWidth(
                                        context: context,
                                        xs: 16,
                                        sm: 16,
                                        md: 18,
                                        lg: 22,
                                        xl: 22,
                                      ),
                                      fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Mesjid Rambuti, Guguak Tinggi, Agam, Sumatera Barat',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: edgeByWidth(
                                          context: context,
                                          xs: 16,
                                          sm: 16,
                                          md: 18,
                                          lg: 22,
                                          xl: 22,
                                        ),
                                        fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SpGridItem(
                  xs: 12,
                  sm: 12,
                  md: 6,
                  lg: 6,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: IColors.pink50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wedding Reception/Resepsi Pernikahan',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                  color: Colors.white,
                                  fontSize: edgeByWidth(
                                    context: context,
                                    xs: 20,
                                    sm: 20,
                                    md: 24,
                                    lg: 32,
                                    xl: 32,
                                  ),
                                  fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Selasa, 31 Januari 2023',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: edgeByWidth(
                                        context: context,
                                        xs: 16,
                                        sm: 16,
                                        md: 18,
                                        lg: 22,
                                        xl: 22,
                                      ),
                                      fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: viewModel.userSession.isNotEmpty,
                          child: const SizedBox(height: 24),
                        ),
                        Visibility(
                          visible: viewModel.userSession.isNotEmpty,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.alarm,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  viewModel.userSession,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize: edgeByWidth(
                                            context: context,
                                            xs: 16,
                                            sm: 16,
                                            md: 18,
                                            lg: 22,
                                            xl: 22,
                                          ),
                                          fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Palma One Grand Ballroom, Jl.HR Rasuna Said Kav. X-2 No. 4 Kuningan Jakarta Selatan, 12940',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: edgeByWidth(
                                          context: context,
                                          xs: 16,
                                          sm: 16,
                                          md: 18,
                                          lg: 22,
                                          xl: 22,
                                        ),
                                        fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Center(
              child: SizedBox(
                width: 200,
                height: 50,
                child: ButtonPrimary(
                  textStyle: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                      fontSize: edgeByWidth(
                        context: context,
                        xs: 16,
                        sm: 16,
                        md: 18,
                        lg: 20,
                        xl: 20,
                      ),
                      fontWeight: FontWeight.w400),
                  text: 'RSVP / Reservasi',
                  onPressed: () => viewModel.enterReservation(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: 200,
                child: Image.asset('assets/images/qr.png'),
              ),
            ),
            const SizedBox(height: 56),
            SpGrid(
              alignment: WrapAlignment.center,
              crossAlignment: WrapCrossAlignment.center,
              width: MediaQuery.of(context).size.width,
              children: [
                SpGridItem(
                  xs: 12,
                  sm: 12,
                  md: 6,
                  lg: 6,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          'Send A Gift',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                  color: Colors.black,
                                  fontSize: edgeByWidth(
                                    context: context,
                                    xs: 40,
                                    sm: 40,
                                    md: 45,
                                    lg: 56,
                                    xl: 56,
                                  ),
                                  fontWeight: FontWeight.w400),
                        ),
                        SpGrid(
                          margin: const EdgeInsets.only(top: 24, bottom: 24),
                          spacing: 16,
                          width: double.infinity,
                          alignment: WrapAlignment.center,
                          children: [
                            SpGridItem(
                              xs: 12,
                              sm: 12,
                              md: 6,
                              lg: 6,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rekening Bank',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: edgeByWidth(
                                                context: context,
                                                xs: 16,
                                                sm: 16,
                                                md: 25,
                                                lg: 32,
                                                xl: 32,
                                              ),
                                              fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Image.asset(
                                        'assets/images/bank-bca.png',
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.person_outline_rounded,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'Puti Kayo Gebriecya',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: edgeByWidth(
                                                      context: context,
                                                      xs: 16,
                                                      sm: 16,
                                                      md: 20,
                                                      lg: 22,
                                                      xl: 22,
                                                    ),
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.credit_card_rounded,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '123456789',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: edgeByWidth(
                                                    context: context,
                                                    xs: 16,
                                                    sm: 16,
                                                    md: 20,
                                                    lg: 22,
                                                    xl: 22,
                                                  ),
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(width: 16),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          splashFactory:
                                              InkRipple.splashFactory,
                                          hoverColor: Colors.transparent,
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.copy_rounded,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SpGridItem(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              xs: 12,
                              sm: 12,
                              md: 6,
                              lg: 6,
                              child: Image.asset(
                                'assets/images/qr.png',
                                height: 200,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Center(
              child: Text(
                'Make A Wish',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.black,
                    fontSize: edgeByWidth(
                      context: context,
                      xs: 40,
                      sm: 40,
                      md: 45,
                      lg: 56,
                      xl: 56,
                    ),
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: edgeByWidth(
                  context: context,
                  xs: 16,
                  sm: 16,
                  md: 16,
                  lg: 120,
                  xl: 120,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: edgeByWidth(
                          context: context,
                          xs: 16,
                          sm: 16,
                          md: 20,
                          lg: 20,
                          xl: 20,
                        ),
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  InputText(
                    controller: viewModel.nameController,
                    hintText: 'Your Full Name',
                    onChanged: (value) => viewModel.fullName = value,
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Your Wish',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: edgeByWidth(
                          context: context,
                          xs: 16,
                          sm: 16,
                          md: 20,
                          lg: 20,
                          xl: 20,
                        ),
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: InputText(
                      controller: viewModel.commentController,
                      hintText: 'Write Your Wish',
                      onChanged: (value) => viewModel.comment = value,
                      maxLines: 10,
                      maxLength: 300,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 46,
                        child: ButtonPrimary(
                          text: 'Submit',
                          onPressed: () => viewModel.sendComment(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edgeByWidth(
                  context: context,
                  xs: 16,
                  sm: 16,
                  md: 16,
                  lg: 120,
                  xl: 120,
                ),
              ),
              child: StaggeredGrid.count(
                mainAxisSpacing: edgeByWidth(
                  context: context,
                  xs: 4,
                  sm: 4,
                  md: 8,
                  lg: 12,
                  xl: 12,
                ),
                crossAxisSpacing: edgeByWidth(
                  context: context,
                  xs: 4,
                  sm: 4,
                  md: 8,
                  lg: 12,
                  xl: 12,
                ),
                crossAxisCount: edgeByWidth(
                  context: context,
                  xs: 1,
                  sm: 1,
                  md: 2,
                  lg: 3,
                  xl: 4,
                ).toInt(),
                children: [
                  for (var i = 0; i < viewModel.showedComments.length; i++)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  color: IColors.black10,
                                  child: Center(
                                    child: Text(
                                      viewModel.showedComments[i].commentName!
                                          .substring(0, 2),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      viewModel.showedComments[i].commentName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      viewModel.showedComments[i].commenyTime ==
                                              null
                                          ? '-'
                                          : viewModel
                                              .showedComments[i].commenyTime!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Expanded(
                              child: Text(
                                viewModel.showedComments[i].commentContent!,
                                maxLines: 3,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Visibility(
              visible:
                  viewModel.showedComments.length != viewModel.comments.length,
              child: const SizedBox(height: 24),
            ),
            Visibility(
              visible:
                  viewModel.showedComments.length != viewModel.comments.length,
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 46,
                  child: ButtonPrimary(
                    text: 'Load More',
                    onPressed: () => viewModel.showMoreComment(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 56),
            SpGrid(
              margin: EdgeInsets.symmetric(
                horizontal: edgeByWidth(
                  context: context,
                  xs: 16,
                  sm: 16,
                  md: 16,
                  lg: 120,
                  xl: 120,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: WrapAlignment.center,
              crossAlignment: WrapCrossAlignment.center,
              width: MediaQuery.of(context).size.width,
              children: [
                SpGridItem(
                  xs: 0,
                  sm: 0,
                  md: 3,
                  lg: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Positioned.fill(
                      left: 0,
                      bottom: 0,
                      child: Image.asset('assets/images/component-5.png'),
                    ),
                  ),
                ),
                SpGridItem(
                  xs: 12,
                  sm: 12,
                  md: 6,
                  lg: 6,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Best Regards,',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  color: IColors.pink50,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Puti Kayo',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 56,
                                  fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          'For Further Information',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: SizedBox(
                            width: 100,
                            height: 46,
                            child: ButtonPrimary(
                              text: 'Click Here',
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SpGridItem(
                  xs: 0,
                  sm: 0,
                  md: 3,
                  lg: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Positioned.fill(
                      right: 0,
                      top: 0,
                      child: Image.asset('assets/images/component-6.png'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }
}
