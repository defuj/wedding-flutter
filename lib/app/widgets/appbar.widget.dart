import 'package:wedding/repositories.dart';

Widget appBarTitle({required BuildContext context, required String title}) {
  return Text(
    title,
    style: Theme.of(context)
        .textTheme
        .headline4!
        .copyWith(color: IColors.black100, fontWeight: FontWeight.w600),
  );
}

List<Widget> appBarAction({
  required BuildContext context,
  required int cart,
  required int message,
  required int notification,
}) {
  return [
    SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: Stack(
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed('/cart'),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(6),
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: IColors.black10,
                shadowColor: Colors.transparent,
              ),
              child: const Icon(
                Icons.shopping_cart_rounded,
                color: IColors.black60,
              ),
            ),
            Visibility(
              visible: cart > 0,
              child: Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: IColors.green500,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      cart > 99 ? '99' : '$cart',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: Stack(
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed('/message'),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(6),
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: IColors.black10,
                shadowColor: Colors.transparent,
              ),
              child: const Icon(
                Icons.message,
                color: IColors.black60,
              ),
            ),
            Visibility(
              visible: message > 0,
              child: Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: IColors.green500,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      message > 99 ? '99' : '$message',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: Stack(
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed('/notification'),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(6),
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: IColors.black10,
                shadowColor: Colors.transparent,
              ),
              child: const Icon(
                Icons.notifications_rounded,
                color: IColors.black60,
              ),
            ),
            Visibility(
              visible: notification > 0,
              child: Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: IColors.green500,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      notification > 99 ? '99' : '$notification',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ];
}

PreferredSizeWidget appBar({
  required BuildContext context,
  String title = '',
  List<Widget> actions = const [],
  Function()? onBack,
  bool centerTitle = true,
  Widget? leading,
}) {
  return AppBar(
    leading: leading,
    elevation: 3,
    centerTitle: centerTitle,
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    shadowColor: IColors.blacktransparant,
    title: appBarTitle(context: context, title: title),
    actions: actions,
    // leading: IconButton(
    //   onPressed: () => onBack,
    //   icon: const Icon(
    //     Icons.arrow_back_ios_rounded,
    //     color: Colors.black,
    //   ),
    // ),
  );
}
