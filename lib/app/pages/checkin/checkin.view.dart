import 'package:wedding/repositories.dart';

class Checkin extends StatelessWidget {
  const Checkin({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<CheckinViewModel>(
      view: () => const _View(),
      viewModel: CheckinViewModel(),
    );
  }
}

class _View extends StatelessView<CheckinViewModel> {
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
                      lg: 20,
                      xl: 20,
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
                                width: 150,
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
                              width: 340,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Muhammad Syauqi Alsunni, S.Sos.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '&',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: IColors.pink50,
                            fontSize: 24,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Puti Kayo Gebriecya, B.Sc.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
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
            const SizedBox(height: 24),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Silahkan posisikan kode QR undangan kamu di dalam bingkai',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            // const SizedBox(height: 20),
            SpGrid(
              alignment: WrapAlignment.center,
              width: MediaQuery.of(context).size.width,
              children: [
                SpGridItem(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  xs: 12,
                  sm: 12,
                  md: 4,
                  lg: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Text(
                              'Kursi Tersedia',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '10',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: IColors.pink50,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Sedang Berlangsung',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sesi 1 (09:00 sd 11:00)',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: IColors.pink50,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SpGridItem(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  xs: 12,
                  sm: 12,
                  md: 4,
                  lg: 4,
                  child: ClipRRect(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: QRView(
                          overlayMargin: EdgeInsets.zero,
                          cameraFacing: CameraFacing.front,
                          key: viewModel.qrKey,
                          onQRViewCreated: viewModel.onQRViewCreated,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
