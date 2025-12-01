import 'package:dart_asynchronous/models/account.dart';
import 'package:dart_asynchronous/services/account_service.dart';
import 'dart:io';

class AccountScreeen {
  final AccountService _accountService = AccountService();

  void inicializeStream() {
    _accountService.streamInfos.listen(
      (event) {
      print(event);
    });
  }

  void runChatBot() async {
    print("Bom dia! Eu sou o Lewis, assistente do Banco d'Ouro!");
    print("Que bom te ter aqui com a gente.\n");

    bool isRunning = true;

    while (isRunning) {
      print("Como eu posso te ajudar? (digite o número desejado)");
      print("1 - Ver todas sua contas.");
      print("2 - Adicionar nova conta.");
      print("3 - Sair\n");
      String? input = stdin.readLineSync();

      if (input != null) {
        switch (input) {
          case "1":
            await _getAllAccount();
            break;
          case "2":
           await _addExempleAccount();
            break;
          case "3":
            print("Nos vemos na proxima");
            isRunning = false;
            break;
          default:
            print("Opção Invalida");
        }
      }
    }
  }

  _getAllAccount() async {
    List<Account> listAccounts = await _accountService.getAll();
    print(listAccounts);
  }

  _addExempleAccount() async {
    Account example = Account(
      id: "ID555",
      name: "Haley",
      lastName: "Chirívia",
      balance: 800,
    );

    await _accountService.addAccount(example);
  }
}
