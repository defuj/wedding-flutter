import 'dart:developer';

import 'package:wedding/repositories.dart';

class RegisterViewModel extends ViewModel {
  String _userName = 'John Doe';
  String get userName => _userName;
  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  List<String> sessions = [
    'Sesi 1 (11:00 s.d 13:00) 120 kuota tersisa',
    'Sesi 2 (13:00 s.d 15:00) 120 kuota tersisa',
    'Sesi 3 (15:00 s.d 17:00) 120 kuota tersisa',
  ];

  String _selectedSession = '';
  String get selectedSession => _selectedSession;
  set selectedSession(String value) {
    _selectedSession = value;
    notifyListeners();
  }

  String _phoneNumber = '082240645000';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  List<MemberModel> _members = List<MemberModel>.empty(growable: true);
  List<MemberModel> get members => _members;
  set members(List<MemberModel> value) {
    _members = value;
    notifyListeners();
  }

  void showSessionList() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 24,
                    top: 16,
                  ),
                  height: 4,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: IColors.neutral20,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ),
              Text(
                'Silahkan pilih sesi',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: IColors.gray800,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'open-sans',
                    ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      selectedSession = sessions[index];
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selectedSession == sessions[index]
                            ? IColors.gray50
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        sessions[index],
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: IColors.black80,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'open-sans',
                            ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      }),
    );
  }

  void updateMemberName(String value, int index) {
    members[index].memberName = value;
  }

  void addNewMember() {
    members.add(MemberModel(
      memberID: '${members.length + 1}',
    ));
    notifyListeners();
  }

  void removeMember(int index) {
    log('removeMember: $index');
    log('memberLength: ${members.length}');
    var list = members;
    list.removeAt(index);

    members = list;
    // members.removeAt(index);
    // members = members;
  }

  void chooseFoods() {
    if (selectedSession.isEmpty) {
      SweetDialog(
        context: context,
        title: 'Belum memilih sesi',
        content: 'Silahkan pilih sesi terlebih dahulu',
        dialogType: SweetDialogType.error,
      ).show();
      return;
    }

    Get.toNamed(
      '/foods',
      arguments: {
        'userName': userName,
        'phoneNumber': phoneNumber,
        'members': members,
      },
    );
  }

  @override
  void init() {
    try {
      final args = Get.arguments;
      if (args != null) {
        userName = args['userName'];
        phoneNumber = args['phoneNumber'];
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onDependenciesChange() {}

  @override
  void onBuild() {}

  @override
  void onMount() {}

  @override
  void onUnmount() {}

  @override
  void onResume() {}

  @override
  void onPause() {}

  @override
  void onInactive() {}

  @override
  void onDetach() {}
}
