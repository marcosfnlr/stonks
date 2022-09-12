import 'currency.dart';
import 'wallet.dart';

class User {
  String name;
  String email;
  String preferredLanguage;
  final Wallet _wallet;

  User(this.name, this.email)
      : preferredLanguage = 'English',
        _wallet = Wallet(49.07, Currency.brl);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name']!, json['email']!);
  }

  double get balance {
    return _wallet.balance;
  }

  String get currencySymbol {
    return _wallet.currency.symbol;
  }

  String get currencyLabel {
    return _wallet.currency.label;
  }

  String get currencyString {
    return '$currencyLabel - $currencySymbol';
  }
}
