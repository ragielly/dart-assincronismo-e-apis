class Account {
  String id;
  String name;
  String lastName;
  double balance;

  Account({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
  });
//map converter para account
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map["id"],
      name: map["name"],
      lastName: map["lastName"],
      balance: (map['balance'] as num).toDouble(),

    );
  }

//account converter para map
  Map<String, dynamic> toMap(){
    return<String, dynamic>{
      "id" : id,
      "name" : name,
      "lastName" : lastName,
      "balance" : balance,
    };
  }
  @override
  String toString(){
    return "\n Conta: $id \n Nome: $name $lastName \n Saldo: $balance)";
  }
  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.lastName == lastName &&
        other.balance == balance;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ lastName.hashCode ^ balance.hashCode;
  }
}
