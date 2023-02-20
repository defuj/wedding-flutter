import 'package:wedding/repositories.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<LoginViewModel>(
      view: () => const _View(),
      viewModel: LoginViewModel(),
    );
  }
}

class _View extends StatelessView<LoginViewModel> {
  const _View({key}) : super(key: key, reactive: true);

  @override
  Widget render(context, viewModel) {
    return FlutterWebFrame(
      maximumSize: Size(475, MediaQuery.of(context).size.height),
      builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/component-3.png',
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 30,
                              top: 24,
                            ),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/client.png',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/images/component-9.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/images/component-22.png',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    'Muhammad Syauqi Alsunni, S.Sos.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '&',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: IColors.pink50),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Puti Kayo Gebriecya, B.Sc.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(top: 32),
                    decoration: const BoxDecoration(
                      color: IColors.pinkBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Untuk memverifikasi undangan harap masukan nomor Handphone',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.black,
                                  fontFamily: 'SourceSansPro'),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nomor Handphone',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 4),
                        InputText(
                          height: 50,
                          padding: const EdgeInsets.only(
                            left: 0,
                            right: 16,
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) => viewModel.phoneNumber = value,
                          hintText: '62 xxxx xxxx xxx',
                          prefixIcon: Container(
                            height: 50,
                            color: IColors.pink50,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 13,
                            ),
                            margin: const EdgeInsets.only(right: 8),
                            child: const Icon(
                              Icons.phone_android_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Note: Sertakan kode negara',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 50,
                          child: ButtonPrimary(
                            text: 'Lanjutkan',
                            onPressed: viewModel.validatePhone,
                          ),
                        ),
                      ],
                    ),
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
