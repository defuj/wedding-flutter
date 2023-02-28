import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
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
                  sm: 3,
                  md: 3,
                  lg: 3,
                  child: Image.asset('assets/images/component-1.png'),
                ),
                SpGridItem(
                  padding: EdgeInsets.symmetric(
                    horizontal: edgeByWidth(
                      context: context,
                      xs: 65,
                      sm: 65,
                      md: 30,
                      lg: 160,
                      xl: 160,
                    ),
                  ),
                  xs: 12,
                  sm: 6,
                  md: 6,
                  lg: 6,
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
                                'assets/images/client.png',
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
                        textAlign: TextAlign.center,
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
                  sm: 3,
                  md: 3,
                  lg: 3,
                  child: Image.asset('assets/images/component-2.png'),
                ),
              ],
            ),
            Visibility(
              visible: viewModel.userName.isNotEmpty,
              child: SelectionArea(
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
                              child:
                                  Image.asset('assets/images/component-7.png'),
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
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
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
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
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
                        child: Image.asset('assets/images/component-8.png'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SelectionArea(
              child: SpGrid(
                margin: const EdgeInsets.only(top: 56),
                width: MediaQuery.of(context).size.width,
                children: [
                  SpGridItem(
                    xs: 0,
                    sm: 0,
                    md: 3,
                    lg: 3,
                    child: Image.asset('assets/images/component-3.png'),
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
                          'The honor of  your presence is requested at the marriage of:',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                  color: IColors.pink50,
                                  fontSize: edgeByWidth(
                                    context: context,
                                    xs: 16,
                                    sm: 16,
                                    md: 24,
                                    lg: 32,
                                    xl: 32,
                                  ),
                                  fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Muhammad Syauqi Alsunni, S.Sos.',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                  color: Colors.black,
                                  fontSize: edgeByWidth(
                                    context: context,
                                    xs: 35,
                                    sm: 35,
                                    md: 40,
                                    lg: 56,
                                    xl: 56,
                                  ),
                                  fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'The son of (Alm) H.Djoni Darwin Sutan Alamsyah & Hj. Susy Kemala',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                  color: Colors.black,
                                  fontSize: edgeByWidth(
                                    context: context,
                                    xs: 14,
                                    sm: 14,
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
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                  color: Colors.black,
                                  fontSize: edgeByWidth(
                                    context: context,
                                    xs: 35,
                                    sm: 35,
                                    md: 40,
                                    lg: 56,
                                    xl: 56,
                                  ),
                                  fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'The daughter of dr. Amnur Rajo Kayo, MKM & Haslinda, SE',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                  color: Colors.black,
                                  fontSize: edgeByWidth(
                                    context: context,
                                    xs: 14,
                                    sm: 14,
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
                    child: Image.asset('assets/images/component-4.png'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 56),
            SelectionArea(
              child: SpGrid(
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
                            'Akad Nikah/ Marriage Ceremony',
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
                            children: [
                              const Icon(
                                Icons.access_time_filled_rounded,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '08.00 - 10.00',
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
                          const SizedBox(height: 24),
                          AspectRatio(
                            aspectRatio: edgeByWidth(
                              context: context,
                              xs: 1 / 1,
                              sm: 1 / 1,
                              md: 16 / 9,
                              lg: 16 / 9,
                              xl: 16 / 9,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: const CameraPosition(
                                    target: LatLng(-0.3287901, 100.3660321),
                                    zoom: 16),
                                markers: {
                                  maps.Marker(
                                    markerId: maps.MarkerId('$UniqueKey'),
                                    position: const maps.LatLng(
                                        -0.3287901, 100.3660321),
                                    draggable: false,
                                    onDragEnd: (value) {
                                      // value is the new position
                                    },
                                  )
                                },
                              ),
                            ),
                          )
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
                            'Baralek Kampuang/ Wedding Reception in Bukittinggi',
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
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_filled_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '15.00 - 17.00',
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
                                  'Jl. H.Agus Salim no 1A, Bukittinggi, Sumatera Barat.',
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
                          const SizedBox(height: 24),
                          AspectRatio(
                            aspectRatio: edgeByWidth(
                              context: context,
                              xs: 1 / 1,
                              sm: 1 / 1,
                              md: 16 / 9,
                              lg: 16 / 9,
                              xl: 16 / 9,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: const CameraPosition(
                                    target: LatLng(-0.3070926, 100.3689357),
                                    zoom: 16),
                                markers: {
                                  maps.Marker(
                                    markerId: maps.MarkerId('$UniqueKey'),
                                    position: const maps.LatLng(
                                        -0.3070926, 100.3689357),
                                    draggable: false,
                                  )
                                },
                              ),
                            ),
                          )
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
                            'Pesta Resepsi/Wedding Reception in Jakarta',
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
                                'Sunday, 12 March 2023',
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
                  SpGridItem(
                    xs: 12,
                    sm: 12,
                    md: 6,
                    lg: 6,
                    child: AspectRatio(
                      aspectRatio: edgeByWidth(
                        context: context,
                        xs: 1 / 1,
                        sm: 1 / 1,
                        md: 16 / 9,
                        lg: 16 / 9,
                        xl: 16 / 9,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: const CameraPosition(
                              target: LatLng(-6.2277417, 106.8338776),
                              zoom: 16),
                          markers: {
                            maps.Marker(
                              markerId: maps.MarkerId('$UniqueKey'),
                              position:
                                  const maps.LatLng(-6.2277417, 106.8338776),
                              draggable: false,
                            )
                          },
                        ),
                      ),
                    ),
                  ),
                ],
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
                                    xs: 24,
                                    sm: 24,
                                    md: 35,
                                    lg: 40,
                                    xl: 40,
                                  ),
                                  fontWeight: FontWeight.w400),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
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
                                          md: 18,
                                          lg: 24,
                                          xl: 24,
                                        ),
                                        fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Image.asset(
                                  'assets/images/bank-bca.png',
                                  width: 200,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SelectionArea(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.person_outline_rounded,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Puti Kayo Gebriecya',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: edgeByWidth(
                                                context: context,
                                                xs: 14,
                                                sm: 14,
                                                md: 18,
                                                lg: 20,
                                                xl: 20,
                                              ),
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              SelectionArea(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.credit_card_rounded,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '2170025043',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: edgeByWidth(
                                                context: context,
                                                xs: 14,
                                                sm: 14,
                                                md: 18,
                                                lg: 20,
                                                xl: 20,
                                              ),
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                      xs: 24,
                      sm: 24,
                      md: 35,
                      lg: 40,
                      xl: 40,
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
                  InputFormText(
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
                    child: InputFormText(
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
            Container(
              width: MediaQuery.of(context).size.width,
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
                  xs: 8,
                  sm: 8,
                  md: 8,
                  lg: 12,
                  xl: 12,
                ),
                crossAxisSpacing: edgeByWidth(
                  context: context,
                  xs: 8,
                  sm: 8,
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
                            child: Column(
                              children: [
                                Text(
                                  viewModel.showedComments[i].commentContent!,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                ),
                              ],
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
                    child: Image.asset('assets/images/component-5.png'),
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
                    child: Image.asset('assets/images/component-6.png'),
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
