import 'dart:async';

import 'package:dart_asynchronous/api_key.dart';
import 'package:dart_asynchronous/models/account.dart';
import 'package:http/http.dart';
import 'dart:convert';

class accountService {
  final StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;
  String url = "https://api.github.com/gists/2e6a49b0e6403d1188084e027ec1c975";

  Future<List<dynamic>> gettAll() async {
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

  void addAccount(Map<String, dynamic> mapAccount) async {
    List<dynamic> listAccounts = await gettAll();
    listAccounts.add(mapAccount);
    String content = json.encode(listAccounts);

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
        "${DateTime.now()} | Requisição adição bem sucedida ${mapAccount["name"]} .",
      );
    } else {
      _streamController.add("${DateTime.now()} | Requisição adição falhou .");
    }
  }
}
