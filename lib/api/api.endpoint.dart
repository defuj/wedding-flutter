class ApiEndPoints {
  static const String checkWhatsApp = '/reservasi/checkwa';
  static const String submitReservasion = '/reservasi/submit';
  String getMenus({required String idCategory}) => '/menu/category/$idCategory';
  String getMember({required String reservasionID}) =>
      '/reservasi/load_anggota/$reservasionID';
  static const String addMember = '/reservasi/submit_anggota';
  static const String getSessions = '/reservasi/load_sesi';
  static const String submitMenus = '/menu/submit';
  static const String submitComment = '/comment/submit';
  static const String getComments = '/comment/load';
}
