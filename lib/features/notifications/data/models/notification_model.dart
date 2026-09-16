class NotificationModel {
  const NotificationModel({required this.title, required this.message, required this.time, this.read = false});

  final String title;
  final String message;
  final String time;
  final bool read;

  static const samples = [
    NotificationModel(title: 'Bem-vindo à KUVORE', message: 'Seu acesso está pronto. Explore suas opções de proteção.', time: 'Agora'),
    NotificationModel(title: 'Sua área de seguros está disponível', message: 'Conheça nossas opções de cotação e contratação.', time: 'Hoje'),
    NotificationModel(title: 'Dica de segurança', message: 'Mantenha seus dados de acesso protegidos.', time: 'Ontem', read: true),
  ];
}
