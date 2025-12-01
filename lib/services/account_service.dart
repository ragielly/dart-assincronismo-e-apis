import 'dart:async';

import 'package:dart_asynchronous/api_key.dart';
import 'package:dart_asynchronous/models/account.dart';
import 'package:http/http.dart';
import 'dart:convert';

class AccountService {
  final StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;
  String url = "https://api.github.com/gists/2e6a49b0e6403d1188084e027ec1c975";

  Future<List<Account>> getAll() async {
    
    Response response = await get(Uri.parse(url));
    _streamController.add("${DateTime.now()} | Requisição Leitura }");

    Map<String, dynamic> mapResponse = json.decode(response.body);

    List<dynamic> listDynamic = json.decode(
      mapResponse["file"]["accounts.json"]["content"],
    );

    List<Account> listAccounts = [];

    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapAccount = dyn as Map<String, dynamic>;
      Account account = Account.fromMap(mapAccount); // transforma em um objeto account
      listAccounts.add(account);
    }

    return listAccounts;
  }

   addAccount(Account account) async {
    List<dynamic> listAccounts = await getAll();
    listAccounts.add(account);
    
    List<Map<String,dynamic>> listContent = [];
    for(Account account in listAccounts){
      listContent.add(account.toMap());
    }

    String content = json.encode(listContent);

    Response response = await post(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $gitHubApiKey"},
      body: json.encode({
        "description": "accounts.json",
        "public": true,
        "files": {
          "accounts.json": {"content": content},
        },
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      _streamController.add(
        "${DateTime.now()} | Requisição adição bem sucedida ${account.name} .",
      );
    } else {
      _streamController.add("${DateTime.now()} | Requisição adição falhou ${account.name} .");
    }
  }
}
