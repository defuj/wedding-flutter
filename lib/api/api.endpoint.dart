class ApiEndPoints {
  static const String checkWhatsApp = '/reservasi/checkwa';
  static const String submitReservasion = '/reservasi/submit';
  String getMenus({required String idCategory}) => '/menu/category/$idCategory';
  String loadMember({required String idReservasion}) =>
      'reservasi/load_anggota/$idReservasion';
  static const String addMember = '/reservasi/submit_anggota';
  static const String getSessions = '/reservasi/load_sesi';
  static const String submitMenus = '/menu/submit';
}
