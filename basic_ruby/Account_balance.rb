class Customer
  @@num_accounts = 0

  def initialize(name)
    @name = name
    @balance = 1000
    @account_no = @@num_accounts += 1
  end

  def deposit(credit)
    @balance += credit
    puts "Deposit successful"
  end

  def withdrawal(debit)
    if debit <= @balance
      @balance -= debit
      puts "Withdrawal successful"
    else
      puts "Balance is less"
    end
  end
end