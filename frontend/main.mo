import Debug "mo:base/Debug";

actor ProjectBudget {
  // Переменные состояния
  var totalIncome: Nat = 0;           // Общий доход (числовая)
  var totalExpenses: Nat = 0;         // Общие расходы (числовая)
  var transactions: [(Text, Nat, Text)] = [];  // Список транзакций: (тип, сумма, комментарий)

  // Функция: добавить доход
  public func addIncome(amount: Nat, comment: Text) : Bool {
    if (amount == 0) {
      Debug.print("Ошибка: сумма дохода не может быть 0");
      return false;
    };
    totalIncome += amount;
    transactions := (transactions # [( "income", amount, comment )]);
    Debug.print("Доход добавлен: " # Debug.show(amount) # " (" # comment # ")");
    return true;
  };

  // Функция: добавить расход
  public func addExpense(amount: Nat, comment: Text) : Bool {
    if (amount == 0) {
      Debug.print("Ошибка: сумма расхода не может быть 0");
      return false;
    };
    if (amount > totalIncome - totalExpenses) {
      Debug.print("Ошибка: недостаточно средств для расхода " # Debug.show(amount));
      return false;
    };
    totalExpenses += amount;
    transactions := (transactions # [( "expense", amount, comment )]);
    Debug.print("Расход добавлен: " # Debug.show(amount) # " (" # comment # ")");
    return true;
  };

  // Функция: получить текущий баланс
  public func getBalance() : Nat {
    return totalIncome - totalExpenses;
  };

  // Функция: вывести все транзакции
  public func listTransactions() : [(Text, Nat, Text)] {
    return transactions;
  };
};
