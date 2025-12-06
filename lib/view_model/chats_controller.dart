import 'package:get/get.dart';
import 'package:servicehub/repository/chat_repository.dart';
import 'package:servicehub/model/chat_models.dart';

class ChatsController extends GetxController {
  final _repo = ChatRepository();
  final items = <ChatMeta>[].obs;
  final names = <String, String>{}.obs;

  String get myId => _repo.currentUserId();

  @override
  void onInit() {
    _repo.streamChats(myId).listen((list) async {
      items.assignAll(list);
      for (final m in list) {
        if (!names.containsKey(m.otherUserID)) {
          final n = await _repo.getUserName(m.otherUserID);
          names[m.otherUserID] = n;
        }
      }
    });
    super.onInit();
  }
}
