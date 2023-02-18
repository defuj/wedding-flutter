import 'dart:developer';

import 'package:wedding/repositories.dart';

class InvitationViewModel extends ViewModel {
  late ApiProvider apiProvider;
  late SweetDialog loading;

  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  String _userName = '';
  String get userName => _userName;
  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  String _userAddress = '';
  String get userAddress => _userAddress;
  set userAddress(String value) {
    _userAddress = value;
    notifyListeners();
  }

  String _userSession = '';
  String get userSession => _userSession;
  set userSession(String value) {
    _userSession = value;
    notifyListeners();
  }

  String _fullName = '';
  String get fullName => _fullName;
  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  String _comment = '';
  String get comment => _comment;
  set comment(String value) {
    _comment = value;
    notifyListeners();
  }

  List<CommentModel> _comments = List<CommentModel>.empty(growable: true);
  List<CommentModel> get comments => _comments;
  set comments(List<CommentModel> value) {
    _comments = value;
    notifyListeners();
    showMoreComment();
  }

  List<CommentModel> _showedComments = List<CommentModel>.empty(growable: true);
  List<CommentModel> get showedComments => _showedComments;
  set showedComments(List<CommentModel> value) {
    _showedComments = value;
    notifyListeners();
  }

  void enterReservation() {
    Get.toNamed('/enter');
  }

  void showMoreComment() {
    if (comments.length > 6) {
      // check if current comments list if add 6 comment is equals with comments master length
      if (showedComments.length + 6 >= comments.length) {
        showedComments = comments;
      } else {
        List<CommentModel> newComments =
            List<CommentModel>.empty(growable: true);
        for (var i = 0; i < showedComments.length + 6; i++) {
          final comment = comments[i];
          newComments.add(comment);
        }
        showedComments = newComments;
      }
    } else {
      showedComments = comments;
    }
  }

  void fetchComment() async {
    await apiProvider.fetchComment().then((value) {
      comments = value.reversed.toList();
      log(value.length.toString());
    }, onError: (err) {
      log(err);
      comments = List<CommentModel>.empty(growable: true);
      showedComments = List<CommentModel>.empty(growable: true);
    });
  }

  void sendComment() async {
    if (fullName.isEmpty) {
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Nama tidak boleh kosong',
        content: 'Silahkan masukan nama lengkap kamu',
      ).show();
      return;
    }

    if (comment.isEmpty) {
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Komentar tidak boleh kosong',
        content: 'Silahkan masukan komentar kamu',
      ).show();
      return;
    }

    loading.show();
    await apiProvider.sendComment(name: fullName, comment: comment).then(
        (value) {
      log(value.toString());
      loading.dismiss();
      nameController.text = '';
      commentController.text = '';
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.success,
        title: 'Berhasil',
        content: 'Komentar berhasil dikirim',
      ).show();
      fetchComment();
    }, onError: (e) {
      log(e.toString());
      loading.dismiss();
      SweetDialog(
        context: context,
        dialogType: SweetDialogType.error,
        title: 'Gagal',
        content: e,
      ).show();
    });
  }

  @override
  void init() {
    apiProvider = getApiProvider;
    loading = SweetDialog(
      context: context,
      dialogType: SweetDialogType.loading,
      barrierDismissible: false,
    );
    Future.delayed(Duration.zero, () {
      fetchComment();
      try {
        userName = Get.parameters['nama'] ?? '';
      } catch (e) {
        log(e.toString());
      }

      try {
        userAddress = Get.parameters['alamat'] ?? '';
      } catch (e) {
        log(e.toString());
      }

      try {
        userSession = Get.parameters['sesi'] ?? '';
      } catch (e) {
        log(e.toString());
      }
    });
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
