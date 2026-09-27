class Account {
  final String name;
  final String email;
  final String password;

  Account({required this.name, required this.email, required this.password});
}

class AccountStore {
  AccountStore._();

  static final List<Account> _accounts = [];

  /// Adds (or overwrites, if the email is already used) an account.
  static void register(Account account) {
    _accounts.removeWhere(
        (a) => a.email.toLowerCase() == account.email.toLowerCase());
    _accounts.add(account);
  }

  static Account? findByEmail(String email) {
    for (final a in _accounts) {
      if (a.email.toLowerCase() == email.toLowerCase()) return a;
    }
    return null;
  }

  /// Returns the matching account if email + password are correct,
  /// otherwise null.
  static Account? authenticate(String email, String password) {
    final account = findByEmail(email);
    if (account != null && account.password == password) {
      return account;
    }
    return null;
  }
}
